using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Installer.Domain.Models;

namespace RetroGate.SDK.Installer.Domain.Repository
{
    public interface IInstallerRepository
    {
        event EventHandler<InstallerEventModel> OnInstallerEvent;

        InstallerEventModel? LastEvent { get; }

        Task<Either<ErrorBase, string>> Install(string gameId, bool replace = false, bool restartSteam = false);

        Task<Either<ErrorBase, Unit>> Uninstall(string gameId, bool restartSteam = false);

        Task<Either<ErrorBase, Unit>> Cancel(string id);
    }
}
