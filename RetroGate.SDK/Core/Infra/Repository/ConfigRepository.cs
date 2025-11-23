using LanguageExt;
using LanguageExt.Pretty;
using RetroGate.SDK.Core.Domain.Models;
using RetroGate.SDK.Core.Domain.Repository;
using RetroGate.SDK.Core.Errors;

namespace RetroGate.SDK.Core.Infra
{
    public class ConfigRepository : IConfigRepository
    {
        private const string _configFileName = "retrogate_config.json";

        private const string _deafultSteamPath = "C:\\Program Files (x86)\\Steam";

        public Task<Either<ErrorBase, ConfigModel>> GetConfig()
        {
            var config = LoadFromFile();
            return Task.FromResult(config != null
                ? Prelude.Right<ErrorBase, ConfigModel>(config)
                : Prelude.Left<ErrorBase, ConfigModel>(new ErrorNotFound()));
        }

        public Task<Either<ErrorBase, Unit>> SetConfig(ConfigModel config)
        {
            SaveToFile(config);
            return Task.FromResult(Prelude.Right<ErrorBase, Unit>(Unit.Default));
        }

        private static void SaveToFile(ConfigModel config)
        {
            var json = System.Text.Json.JsonSerializer.Serialize(config);
            File.WriteAllText(_configFileName, json);
        }

        private static ConfigModel LoadFromFile()
        {
            if (!File.Exists(_configFileName))
            {
                return new ConfigModel()
                {
                    SteamPath = _deafultSteamPath,
                    SteamUserId = GetSteamUserId(),
                    SteamGridDbApiKey = string.Empty
                };
            }
            var json = File.ReadAllText(_configFileName);
            return System.Text.Json.JsonSerializer.Deserialize<ConfigModel>(json) ?? new ConfigModel();
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
    }
}
