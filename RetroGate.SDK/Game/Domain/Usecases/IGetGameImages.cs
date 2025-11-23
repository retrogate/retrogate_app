using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Models;

namespace RetroGate.SDK.Game.Domain.Usecases
{
    public interface IGetGameImages
    {
        Task<Either<ErrorBase, GameImagesModel>> Call(string gameName);
    }
}