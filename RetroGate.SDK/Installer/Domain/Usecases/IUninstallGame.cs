using LanguageExt;
using RetroGate.SDK.Core.Errors;

namespace RetroGate.SDK.Installer.Domain.Usecases
{
    public interface IUninstallGame
    {
        Task<Either<ErrorBase, Unit>> Call(string gameId, bool restartSteam = false);
    }
}