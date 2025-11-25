using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Models;

namespace RetroGate.SDK.Game.Domain.Usecases
{
    public interface IUpdateGame
    {
        Task<Either<ErrorBase, GameModel>> Call(GameSource source, GameModel game);
    }
}
