using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Models;

namespace RetroGate.SDK.Game.Domain.Repository
{
    public interface IGameRepository
    {
        Task<Either<ErrorBase, GameModel>> Create(GameModel game);
        Task<Either<ErrorBase, GameModel>> GetById(string id);
        Task<Either<ErrorBase, List<GameModel>>> GetAll();
        Task<Either<ErrorBase, List<GameModel>>> FindByName(string name);
        Task<Either<ErrorBase, GameModel>> Update(GameModel game);
        Task<Either<ErrorBase, Unit>> Delete(string id);
    }
}
