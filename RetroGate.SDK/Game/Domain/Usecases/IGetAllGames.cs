using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Models;

namespace RetroGate.SDK.Game.Domain.Usecases
{
    public interface IGetAllGames
    {
        Task<Either<ErrorBase, List<GameModel>>> Call();
    }
}
