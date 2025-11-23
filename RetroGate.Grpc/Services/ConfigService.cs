using Grpc.Core;
using RetroGate.SDK.Core.Domain.Usecases;
using LanguageExt;
using Google.Protobuf.WellKnownTypes;
using RetroGate.Protos.Config.Proto.V1;
using RetroGate.Grpc.Extensions;

namespace RetroGate.Grpc.Services
{
    public class ConfigService(IGetConfig getConfigUseCase, ISetConfig setConfigUseCase) : RetroGate.Protos.Config.Proto.V1.ConfigService.ConfigServiceBase
    {
        public override async Task<ConfigModel> GetConfig(Empty request, ServerCallContext context)
        {
            var result = await getConfigUseCase.Call();
            return result.Match(
                Right: config => config.ToProto(),
                Left: error =>
                {
                    throw new RpcException(new Status(StatusCode.Internal, error.Message));
                });
        }

        public override async Task<Empty> SetConfig(ConfigModel request, ServerCallContext context)
        {
            var domainConfig = request.ToDomain();
            var result = await setConfigUseCase.Call(domainConfig);
            return result.Match(
                Right: _ => new Empty(),
                Left: error =>
                {
                    throw new RpcException(new Status(StatusCode.Internal, error.Message));
                });
        }
    }
}