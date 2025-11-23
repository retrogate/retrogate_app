using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Installer.Domain.Repository;
using RetroGate.SDK.Installer.Domain.Usecases;

namespace RetroGate.SDK.Installer.Infra.Usecases
{
    public class InstallGame(IInstallerRepository repository) : IInstallGame
    {
        public Task<Either<ErrorBase, string>> Call(string gameId, bool replace = false, bool restartSteam = false)
        {
            return repository.Install(gameId, replace, restartSteam);
        }
    }
}
