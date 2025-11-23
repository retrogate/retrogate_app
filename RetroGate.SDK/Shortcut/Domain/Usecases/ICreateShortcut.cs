using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Shortcut.Domain.Models;

namespace RetroGate.SDK.Shortcut.Domain.Usecases
{
    public interface ICreateShortcut
    {
        Task<Either<ErrorBase, ShortcutModel>> Call(ShortcutModel shortcut);
    }
}
