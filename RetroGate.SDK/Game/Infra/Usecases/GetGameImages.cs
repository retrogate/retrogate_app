using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Models;
using RetroGate.SDK.Game.Domain.Repository;
using RetroGate.SDK.Game.Domain.Usecases;

namespace RetroGate.SDK.Game.Infra.Usecases
{
    public class GetGameImages : IGetGameImages
    {
        private readonly IGameImagesRepository _gameImagesRepository;

        public GetGameImages(IGameImagesRepository gameImagesRepository)
        {
            _gameImagesRepository = gameImagesRepository;
        }

        public Task<Either<ErrorBase, GameImagesModel>> Call(string gameName)
        {
            return _gameImagesRepository.GetGameImages(gameName);
        }
    }
}