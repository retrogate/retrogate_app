using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Models;
using RetroGate.SDK.Game.Domain.Repository;

namespace RetroGate.SDK.Game.Domain.Usecases
{
    public interface IGetGameById
    {
        Task<Either<ErrorBase, GameModel>> Call(GameSource source, string id);
    }
}
