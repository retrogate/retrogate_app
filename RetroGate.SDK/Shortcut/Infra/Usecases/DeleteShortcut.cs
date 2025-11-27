using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Shortcut.Domain.Usecases;
using RetroGate.SDK.Shortcut.Domain.Repository;

namespace RetroGate.SDK.Shortcut.Infra.Usecases
{

    public class DeleteShortcut : IDeleteShortcut
    {
        private readonly IShortcutRepository _shortcutRepository;

        public DeleteShortcut(IShortcutRepository shortcutRepository)
        {
            _shortcutRepository = shortcutRepository;
        }

        public async Task<Either<ErrorBase, Unit>> Call(string appId)
        {
            return await _shortcutRepository.Delete(appId);
        }
    }
}