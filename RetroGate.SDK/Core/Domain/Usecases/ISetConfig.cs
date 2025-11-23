using LanguageExt;
using RetroGate.SDK.Core.Domain.Models;
using RetroGate.SDK.Core.Errors;

namespace RetroGate.SDK.Core.Domain.Usecases
{
    public interface ISetConfig
    {
        Task<Either<ErrorBase, Unit>> Call(ConfigModel config);
    }
}
