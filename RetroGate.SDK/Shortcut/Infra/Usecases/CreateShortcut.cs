using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Shortcut.Domain.Models;
using RetroGate.SDK.Shortcut.Domain.Repository;
using RetroGate.SDK.Shortcut.Domain.Usecases;

namespace RetroGate.SDK.Shortcut.Infra.Usecases
{
    public class CreateShortcut(IShortcutRepository repository) : ICreateShortcut
    {
        public Task<Either<ErrorBase, ShortcutModel>> Call(ShortcutModel shortcut)
        {
            return repository.Create(shortcut);
        }
    }
}
