using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Installer.Domain.Repository;
using RetroGate.SDK.Installer.Domain.Usecases;

namespace RetroGate.SDK.Installer.Infra.Usecases
{
    public class CancelInstallation(IInstallerRepository repository) : ICancelInstallation
    {
        public Task<Either<ErrorBase, Unit>> Call(string id)
        {
            return repository.Cancel(id);
        }
    }
}
