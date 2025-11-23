using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Models;
using RetroGate.SDK.Game.Domain.Repository;
using RetroGate.SDK.Game.Domain.Usecases;

namespace RetroGate.SDK.Game.Infra.Usecases
{
    public class UpdateGame(IGameRepository repository) : IUpdateGame
    {
        public Task<Either<ErrorBase, GameModel>> Call(GameModel game)
        {
            return repository.Update(game);
        }
    }
}
