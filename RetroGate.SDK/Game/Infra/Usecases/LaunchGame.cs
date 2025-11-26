using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Repository;

namespace RetroGate.SDK.Game.Domain.Usecases
{
    public class LaunchGame(IInstalledGamesRepository _repository) : ILaunchGame
    {
        public Task<Either<ErrorBase, Unit>> Call(string gameId)
        {
            return _repository.LaunchGame(gameId);
        }
    }
}