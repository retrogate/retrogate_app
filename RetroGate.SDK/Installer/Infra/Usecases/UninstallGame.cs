using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Installer.Domain.Repository;
using RetroGate.SDK.Installer.Domain.Usecases;

namespace RetroGate.SDK.Installer.Infra.Usecases
{
    public class UninstallGame(IInstallerRepository repository) : IUninstallGame
    {
        public Task<Either<ErrorBase, Unit>> Call(string gameId, bool restartSteam)
        {
            return repository.Uninstall(gameId, restartSteam);
        }
    }
}
