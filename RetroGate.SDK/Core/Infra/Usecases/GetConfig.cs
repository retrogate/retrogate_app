using LanguageExt;
using RetroGate.SDK.Core.Domain.Models;
using RetroGate.SDK.Core.Domain.Repository;
using RetroGate.SDK.Core.Domain.Usecases;
using RetroGate.SDK.Core.Errors;

namespace RetroGate.SDK.Core.Infra.Usecases
{
    public class GetConfig : IGetConfig
    {
        private readonly IConfigRepository _configRepository;

        public GetConfig(IConfigRepository configRepository)
        {
            _configRepository = configRepository;
        }

        public async Task<Either<ErrorBase, ConfigModel>> Call()
        {
            try
            {
                return await _configRepository.GetConfig();
            }
            catch (Exception ex)
            {
                return new ErrorException(ex);
            }
        }
    }
}
