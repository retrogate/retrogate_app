using System.Collections.Concurrent;
using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using RetroGate.Grpc.Common;
using RetroGate.Grpc.Extensions;
using RetroGate.Protos.Installer.Proto.V1;
using RetroGate.SDK.Installer.Domain.Repository;
using RetroGate.SDK.Installer.Domain.Usecases;

namespace RetroGate.Grpc.Services
{
    public class InstallerService(
        IInstallGame installGame,
        IDeleteGame deleteGame,
        ICancelInstallation cancelInstallation,
        IInstallerRepository installerRepository,
        ConcurrentDictionary<string, Subscriber<InstallerEventModel>> subscribers
    ) : Protos.Installer.Proto.V1.InstallerService.InstallerServiceBase
    {
        public override async Task<InstallResponse> Install(InstallRequest request, ServerCallContext context)
        {
            var result = await installGame.Call(request.GameId, request.Replace, request.RestartSteam);
            
            return result.Match(
                Right: installPath => new InstallResponse
                {
                    InstallPath = installPath
                },
                Left: error => throw new RpcException(new Status(StatusCode.Internal, error.Message))
            );
        }

        public override async Task<Empty> Delete(DeleteRequest request, ServerCallContext context)
        {
            var paths = request.Paths.ToArray();
            var result = await deleteGame.Call(paths);
            
            return result.Match(
                Right: _ => new Empty(),
                Left: error => throw new RpcException(new Status(StatusCode.Internal, error.Message))
            );
        }

        public override async Task<Empty> Cancel(CancelRequest request, ServerCallContext context)
        {
            var result = await cancelInstallation.Call(request.Id);
            
            return result.Match(
                Right: _ => new Empty(),
                Left: error => throw new RpcException(new Status(StatusCode.Internal, error.Message))
            );
        }

        public override async Task SubscribeEvents(Empty request, IServerStreamWriter<InstallerEventModel> responseStream, ServerCallContext context)
        {
            var subscriber = new Subscriber<InstallerEventModel>();

            if(subscribers.IsEmpty)
            {
                installerRepository.OnInstallerEvent += InstallerRepository_OnInstallerEvent;
            }

            if(subscribers.TryAdd(context.Peer, subscriber))
            {
                subscribers[context.Peer] = subscriber;
                await responseStream.WriteAsync(installerRepository.LastEvent.ToProto());
            }
            else
            {
                throw new RpcException(new Status(StatusCode.AlreadyExists, "Subscriber already exists"));
            }

            try
            {
                while (!context.CancellationToken.IsCancellationRequested)
                {
                    await subscriber.DataAvailable.WaitAsync(context.CancellationToken);
                    while (subscriber.Queue.TryDequeue(out var installerEvent))
                    {
                        await responseStream.WriteAsync(installerEvent);
                    }
                }
            }
            catch (RpcException ex) when (ex.StatusCode == StatusCode.Cancelled)
            {
                // Cliente cancelou a conexão
            }
            catch (OperationCanceledException)
            {
                // Cliente cancelou a conexão
            }
            finally
            {
                // Remove o subscriber
                subscribers.TryRemove(context.Peer, out _);
                if(subscribers.IsEmpty)
                {
                    installerRepository.OnInstallerEvent -= InstallerRepository_OnInstallerEvent;
                }
            }
        }

        public void InstallerRepository_OnInstallerEvent(object? sender, SDK.Installer.Domain.Models.InstallerEventModel e)
        {
            var protoEvent = e.ToProto();
            foreach (var subscriber in subscribers.Values)
            {
                subscriber.Queue.Enqueue(protoEvent);
                subscriber.DataAvailable.Set();
            }
        }
    }
}
