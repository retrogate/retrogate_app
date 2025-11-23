using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Models;

namespace RetroGate.SDK.Game.Domain.Repository
{
    public interface IGameImagesRepository
    {
        Task<Either<ErrorBase, GameImagesModel>> GetGameImages(string gameName);
    }
}