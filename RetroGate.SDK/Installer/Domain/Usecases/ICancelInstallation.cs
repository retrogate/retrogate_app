using LanguageExt;
using RetroGate.SDK.Core.Errors;

namespace RetroGate.SDK.Installer.Domain.Usecases
{
    public interface ICancelInstallation
    {
        Task<Either<ErrorBase, Unit>> Call(string id);
    }
}
