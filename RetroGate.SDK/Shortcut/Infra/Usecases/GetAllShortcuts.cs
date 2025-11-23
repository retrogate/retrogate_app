using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Shortcut.Domain.Models;
using RetroGate.SDK.Shortcut.Domain.Repository;
using RetroGate.SDK.Shortcut.Domain.Usecases;

namespace RetroGate.SDK.Shortcut.Infra.Usecases
{
    public class GetAllShortcuts(IShortcutRepository repository) : IGetAllShortcuts
    {
        public Task<Either<ErrorBase, List<ShortcutModel>>> Call()
        {
            return repository.GetAll();
        }
    }
}
