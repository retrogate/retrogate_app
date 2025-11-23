using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Installer.Domain.Repository;
using RetroGate.SDK.Installer.Domain.Usecases;

namespace RetroGate.SDK.Installer.Infra.Usecases
{
    public class DeleteGame(IInstallerRepository repository) : IDeleteGame
    {
        public Task<Either<ErrorBase, Unit>> Call(string[] paths)
        {
            return repository.Delete(paths);
        }
    }
}
