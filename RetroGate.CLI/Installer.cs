using RetroGate.SDK.Core.Domain.Models;
using RetroGate.SDK.Core.Infra;
using RetroGate.SDK.Game.Infra.Repository;
using RetroGate.SDK.Game.Infra.Usecases;
using RetroGate.SDK.Installer.Domain.Models;
using RetroGate.SDK.Installer.Infra.Repository;
using RetroGate.SDK.Installer.Infra.Usecases;
using RetroGate.SDK.Shortcut.Infra.Repository;
using RetroGate.SDK.Shortcut.Infra.Usecases;

namespace RetroGate.CLI
{
    public class Installer : ICLIModule
    {
        public bool CanHandle(string[] args)
        {
            return args.Length > 0 && args[0].Equals("install", StringComparison.OrdinalIgnoreCase);
        }

        public async Task Run(string[] args)
        {
            if (args.Length < 2)
            {
                ShowHelp();
                return;
            }

            var command = args[1].ToLower();

            switch (command)
            {
                case "game":
                    if (args.Length < 3)
                    {
                        Console.WriteLine("Erro: Especifique o ID do jogo");
                        Console.WriteLine("Uso: RetroGate.CLI install game <gameId> [--replace]");
                        return;
                    }
                    var replace = args.Length > 3 && args[3] == "--replace";
                    await InstallGame(args[2], replace);
                    break;

                case "delete":
                    if (args.Length < 3)
                    {
                        Console.WriteLine("Erro: Especifique os paths a serem removidos");
                        Console.WriteLine("Uso: RetroGate.CLI install delete <path1> [path2] [path3]...");
                        return;
                    }
                    await DeletePaths(args.Skip(2).ToArray());
                    break;

                case "help":
                    ShowHelp();
                    break;

                default:
                    Console.WriteLine($"Comando desconhecido: {command}");
                    ShowHelp();
                    break;
            }
        }

