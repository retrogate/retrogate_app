using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Models;
using RetroGate.SDK.Game.Domain.Repository;
using RetroGate.SDK.Game.Domain.Usecases;

namespace RetroGate.SDK.Game.Infra.Usecases
{
    public class FindGameByName(IGameRepository repository) : IFindGameByName
    {
        public Task<Either<ErrorBase, List<GameModel>>> Call(string name)
        {
            return repository.FindByName(name);
        }
    }
}
