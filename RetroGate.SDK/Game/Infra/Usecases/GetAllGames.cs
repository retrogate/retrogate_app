using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Models;
using RetroGate.SDK.Game.Domain.Repository;
using RetroGate.SDK.Game.Domain.Usecases;

namespace RetroGate.SDK.Game.Infra.Usecases
{
    public class GetAllGames(IAvailableGamesRepository availableGamesRepository,
                            IInstalledGamesRepository installedGamesRepository) : IGetAllGames
    {
        public Task<Either<ErrorBase, List<GameModel>>> Call(GameSource source)
        {
            switch (source)
            {
                case GameSource.AvailableGames:
                    return availableGamesRepository.GetAll();
                case GameSource.InstalledGames:
                    return installedGamesRepository.GetAll();
                default:
                    return Task.FromResult<Either<ErrorBase, List<GameModel>>>(new ErrorInvalidArgument("Invalid game source."));
            }
        }
    }
}
