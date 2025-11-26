using LanguageExt;
using RetroGate.SDK.Core.Errors;

namespace RetroGate.SDK.Game.Domain.Usecases
{
    public interface ILaunchGame
    {
        Task<Either<ErrorBase, Unit>> Call(string gameId);
    }
}