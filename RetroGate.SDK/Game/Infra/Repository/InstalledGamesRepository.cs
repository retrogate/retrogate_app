using LanguageExt;
using RetroGate.SDK.Core.Domain.Models;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Models;
using RetroGate.SDK.Game.Domain.Repository;
using RetroGate.SDK.Game.Domain.Usecases;

namespace RetroGate.SDK.Game.Infra.Repository
{
    public class InstalledGamesRepository(
        ConfigModel config,
        IAvailableGamesRepository availableGamesRepository,
        IGetGameImages getGameImages) : GameRepository(getGameImages, "installed_games.json"), IInstalledGamesRepository
    {
        public async Task<Either<ErrorBase, List<GameModel>>> FindInstalledGames()
        {
            var games = new List<GameModel>();
            var InstalledGamesPath = config.InstalledGamesPath;
            var directoryInfo = new DirectoryInfo(InstalledGamesPath);
            if (!directoryInfo.Exists)
            {
                return games;
            }
            foreach (var dir in directoryInfo.GetDirectories())
            {
                var folderName = dir.Name!;
                var game = await availableGamesRepository.GetById(folderName);
                game.Match(
                    Right: async g =>
                    {
                        games.Add(g);
                        var create = await Create(g);
                    },
                    Left: _ => { }
                );
            }
            return games;
        }

        public async Task<Either<ErrorBase, Unit>> LaunchGame(string gameId)
        {
            var game = await GetById(gameId);
            return await game.Match(
                Right: g =>
                {
                    var installPath = Path.Combine(config.InstalledGamesPath, g.Id);
                    var executableFullPath = Path.Combine(installPath, g.ExecutablePath);
                    if (!File.Exists(executableFullPath))
                    {
                        return Task.FromResult<Either<ErrorBase, Unit>>(new ErrorBase($"Executable not found at path: {executableFullPath}"));
                    }
                    var process = new System.Diagnostics.Process();
                    process.StartInfo.FileName = executableFullPath;
                    process.StartInfo.WorkingDirectory = new FileInfo(executableFullPath).DirectoryName!;
                    process.StartInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Maximized;
                    process.StartInfo.UseShellExecute = true;
                    
                    process.Start();
                    
                    // Aguarda um pouco para a janela ser criada
                    Thread.Sleep(1500);
                    
                    // Traz a janela para frente
                    if (!process.HasExited && process.MainWindowHandle != IntPtr.Zero)
                    {
                        SetForegroundWindow(process.MainWindowHandle);
                        ShowWindow(process.MainWindowHandle, SW_RESTORE);
                        SetForegroundWindow(process.MainWindowHandle);
                    }
                    
                    return Task.FromResult<Either<ErrorBase, Unit>>(Unit.Default);
                },
                Left: err => Task.FromResult<Either<ErrorBase, Unit>>(err)
            );
        }

        // P/Invoke para trazer janela para frente
        [System.Runtime.InteropServices.DllImport("user32.dll")]
        private static extern bool SetForegroundWindow(IntPtr hWnd);

        [System.Runtime.InteropServices.DllImport("user32.dll")]
        private static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);

        private const int SW_RESTORE = 9;
    }
}