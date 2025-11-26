using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Models;

namespace RetroGate.SDK.Game.Domain.Repository
{
    public interface IInstalledGamesRepository : IGameRepository
    {
        Task<Either<ErrorBase, Unit>> LaunchGame(string gameId);
        Task<Either<ErrorBase, List<GameModel>>> FindInstalledGames();
    }
}