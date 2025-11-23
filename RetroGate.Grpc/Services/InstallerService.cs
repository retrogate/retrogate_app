using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
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
        IInstallerRepository installerRepository
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

        public override async Task SubscribeProgress(
            SubscribeProgressRequest request, 
            IServerStreamWriter<ProgressModel> responseStream, 
            ServerCallContext context)
        {
            var tcs = new TaskCompletionSource<bool>();
            
            void ProgressHandler(object? sender, SDK.Installer.Domain.Models.ProgressModel progress)
            {
                // Envia progresso apenas para o jogo solicitado
                if (progress.Id == request.GameId)
                {
                    var protoProgress = progress.ToProto();
                    responseStream.WriteAsync(protoProgress).Wait();
                    
                    // Completa a stream quando a instalação terminar ou falhar
                    if (progress.Status == SDK.Installer.Domain.Models.ProgressStatus.Completed ||
                        progress.Status == SDK.Installer.Domain.Models.ProgressStatus.Failed)
                    {
                        tcs.TrySetResult(true);
                    }
                }
            }

            try
            {
                // Registra o handler de progresso
                installerRepository.OnInstallProgressChanged += ProgressHandler;

                // Aguarda a conclusão ou cancelamento
                await Task.WhenAny(
                    tcs.Task,
                    Task.Delay(Timeout.Infinite, context.CancellationToken)
                );
            }
            catch (OperationCanceledException)
            {
                // Cliente cancelou a conexão
            }
            finally
            {
                // Remove o handler
                installerRepository.OnInstallProgressChanged -= ProgressHandler;
            }
        }
    }
}
