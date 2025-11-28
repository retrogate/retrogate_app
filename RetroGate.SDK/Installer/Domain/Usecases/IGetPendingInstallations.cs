namespace RetroGate.SDK.Installer.Domain.Usecases
{
    using LanguageExt;
    using RetroGate.SDK.Core.Errors;

    public interface IGetPendingInstallations
    {
        Task<Either<ErrorBase, List<string>>> Call();
    }
}