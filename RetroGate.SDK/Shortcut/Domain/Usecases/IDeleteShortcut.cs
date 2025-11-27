using LanguageExt;
using RetroGate.SDK.Core.Errors;

namespace RetroGate.SDK.Shortcut.Domain.Usecases
{
    public interface IDeleteShortcut
    {
        Task<Either<ErrorBase, Unit>> Call(string appId);
    }
}