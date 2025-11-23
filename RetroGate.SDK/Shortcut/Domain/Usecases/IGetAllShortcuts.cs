using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Shortcut.Domain.Models;

namespace RetroGate.SDK.Shortcut.Domain.Usecases
{
    public interface IGetAllShortcuts
    {
        Task<Either<ErrorBase, List<ShortcutModel>>> Call();
    }
}
