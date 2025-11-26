using LanguageExt;
using RetroGate.SDK.Core.Domain.Models;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Models;
using RetroGate.SDK.Game.Domain.Usecases;
using RetroGate.SDK.Installer.Domain.Models;
using RetroGate.SDK.Installer.Domain.Repository;
using RetroGate.SDK.Shortcut.Domain.Models;
using RetroGate.SDK.Shortcut.Domain.Usecases;
using System.Collections.Concurrent;
using System.IO.Compression;

namespace RetroGate.SDK.Installer.Infra.Repository
{
    public class InstallerRepository : IInstallerRepository
    {
        public InstallerEventModel? LastEvent {get; private set; }
        private readonly IGetGameById _getGameById;
        private readonly ICreateShortcut _createShortcut;
        private readonly ICreateGame _createGame;
        private readonly HttpClient _httpClient;
        private readonly string _installBasePath;
        private readonly ConcurrentDictionary<string, CancellationTokenSource> _activeTasks;
        private readonly ConfigModel _config;

        public event EventHandler<InstallerEventModel>? OnInstallerEvent;

        public InstallerRepository(
            IGetGameById getGameById,
            ICreateShortcut createShortcut,
            ICreateGame createGame,
            ConfigModel config)
        {
            _getGameById = getGameById;
            _createShortcut = createShortcut;
            _createGame = createGame;
            _httpClient = new HttpClient();
            _installBasePath = config.InstalledGamesPath ?? Path.Combine(
                Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData),
                "RetroGate",
                "Games");
            _activeTasks = new ConcurrentDictionary<string, CancellationTokenSource>();
            _config = config;

            // Garante que o diretório base existe
            Directory.CreateDirectory(_installBasePath);
        }

        public async Task<Either<ErrorBase, string>> Install(string gameId, bool replace = false, bool restartSteam = false)
        {
            try
            {
                Console.WriteLine($"[Installer] Iniciando instalação do jogo: {gameId} (replace: {replace})");

                // Busca o jogo pelo ID
                var gameResult = await _getGameById.Call(GameSource.AvailableGames, gameId);
                if (gameResult.IsLeft)
                {
                    Console.WriteLine($"[Installer] Erro: Jogo não encontrado - {gameId}");
                    return gameResult.LeftAsEnumerable().First();
                }

                var game = gameResult.RightAsEnumerable().First();
                Console.WriteLine($"[Installer] Jogo encontrado: {game.Name}");

                // Verifica se o jogo já está instalado
                var installPath = Path.Combine(_installBasePath, game.Id);
                if (Directory.Exists(installPath) && !replace)
                {
                    Console.WriteLine($"[Installer] Jogo já instalado: {installPath}");
                    Console.WriteLine($"[Installer] Use replace=true para reinstalar");
                    
                    ReportProgress(gameId, InstallerProgressState.CreatingShortcut, 100, 0);
                    await AddShortcutToSteam(game, installPath, restartSteam);

                    ReportProgress(gameId, InstallerProgressState.Completed, 100, 0);
                    
                    return installPath;
                }

                // Se replace=true e o jogo existe, remove o diretório antigo
                if (Directory.Exists(installPath) && replace)
                {
                    Console.WriteLine($"[Installer] Removendo instalação existente: {installPath}");
                    Directory.Delete(installPath, true);
                }

                if(_activeTasks.ContainsKey(gameId))
                {
                    Console.WriteLine($"[Installer] Instalação do jogo {gameId} já está em andamento");
                    return new ErrorAlreadyExists();
                }

                // Cria CancellationTokenSource para permitir cancelamento
                var cts = new CancellationTokenSource();
                _activeTasks[gameId] = cts;

                try
                {
                    // Reporta progresso: Iniciando download
                    ReportProgress(gameId, InstallerProgressState.Downloading, 0, 0);

                    // Baixa o arquivo
                    var downloadPath = await DownloadGame(game, cts.Token);
                    Console.WriteLine($"[Installer] Download concluído: {downloadPath}");

                    var finalInstallPath = await InstallGame(game, downloadPath, cts.Token);
                    Console.WriteLine($"[Installer] Instalação concluída: {finalInstallPath}");

                    // Reporta progresso: Adicionando à biblioteca
                    ReportProgress(gameId, InstallerProgressState.CreatingShortcut, 90, 0);

                    // Adiciona o jogo a biblioteca
                    await CreateGame(game);

                    // Adiciona shortcut no Steam
                    await AddShortcutToSteam(game, finalInstallPath, restartSteam);
                    Console.WriteLine($"[Installer] Shortcut adicionado ao Steam");

                    // Limpa o arquivo de download
                    if (File.Exists(downloadPath))
                    {
                        File.Delete(downloadPath);
                        Console.WriteLine($"[Installer] Arquivo de download removido");
                    }

                    // Reporta progresso: Completo
                    ReportProgress(gameId, InstallerProgressState.Completed, 100, 0);
                    Console.WriteLine($"[Installer] Instalação concluída com sucesso!");

                    return finalInstallPath;
                }
                finally
                {
                    _activeTasks.TryRemove(gameId, out _);
                }
            }
            catch (OperationCanceledException)
            {
                Console.WriteLine($"[Installer] Instalação cancelada: {gameId}");
                ReportProgress(gameId, InstallerProgressState.Failed, 0, 0);
                return new ErrorBase { Message = "Instalação cancelada" };
            }
            catch (Exception ex)
            {
                Console.WriteLine($"[Installer] Erro durante instalação: {ex.Message}");
                ReportProgress(gameId, InstallerProgressState.Failed, 0, 0);
                return new ErrorBase { Message = $"Erro durante instalação: {ex.Message}" };
            }
        }

