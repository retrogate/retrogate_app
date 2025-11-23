using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Installer.Domain.Models;
namespace RetroGate.SDK.Installer.Domain.Repository
{
    public interface IInstallerRepository
    {
        public event EventHandler<ProgressModel> OnInstallProgressChanged;

        Task<Either<ErrorBase, string>> Install(string gameId, bool replace = false, bool restartSteam = false);

        Task<Either<ErrorBase, Unit>> Delete(string[] paths);

        Task<Either<ErrorBase, Unit>> Cancel(string id);
    }
}
