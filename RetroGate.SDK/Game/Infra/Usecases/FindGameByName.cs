using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Models;
using RetroGate.SDK.Game.Domain.Repository;
using RetroGate.SDK.Game.Domain.Usecases;

namespace RetroGate.SDK.Game.Infra.Usecases
{
    public class FindGameByName(IAvailableGamesRepository availableGamesRepository,
                               IInstalledGamesRepository installedGamesRepository) : IFindGameByName
    {
        public Task<Either<ErrorBase, List<GameModel>>> Call(GameSource source, string name)
        {
            switch (source)
            {
                case GameSource.AvailableGames:
                    return availableGamesRepository.FindByName(name);
                case GameSource.InstalledGames:
                    return installedGamesRepository.FindByName(name);
                default:
                    return Task.FromResult<Either<ErrorBase, List<GameModel>>>(new ErrorInvalidArgument("Invalid game source."));
            }
        }
    }
}
