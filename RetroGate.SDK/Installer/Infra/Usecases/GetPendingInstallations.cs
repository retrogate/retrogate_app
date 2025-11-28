namespace RetroGate.SDK.Installer.Infra.Usecases
{
    using LanguageExt;
    using RetroGate.SDK.Core.Errors;
    using RetroGate.SDK.Installer.Domain.Repository;
    using RetroGate.SDK.Installer.Domain.Usecases;

    public class GetPendingInstallations(
        IInstallerRepository installerRepository) : IGetPendingInstallations
    {
        public Task<Either<ErrorBase, List<string>>> Call()
        {
            return installerRepository.GetPendingInstallations();
        }
    }
}