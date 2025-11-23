using LanguageExt;
using RetroGate.SDK.Core.Domain.Models;
using RetroGate.SDK.Core.Errors;

namespace RetroGate.SDK.Core.Domain.Repository
{
    public interface IConfigRepository
    {
        Task<Either<ErrorBase, ConfigModel>> GetConfig();
        Task<Either<ErrorBase, Unit>> SetConfig(ConfigModel config);
    }
}