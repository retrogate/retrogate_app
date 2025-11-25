using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Models;
using RetroGate.SDK.Game.Domain.Repository;
using RetroGate.SDK.Game.Domain.Usecases;

namespace RetroGate.SDK.Game.Infra.Usecases
{
    public class DeleteGame(IAvailableGamesRepository availableGamesRepository,
                            IInstalledGamesRepository installedGamesRepository) : IDeleteGame
    {
        public async Task<Either<ErrorBase, Unit>> Call(GameSource source, string id)
        {
            switch (source)
            {
                case GameSource.AvailableGames:
                    return await availableGamesRepository.Delete(id);
                case GameSource.InstalledGames:
                    return await installedGamesRepository.Delete(id);
                default:
                    return new ErrorInvalidArgument("Invalid game source.");
            }
        }
    }
}
