using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Models;
using RetroGate.SDK.Game.Domain.Repository;
using RetroGate.SDK.Game.Domain.Usecases;

namespace RetroGate.SDK.Game.Infra.Usecases
{
    public class GetAllGames(IGameRepository repository) : IGetAllGames
    {
        public Task<Either<ErrorBase, List<GameModel>>> Call()
        {
            return repository.GetAll();
        }
    }
}