        public Task<Either<ErrorBase, Unit>> Delete(string[] paths)
        {
            try
            {
                Console.WriteLine($"[Installer] Iniciando remoção de {paths.Length} path(s)");

                foreach (var path in paths)
                {
                    if (Directory.Exists(path))
                    {
                        Directory.Delete(path, true);
                        Console.WriteLine($"[Installer] Diretório removido: {path}");
                    }
                    else if (File.Exists(path))
                    {
                        File.Delete(path);
                        Console.WriteLine($"[Installer] Arquivo removido: {path}");
                    }
                    else
                    {
                        Console.WriteLine($"[Installer] Path não encontrado: {path}");
                    }
                }

                Console.WriteLine($"[Installer] Remoção concluída");
                return Task.FromResult<Either<ErrorBase, Unit>>(Unit.Default);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"[Installer] Erro durante remoção: {ex.Message}");
                return Task.FromResult<Either<ErrorBase, Unit>>(
                    new ErrorBase { Message = $"Erro ao remover arquivos: {ex.Message}" });
            }
        }

        public Task<Either<ErrorBase, Unit>> Cancel(string id)
        {
            try
            {
                if (_activeTasks.TryGetValue(id, out var cts))
                {
                    Console.WriteLine($"[Installer] Cancelando instalação: {id}");
                    cts.Cancel();
                    return Task.FromResult<Either<ErrorBase, Unit>>(Unit.Default);
                }

                Console.WriteLine($"[Installer] Nenhuma instalação ativa encontrada para: {id}");
                return Task.FromResult<Either<ErrorBase, Unit>>(
                    new ErrorNotFound { Message = "Nenhuma instalação ativa encontrada" });
            }
            catch (Exception ex)
            {
                Console.WriteLine($"[Installer] Erro ao cancelar: {ex.Message}");
                return Task.FromResult<Either<ErrorBase, Unit>>(
                    new ErrorBase { Message = $"Erro ao cancelar instalação: {ex.Message}" });
            }
        }

        private async Task<string> DownloadGame(
            Game.Domain.Models.GameModel game,
            CancellationToken cancellationToken)
        {
            var downloadPath = Path.Combine(
                Path.GetTempPath(),
                $"{game.Id}.zip");

            Console.WriteLine($"[Installer] Baixando de: {game.DownloadUrl}");
            Console.WriteLine($"[Installer] Salvando em: {downloadPath}");

            using var response = await _httpClient.GetAsync(
                game.DownloadUrl,
                HttpCompletionOption.ResponseHeadersRead,
                cancellationToken);

            response.EnsureSuccessStatusCode();

            var totalBytes = response.Content.Headers.ContentLength ?? 0;
            var downloadedBytes = 0L;
            var lastReportTime = DateTime.Now;
            var lastDownloadedBytes = 0L;

            using var contentStream = await response.Content.ReadAsStreamAsync(cancellationToken);
            using var fileStream = new FileStream(
                downloadPath,
                FileMode.Create,
                FileAccess.Write,
                FileShare.None,
                8192,
                true);

            var buffer = new byte[8192];
            int bytesRead;

            while ((bytesRead = await contentStream.ReadAsync(buffer, cancellationToken)) > 0)
            {
                await fileStream.WriteAsync(buffer.AsMemory(0, bytesRead), cancellationToken);
                downloadedBytes += bytesRead;

                // Reporta progresso a cada 500ms
                var now = DateTime.Now;
                if ((now - lastReportTime).TotalMilliseconds > 500)
                {
                    var percentage = totalBytes > 0
                        ? (int)((downloadedBytes * 100) / totalBytes)
                        : 0;

                    var bytesInInterval = downloadedBytes - lastDownloadedBytes;
                    var timeInSeconds = (now - lastReportTime).TotalSeconds;
                    var speedKbps = timeInSeconds > 0
                        ? (int)(bytesInInterval / 1024 / timeInSeconds)
                        : 0;

                    ReportProgress(game.Id, InstallerProgressState.Downloading, percentage, speedKbps);

                    lastReportTime = now;
                    lastDownloadedBytes = downloadedBytes;
                }
            }

            // Reporta 100% do download
            ReportProgress(game.Id, InstallerProgressState.Downloading, 100, 0);

            return downloadPath;
        }

        private async Task<string> InstallGame(GameModel game, string installFile, CancellationToken cancellationToken)
        {
            return game.InstallationMethod switch
            {
                _ => await ExtractGame(game, installFile, cancellationToken),
            };
        }

        private async Task<string> ExtractGame(
            Game.Domain.Models.GameModel game,
            string zipPath,
            CancellationToken cancellationToken)
        {
            var extractPath = Path.Combine(_installBasePath, game.Id);

            Console.WriteLine($"[Installer] Extraindo para: {extractPath}");

            // Remove diretório existente se houver
            if (Directory.Exists(extractPath))
            {
                Directory.Delete(extractPath, true);
            }

            Directory.CreateDirectory(extractPath);

            var lastReportTime = DateTime.Now;

            await Task.Run(() =>
            {
                using var archive = ZipFile.OpenRead(zipPath);
                var totalEntries = archive.Entries.Count;
                var extractedEntries = 0;

                foreach (var entry in archive.Entries)
                {
                    cancellationToken.ThrowIfCancellationRequested();

                    var destinationPath = Path.Combine(extractPath, entry.FullName);

                    // Cria diretório se necessário
                    if (string.IsNullOrEmpty(entry.Name))
                    {
                        Directory.CreateDirectory(destinationPath);
                    }
                    else
                    {
                        Directory.CreateDirectory(Path.GetDirectoryName(destinationPath)!);
                        entry.ExtractToFile(destinationPath, true);
                    }

                    // Incrementa o contador após extrair cada arquivo
                    extractedEntries++;

                    // Reporta progresso a cada 500ms OU a cada 5% de progresso
                    var now = DateTime.Now;
                    var percentage = (extractedEntries * 100) / totalEntries;
                    var shouldReport = (now - lastReportTime).TotalMilliseconds > 500 ||
                                      (percentage % 5 == 0 && percentage > 0);

                    if (shouldReport)
                    {
                        ReportProgress(game.Id, InstallerProgressState.Extracting, percentage, 0);
                        lastReportTime = now;
                    }
                }

                // Garante que reportamos 100% no final
                ReportProgress(game.Id, InstallerProgressState.Extracting, 100, 0);
            }, cancellationToken);

            return extractPath;
        }

        private async Task<Either<ErrorBase, Unit>> AddShortcutToSteam(
            GameModel game,
            string installPath,
            bool restartSteam = false)
        {
            Console.WriteLine($"[Installer] Adicionando shortcut ao Steam");

            // Determina o caminho do executável
            var exePath = Path.Combine(installPath, game.ExecutablePath);

            if (!File.Exists(exePath))
            {
                Console.WriteLine($"[Installer] Aviso: Executável não encontrado: {exePath}");
                // Tenta encontrar o primeiro .exe no diretório
                var exeFiles = Directory.GetFiles(installPath, "*.exe", SearchOption.AllDirectories);
                if (exeFiles.Length > 0)
                {
                    exePath = exeFiles[0];
                    Console.WriteLine($"[Installer] Usando executável encontrado: {exePath}");
                }
            }

            var shortcut = new ShortcutModel
            {
                AppId = BitConverter.GetBytes(uint.Parse(game.Id)),
                AppName = game.Name,
                Exe = $"\"{exePath}\"",
                StartDir = $"\"{Path.GetDirectoryName(exePath)}\"",
                Icon = exePath,
                LaunchOptions = "",
                IsHidden = false,
                AllowDesktopConfig = true,
                AllowOverlay = true,
                OpenVR = false,
                ImageHeroUrl = game.ImageHeroUrl,
                ImagePosterUrl = game.ImagePosterUrl,
                ImageLogoUrl = game.ImageLogoUrl
            };

            // Assume userId padrão (pode ser parametrizado posteriormente)
            var userId = GetSteamUserId();
            Console.WriteLine($"[Installer] Criando shortcut para usuário Steam: {userId}");

            var createShortcut = await _createShortcut.Call(shortcut);

            if (createShortcut.IsLeft)
            {
                var error = createShortcut.LeftAsEnumerable().First();
                Console.WriteLine($"[Installer] Erro ao criar shortcut: {error.Message}");
                return error;
            }

            Console.WriteLine($"[Installer] Shortcut criado com sucesso");

            if (restartSteam)
            {
                RestartSteam();
            }

            return Unit.Default;
        }

        private async Task CreateGame(GameModel game)
        {
            var createGame = await _createGame.Call(GameSource.InstalledGames, game);
            createGame.Match(
                (Right) => Console.WriteLine($"[Installer] Game {Right.Name} instalado com sucesso"),
                (Left) => Console.WriteLine($"[Installer] Falha ao instalar o jogo {game.Name}: {Left}")
            );
        }

        private static string GetSteamUserId()
        {
            // Tenta encontrar o ID do usuário do Steam
            // Por padrão, retorna o primeiro usuário encontrado
            var steamPath = Path.Combine(
                Environment.GetFolderPath(Environment.SpecialFolder.ProgramFilesX86),
                "Steam");

            var userDataPath = Path.Combine(steamPath, "userdata");

            if (Directory.Exists(userDataPath))
            {
                var userDirs = Directory.GetDirectories(userDataPath);
                if (userDirs.Length > 0)
                {
                    var userId = Path.GetFileName(userDirs[0]);
                    Console.WriteLine($"[Installer] Steam UserId encontrado: {userId}");
                    return userId;
                }
            }

            Console.WriteLine($"[Installer] UserId padrão será usado");
            return "0"; // Fallback
        }

        private void ReportProgress(
            string gameId,
            InstallerProgressState state,
            int percentage,
            int speedKbps)
        {
            Console.WriteLine(
                $"[Progress] {gameId} | State: {state} | {percentage}% | {speedKbps} KB/s");

            var eventModel = new InstallerEventModel
            {
                EventType = InstallerEventType.ProgressChanged,
                ProgressChanged = new InstallerEventProgressChangedModel
                {
                    GameId = gameId,
                    State = state,
                    Percentage = percentage,
                    SpeedInKbPerSec = speedKbps
                }
            };
            LastEvent = eventModel;
            OnInstallerEvent?.Invoke(this, eventModel);
        }

        private void RestartSteam()
        {
            Console.WriteLine($"[Installer] Reiniciando Steam...");

            // Encerra o processo do Steam
            var steamProcesses = System.Diagnostics.Process.GetProcessesByName("steam");
            foreach (var process in steamProcesses)
            {
                process.Kill();
                process.WaitForExit();
            }

            // Inicia o Steam novamente
            var steamPath = _config.SteamPath + "\\Steam.exe";

            if (File.Exists(steamPath))
            {
                System.Diagnostics.Process.Start(steamPath);
                Console.WriteLine($"[Installer] Steam reiniciado com sucesso.");
            }
            else
            {
                Console.WriteLine($"[Installer] Erro: Caminho do Steam não encontrado: {steamPath}");
            }
        }
    }

}
