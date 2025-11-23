using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Models;
using RetroGate.SDK.Game.Domain.Repository;
using RetroGate.SDK.Game.Domain.Usecases;

namespace RetroGate.SDK.Game.Infra.Usecases
{
    public class GetGameById(IGameRepository repository) : IGetGameById
    {
        public Task<Either<ErrorBase, GameModel>> Call(string id)
        {
            return repository.GetById(id);
        }
    }
}
