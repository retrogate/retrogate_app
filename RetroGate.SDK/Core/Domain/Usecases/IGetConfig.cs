using LanguageExt;
using RetroGate.SDK.Core.Domain.Models;
using RetroGate.SDK.Core.Errors;

namespace RetroGate.SDK.Core.Domain.Usecases
{
    public interface IGetConfig
    {
        Task<Either<ErrorBase, ConfigModel>> Call();
    }
}
