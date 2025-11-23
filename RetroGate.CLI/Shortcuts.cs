using RetroGate.SDK.Core.Domain.Models;
using RetroGate.SDK.Shortcut.Domain.Repository;
using RetroGate.SDK.Shortcut.Domain.Usecases;
using RetroGate.SDK.Shortcut.Infra.Repository;
using RetroGate.SDK.Shortcut.Infra.Usecases;

namespace RetroGate.CLI
{
    public class Shortcuts : ICLIModule
    {
        private const string Keyword = "shortcuts";

        private readonly IShortcutRepository repository;
        private readonly IGetAllShortcuts getAllShortcuts;

        public Shortcuts(ConfigModel config)
        {
            repository = new ShortcutRepository(config);
            getAllShortcuts = new GetAllShortcuts(repository);
        }

        public bool CanHandle(string[] args)
        {
            return args.Length > 0 && args[0].ToLower() == Keyword;
        }

        public async Task Run(string[] args)
        {
            if (!CanHandle(args))
            {
                return;
            }

            // Remove a palavra-chave e processa os argumentos restantes
            var commandArgs = args.Skip(1).ToArray();

            if (commandArgs.Length == 0)
            {
                ShowHelp();
                return;
            }

            string command = commandArgs[0].ToLower();

            switch (command)
            {
                case "list":
                    if (commandArgs.Length < 2)
                    {
                        Console.WriteLine("Error: 'list' command requires a file path.");
                        Console.WriteLine($"Usage: RetroGate.CLI {Keyword} list <filepath>");
                        return;
                    }
                    await ListShortcuts(commandArgs[1]);
                    break;

                case "show":
                    if (commandArgs.Length < 3)
                    {
                        Console.WriteLine("Error: 'show' command requires a file path and shortcut index.");
                        Console.WriteLine($"Usage: RetroGate.CLI {Keyword} show <filepath> <index>");
                        return;
                    }
                    if (!int.TryParse(commandArgs[2], out int index))
                    {
                        Console.WriteLine("Error: Index must be a valid number.");
                        return;
                    }
                    await ShowShortcut(commandArgs[1], index);
                    break;

                case "export":
                    if (commandArgs.Length < 3)
                    {
                        Console.WriteLine("Error: 'export' command requires a file path and output file.");
                        Console.WriteLine($"Usage: RetroGate.CLI {Keyword} export <filepath> <output.json>");
                        return;
                    }
                    await ExportToJson(commandArgs[1], commandArgs[2]);
                    break;

                case "help":
                    ShowHelp();
                    break;

                default:
                    Console.WriteLine($"Unknown command: {command}");
                    ShowHelp();
                    break;
            }
        }

        private void ShowHelp()
        {
            Console.WriteLine("RetroGate CLI - Steam Shortcuts Manager");
            Console.WriteLine();
            Console.WriteLine("Usage:");
            Console.WriteLine($"  RetroGate.CLI {Keyword} <command> [options]");
            Console.WriteLine();
            Console.WriteLine("Commands:");
            Console.WriteLine("  list <filepath>              List all shortcuts from the specified file");
            Console.WriteLine("  show <filepath> <index>      Show detailed information about a specific shortcut");
            Console.WriteLine("  export <filepath> <output>   Export shortcuts to JSON file");
            Console.WriteLine("  help                         Show this help message");
            Console.WriteLine();
            Console.WriteLine("Examples:");
            Console.WriteLine($"  RetroGate.CLI {Keyword} list shortcuts.vdf");
            Console.WriteLine($"  RetroGate.CLI {Keyword} show shortcuts.vdf 0");
            Console.WriteLine($"  RetroGate.CLI {Keyword} export shortcuts.vdf shortcuts.json");
        }

        private async Task ListShortcuts(string filepath)
        {
            try
            {
                var shortcuts = await GetShortcuts(filepath);

                if (shortcuts.Count == 0)
                {
                    Console.WriteLine("No shortcuts found.");
                    return;
                }

                Console.WriteLine($"Found {shortcuts.Count} shortcut(s):");
                Console.WriteLine();

                for (int i = 0; i < shortcuts.Count; i++)
                {
                    var sc = shortcuts[i];
                    Console.WriteLine($"[{i}] {sc.AppName ?? "(No Name)"}");
                    Console.WriteLine($"    Executable: {sc.Exe ?? "(Not set)"}");
                    if (sc.Tags.Count > 0)
                    {
                        Console.WriteLine($"    Tags: {string.Join(", ", sc.Tags)}");
                    }
                    Console.WriteLine();
                }
            }
            catch (FileNotFoundException)
            {
                Console.WriteLine($"Error: File not found: {filepath}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error reading shortcuts: {ex.Message}");
            }
        }

