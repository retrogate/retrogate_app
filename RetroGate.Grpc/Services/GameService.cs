using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using RetroGate.Grpc.Extensions;
using RetroGate.Protos.Game.Proto.V1;
using RetroGate.SDK.Game.Domain.Usecases;

namespace RetroGate.Grpc.Services
{
    public class GameService(
        ICreateGame createGame,
        IFindGameByName findGameByName,
        IGetAllGames getAllGames,
        IGetGameById getGameById,
        IUpdateGame updateGame,
        IDeleteGame deleteGame,
        IGetGameImages getGameImages
    ) : Protos.Game.Proto.V1.GameService.GameServiceBase
    {
        public override async Task<GameModel> Create(GameModel request, ServerCallContext context)
        {
            var domainModel = request.ToDomain();
            var result = await createGame.Call(domainModel);
            return result.Match(
                Right: game => game.ToProto(),
                Left: error => throw new RpcException(new Status(StatusCode.Internal, error.Message))
            );
        }

        public override async Task<FindByNameResponse> FindByName(FindByNameRequest request, ServerCallContext context)
        {
            var result = await findGameByName.Call(request.Name);
            return result.Match(
                Right: games =>
                {
                    var response = new FindByNameResponse();
                    response.Games.AddRangeFromDomain(games);
                    return response;
                },
                Left: error => throw new RpcException(new Status(StatusCode.Internal, error.Message))
            );
        }

        public override async Task<GetAllResponse> GetAll(Empty request, ServerCallContext context)
        {
            var result = await getAllGames.Call();
            return result.Match(
                Right: games =>
                {
                    var response = new GetAllResponse();
                    response.Games.AddRangeFromDomain(games);
                    return response;
                },
                Left: error => throw new RpcException(new Status(StatusCode.Internal, error.Message))
            );
        }

        public override async Task<GameModel> GetById(GetByIdRequest request, ServerCallContext context)
        {
            var result = await getGameById.Call(request.Id);
            return result.Match(
                Right: game => game.ToProto(),
                Left: error => throw new RpcException(new Status(StatusCode.Internal, error.Message))
            );
        }

        public override async Task<GameModel> Update(GameModel request, ServerCallContext context)
        {
            var result = await updateGame.Call(request.ToDomain());
            return result.Match(
                Right: game => game.ToProto(),
                Left: error => throw new RpcException(new Status(StatusCode.Internal, error.Message))
            );
        }

        public override async Task<Empty> Delete(GetByIdRequest request, ServerCallContext context)
        {
            var result = await deleteGame.Call(request.Id);
            return result.Match(
                Right: _ => new Empty(),
                Left: error => throw new RpcException(new Status(StatusCode.Internal, error.Message))
            );
        }

        public override async Task<GameImagesModel> GetImages(GetImagesRequest request, ServerCallContext context)
        {
            var result = await getGameImages.Call(request.GameName);
            return result.Match(
                Right: images =>
                {
                    return images.ToProto();
                },
                Left: error => throw new RpcException(new Status(StatusCode.Internal, error.Message))
            );
        }
    }
}
