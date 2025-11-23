using LanguageExt;
using RetroGate.SDK.Core.Errors;

namespace RetroGate.SDK.Installer.Domain.Usecases
{
    public interface IInstallGame
    {
        Task<Either<ErrorBase, string>> Call(string gameId, bool replace = false, bool restartSteam = false);
    }
}
