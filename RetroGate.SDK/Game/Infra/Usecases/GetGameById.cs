using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Models;
using RetroGate.SDK.Game.Domain.Repository;
using RetroGate.SDK.Game.Domain.Usecases;

namespace RetroGate.SDK.Game.Infra.Usecases
{
    public class GetGameById(IAvailableGamesRepository availableGamesRepository,
                            IInstalledGamesRepository installedGamesRepository) : IGetGameById
    {
        public Task<Either<ErrorBase, GameModel>> Call(GameSource source, string id)
        {
            switch (source)
            {
                case GameSource.AvailableGames:
                    return availableGamesRepository.GetById(id);
                case GameSource.InstalledGames:
                    return installedGamesRepository.GetById(id);
                default:
                    return Task.FromResult<Either<ErrorBase, GameModel>>(new ErrorInvalidArgument("Invalid game source."));
            }
        }
    }
}