        private async Task InstallGame(string gameId, bool replace = false)
        {
            Console.WriteLine($"=== Instalando jogo: {gameId} ===");
            if (replace)
            {
                Console.WriteLine("    Modo: REPLACE (reinstalar se já existe)");
            }
            Console.WriteLine();

            try
            {
                // Inicializa os repositórios e use cases
                var gameRepository = new GameRepository();
                var getGameByIdUseCase = new GetGameById(gameRepository);

                var configRepository = new ConfigRepository();
                var config = configRepository.GetConfig().Result.Match(
                    Right: cfg => cfg,
                    Left: _ => new RetroGate.SDK.Core.Domain.Models.ConfigModel()
                );
                var shortcutRepository = new ShortcutRepository(config);
                var createShortcutUseCase = new CreateShortcut(shortcutRepository);

                var installerRepository = new InstallerRepository(
                    getGameByIdUseCase,
                    createShortcutUseCase);

                // Inicializa o use case
                var installGameUseCase = new InstallGame(installerRepository);

                // Registra o evento de progresso
                installerRepository.OnInstallProgressChanged += OnProgressChanged;

                // Inicia a instalação usando o use case
                var result = await installGameUseCase.Call(gameId, replace);

                // Remove o handler do evento
                installerRepository.OnInstallProgressChanged -= OnProgressChanged;

                // Verifica o resultado
                if (result.IsRight)
                {
                    var installPath = result.RightAsEnumerable().First();
                    Console.WriteLine();
                    Console.WriteLine($"✓ Instalação concluída com sucesso!");
                    Console.WriteLine($"  Path: {installPath}");
                }
                else
                {
                    var error = result.LeftAsEnumerable().First();
                    Console.WriteLine();
                    Console.WriteLine($"✗ Erro durante instalação: {error.Message}");
                    Environment.Exit(1);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine();
                Console.WriteLine($"✗ Erro inesperado: {ex.Message}");
                Console.WriteLine($"  Stack: {ex.StackTrace}");
                Environment.Exit(1);
            }
        }

        private async Task DeletePaths(string[] paths)
        {
            Console.WriteLine($"=== Removendo {paths.Length} path(s) ===");
            Console.WriteLine();

            foreach (var path in paths)
            {
                Console.WriteLine($"  - {path}");
            }

            Console.WriteLine();
            Console.Write("Confirma a remoção? (s/n): ");
            var confirm = Console.ReadLine();

            if (confirm?.ToLower() != "s")
            {
                Console.WriteLine("Operação cancelada.");
                return;
            }

            try
            {
                // Inicializa os repositórios e use cases
                var gameRepository = new GameRepository();
                var getGameByIdUseCase = new GetGameById(gameRepository);

                var configRepository = new ConfigRepository();
                var config = configRepository.GetConfig().Result.Match(
                    Right: cfg => cfg,
                    Left: _ => new SDK.Core.Domain.Models.ConfigModel()
                );
                var shortcutRepository = new ShortcutRepository(config);
                var createShortcutUseCase = new CreateShortcut(shortcutRepository);

                var installerRepository = new InstallerRepository(
                    getGameByIdUseCase,
                    createShortcutUseCase);

                // Inicializa o use case
                var deleteGameUseCase = new SDK.Installer.Infra.Usecases.DeleteGame(installerRepository);

                var result = await deleteGameUseCase.Call(paths);

                if (result.IsRight)
                {
                    Console.WriteLine();
                    Console.WriteLine("✓ Remoção concluída com sucesso!");
                }
                else
                {
                    var error = result.LeftAsEnumerable().First();
                    Console.WriteLine();
                    Console.WriteLine($"✗ Erro durante remoção: {error.Message}");
                    Environment.Exit(1);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine();
                Console.WriteLine($"✗ Erro inesperado: {ex.Message}");
                Environment.Exit(1);
            }
        }

        private void OnProgressChanged(object? sender, ProgressModel progress)
        {
            var statusText = progress.Status switch
            {
                ProgressStatus.Downloading => "Baixando",
                ProgressStatus.Extracting => "Extraindo",
                ProgressStatus.AddingToLibrary => "Adicionando ao Steam",
                ProgressStatus.Completed => "Concluído",
                ProgressStatus.Failed => "Falhou",
                ProgressStatus.Paused => "Pausado",
                _ => "Aguardando"
            };

            var speedText = progress.SpeedInKbPerSec > 0
                ? $" | {progress.SpeedInKbPerSec} KB/s"
                : "";

            // Cria a barra de progresso
            var barWidth = 40;
            var filledWidth = (int)(barWidth * progress.Percentage / 100.0);
            var emptyWidth = barWidth - filledWidth;
            var bar = new string('█', filledWidth) + new string('░', emptyWidth);

            // Limpa a linha atual e escreve o progresso
            Console.Write($"\r[{bar}] {progress.Percentage}% | {statusText}{speedText}");

            // Se completou ou falhou, pula linha
            if (progress.Status == ProgressStatus.Completed ||
                progress.Status == ProgressStatus.Failed)
            {
                Console.WriteLine();
            }
        }

        private void ShowHelp()
        {
            Console.WriteLine("RetroGate CLI - Installer Module");
            Console.WriteLine();
            Console.WriteLine("Comandos disponíveis:");
            Console.WriteLine("  game <gameId> [--replace]  Instala um jogo pelo ID");
            Console.WriteLine("  delete <paths...>          Remove arquivos/diretórios");
            Console.WriteLine("  help                       Mostra esta ajuda");
            Console.WriteLine();
            Console.WriteLine("Opções:");
            Console.WriteLine("  --replace                  Reinstala mesmo se já estiver instalado");
            Console.WriteLine();
            Console.WriteLine("Exemplos:");
            Console.WriteLine("  RetroGate.CLI install game game123");
            Console.WriteLine("  RetroGate.CLI install game game123 --replace");
            Console.WriteLine("  RetroGate.CLI install delete C:\\Games\\MyGame");
            Console.WriteLine("  RetroGate.CLI install delete C:\\Game1 C:\\Game2");
            Console.WriteLine();
            Console.WriteLine("Descrição:");
            Console.WriteLine("  O módulo Installer permite instalar jogos automaticamente:");
            Console.WriteLine("  1. Busca o jogo pelo ID no repositório");
            Console.WriteLine("  2. Baixa o arquivo do jogo");
            Console.WriteLine("  3. Extrai para o diretório de instalação");
            Console.WriteLine("  4. Adiciona um shortcut no Steam");
            Console.WriteLine("  5. Reporta o progresso em tempo real");
        }
    }
}
