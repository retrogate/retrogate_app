using Grpc.Core;
using RetroGate.Protos.Shortcut.Proto.V1;
using RetroGate.SDK.Shortcut.Domain.Usecases;
using RetroGate.Grpc.Extensions;
using Google.Protobuf.WellKnownTypes;

namespace RetroGate.Grpc.Services
{
    public class ShortcutService(
        IGetAllShortcuts getAllShortcuts,
        ICreateShortcut createShortcut
    ) : Protos.Shortcut.Proto.V1.ShortcutService.ShortcutServiceBase
    {
        public override async Task<GetAllShortcutsResponse> GetAll(Empty request, ServerCallContext context)
        {
            var result = await getAllShortcuts.Call();
            return result.Match(
                Right: shortcuts =>
                {
                    var response = new GetAllShortcutsResponse();
                    response.Shortcuts.AddRangeFromDomain(shortcuts);
                    return response;
                },
                Left: error =>
                {
                    throw new RpcException(new Status(StatusCode.Internal, error.Message));
                });
        }

        public override async Task<CreateResponse> Create(CreateRequest request, ServerCallContext context)
        {
            var domainModel = request.Shortcut.ToDomain();
            var result = await createShortcut.Call(domainModel);
            
            return result.Match(
                Right: shortcut => new CreateResponse
                {
                    Shortcut = shortcut.ToProto()
                },
                Left: error => throw new RpcException(new Status(StatusCode.Internal, error.Message))
            );
        }
    }
}
