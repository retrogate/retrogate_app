using LanguageExt;
using RetroGate.SDK.Core.Domain.Models;
using RetroGate.SDK.Core.Domain.Repository;
using RetroGate.SDK.Core.Domain.Usecases;
using RetroGate.SDK.Core.Errors;

namespace RetroGate.SDK.Core.Infra.Usecases
{
    public class SetConfig : ISetConfig
    {
        private readonly IConfigRepository _configRepository;

        public SetConfig(IConfigRepository configRepository)
        {
            _configRepository = configRepository;
        }

        public async Task<Either<ErrorBase, Unit>> Call(ConfigModel config)
        {
            try
            {
                await _configRepository.SetConfig(config);
                return Unit.Default;
            }
            catch (Exception ex)
            {
                return new ErrorException(ex);
            }
        }
    }
}
