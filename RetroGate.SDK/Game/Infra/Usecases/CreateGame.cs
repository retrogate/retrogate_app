using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Models;
using RetroGate.SDK.Game.Domain.Repository;
using RetroGate.SDK.Game.Domain.Usecases;

namespace RetroGate.SDK.Game.Infra.Usecases
{
    public class CreateGame(IAvailableGamesRepository availableGamesRepository,
                            IInstalledGamesRepository installedGamesRepository) : ICreateGame
    {
        public Task<Either<ErrorBase, GameModel>> Call(GameSource source, GameModel game)
        {
            switch (source)
            {
                case GameSource.AvailableGames:
                    return availableGamesRepository.Create(game);
                case GameSource.InstalledGames:
                    return installedGamesRepository.Create(game);
                default:
                    return Task.FromResult<Either<ErrorBase, GameModel>>(new ErrorBase("Invalid game source."));
            }
        }
    }
}