        private async Task<List<SDK.Shortcut.Domain.Models.ShortcutModel>> GetShortcuts(string filepath)
        {
            var result = await getAllShortcuts.Call();
            return result.Match(
                Right: list => list,
                Left: error =>
                {
                    Console.WriteLine($"Error reading shortcuts: {error.Message}");
                    return new List<SDK.Shortcut.Domain.Models.ShortcutModel>();
                });
        }

        private async Task ShowShortcut(string filepath, int index)
        {
            try
            {
                var shortcuts = await GetShortcuts(filepath);

                if (index < 0 || index >= shortcuts.Count)
                {
                    Console.WriteLine($"Error: Index {index} is out of range. Valid range: 0-{shortcuts.Count - 1}");
                    return;
                }

                var sc = shortcuts[index];

                Console.WriteLine($"Shortcut Details [{index}]:");
                Console.WriteLine($"{"",2}App Name: {sc.AppName ?? "(Not set)"}");
                Console.WriteLine($"{"",2}App ID: {(sc.AppId != null ? BitConverter.ToUInt32(sc.AppId) : 0)}");
                Console.WriteLine($"{"",2}Executable: {sc.Exe ?? "(Not set)"}");
                Console.WriteLine($"{"",2}Start Directory: {sc.StartDir ?? "(Not set)"}");
                Console.WriteLine($"{"",2}Icon: {sc.Icon ?? "(Not set)"}");
                Console.WriteLine($"{"",2}Shortcut Path: {sc.ShortcutPath ?? "(Not set)"}");
                Console.WriteLine($"{"",2}Launch Options: {sc.LaunchOptions ?? "(Not set)"}");
                Console.WriteLine($"{"",2}Sort As: {sc.SortAs ?? "(Not set)"}");
                Console.WriteLine($"{"",2}Hidden: {sc.IsHidden}");
                Console.WriteLine($"{"",2}Allow Desktop Config: {sc.AllowDesktopConfig}");
                Console.WriteLine($"{"",2}Allow Overlay: {sc.AllowOverlay}");
                Console.WriteLine($"{"",2}OpenVR: {sc.OpenVR}");
                Console.WriteLine($"{"",2}Devkit: {sc.Devkit}");
                
                if (!string.IsNullOrEmpty(sc.DevkitGameID))
                {
                    Console.WriteLine($"{"",2}Devkit Game ID: {sc.DevkitGameID}");
                }
                
                if (sc.DevkitOverrideAppID != null)
                {
                    Console.WriteLine($"{"",2}Devkit Override App ID: {BitConverter.ToUInt32(sc.DevkitOverrideAppID)}");
                }
                
                if (sc.LastPlayTime != null)
                {
                    Console.WriteLine($"{"",2}Last Play Time: {BitConverter.ToUInt32(sc.LastPlayTime)}");
                }

                if (!string.IsNullOrEmpty(sc.FlatpakAppID))
                {
                    Console.WriteLine($"{"",2}Flatpak App ID: {sc.FlatpakAppID}");
                }

                if (sc.Tags.Count > 0)
                {
                    Console.WriteLine($"{"",2}Tags: {string.Join(", ", sc.Tags)}");
                }
            }
            catch (FileNotFoundException)
            {
                Console.WriteLine($"Error: File not found: {filepath}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error reading shortcuts: {ex.Message}");
            }
        }

        private async Task ExportToJson(string filepath, string outputPath)
        {
            try
            {
                var shortcuts = await GetShortcuts(filepath);

                var json = System.Text.Json.JsonSerializer.Serialize(shortcuts, new System.Text.Json.JsonSerializerOptions
                {
                    WriteIndented = true,
                    PropertyNamingPolicy = System.Text.Json.JsonNamingPolicy.CamelCase
                });

                File.WriteAllText(outputPath, json);
                Console.WriteLine($"Successfully exported {shortcuts.Count} shortcut(s) to {outputPath}");
            }
            catch (FileNotFoundException)
            {
                Console.WriteLine($"Error: File not found: {filepath}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error exporting shortcuts: {ex.Message}");
            }
        }
    }
}
