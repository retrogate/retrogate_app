using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Models;
using RetroGate.SDK.Game.Domain.Repository;
using RetroGate.SDK.Game.Domain.Usecases;

namespace RetroGate.SDK.Game.Infra.Usecases
{
    public class UpdateGame(IAvailableGamesRepository availableGamesRepository,
                           IInstalledGamesRepository installedGamesRepository) : IUpdateGame
    {
        public Task<Either<ErrorBase, GameModel>> Call(GameSource source, GameModel game)
        {
            switch (source)
            {
                case GameSource.AvailableGames:
                    return availableGamesRepository.Update(game);
                case GameSource.InstalledGames:
                    return installedGamesRepository.Update(game);
                default:
                    return Task.FromResult<Either<ErrorBase, GameModel>>(new ErrorInvalidArgument("Invalid game source."));
            }
        }
    }
}
