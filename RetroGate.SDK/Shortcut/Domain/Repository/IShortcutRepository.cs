using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Shortcut.Domain.Models;

namespace RetroGate.SDK.Shortcut.Domain.Repository
{
    public interface IShortcutRepository
    {
        Task<Either<ErrorBase, List<ShortcutModel>>> GetAll();
        Task<Either<ErrorBase, ShortcutModel>> Create(ShortcutModel shortcut);
    }
}
