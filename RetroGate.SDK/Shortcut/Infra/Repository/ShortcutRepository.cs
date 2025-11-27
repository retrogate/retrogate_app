using LanguageExt;
using RetroGate.SDK.Core.Domain.Models;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Shortcut.Domain.Models;
using RetroGate.SDK.Shortcut.Domain.Repository;
using System.Diagnostics;
using System.Text;

namespace RetroGate.SDK.Shortcut.Infra.Repository
{
    public class ShortcutRepository(ConfigModel _config) : IShortcutRepository
    {
        private static readonly HttpClient _httpClient = new HttpClient();

        public Task<Either<ErrorBase, List<ShortcutModel>>> GetAll()
        {
            var filepath = Path.Combine(_config.SteamPath, "userdata", _config.SteamUserId, "config", "shortcuts.vdf");

            if (!File.Exists(filepath) || new FileInfo(filepath).Length == 0)
                return Task.FromResult<Either<ErrorBase, List<ShortcutModel>>>(new ErrorFileNotFound());

            using var fs = File.OpenRead(filepath);
            using var reader = new BinaryReader(fs, Encoding.UTF8);

            byte rootType = reader.ReadByte();
            string rootKey = ReadNullTerminatedString(reader);

            if (rootType != 0x00 || rootKey != "shortcuts")
                throw new Exception("Unexpected root key or type");

            List<ShortcutModel> shortcuts = new List<ShortcutModel>();

            while (true)
            {
                byte type = reader.ReadByte();
                if (type == 0x08) break; // end of shortcuts dictionary

                if (type != 0x00)
                    throw new Exception($"Expected dictionary key (0x00), got 0x{type:X2}");

                ShortcutModel shortcut = ParseShortcut(reader);
                shortcuts.Add(shortcut);
            }

            return Task.FromResult<Either<ErrorBase, List<ShortcutModel>>>(shortcuts);
        }

        private async Task CreateGridImages(ShortcutModel shortcut)
        {
            if (shortcut.AppId == null || shortcut.AppId.Length != 4)
            {
                Console.WriteLine("[ShortcutRepository] AppId inválido, não é possível criar imagens do grid.");
                return;
            }

            // Converte AppId para uint
            uint appId = BitConverter.ToUInt32(shortcut.AppId, 0);
            string gridPath = Path.Combine(_config.SteamPath, "userdata", _config.SteamUserId, "config", "grid");

            // Cria o diretório grid se não existir
            if (!Directory.Exists(gridPath))
            {
                Directory.CreateDirectory(gridPath);
                Console.WriteLine($"[ShortcutRepository] Criado diretório: {gridPath}");
            }

            // Baixa Hero Image (imagem horizontal grande)
            if (!string.IsNullOrEmpty(shortcut.ImageHeroUrl))
            {
                string heroPath = Path.Combine(gridPath, $"{appId}_hero.jpg");
                await DownloadImage(shortcut.ImageHeroUrl, heroPath, "Hero");
            }

            // Baixa Poster Image (imagem vertical)
            if (!string.IsNullOrEmpty(shortcut.ImagePosterUrl))
            {
                string posterPath = Path.Combine(gridPath, $"{appId}p.jpg");
                await DownloadImage(shortcut.ImagePosterUrl, posterPath, "Poster");
            }

            // Baixa Logo Image (logo/ícone)
            if (!string.IsNullOrEmpty(shortcut.ImageLogoUrl))
            {
                string logoPath = Path.Combine(gridPath, $"{appId}.jpg");
                await DownloadImage(shortcut.ImageLogoUrl, logoPath, "Logo");
            }
        }

        private async Task DeleteGridImages(ShortcutModel shortcut)
        {
            if (shortcut.AppId == null || shortcut.AppId.Length != 4)
            {
                Console.WriteLine("[ShortcutRepository] AppId inválido, não é possível deletar imagens do grid.");
                return;
            }

            // Converte AppId para uint
            uint appId = BitConverter.ToUInt32(shortcut.AppId, 0);
            string gridPath = Path.Combine(_config.SteamPath, "userdata", _config.SteamUserId, "config", "grid");

            // Deleta Hero Image (imagem horizontal grande)
            string heroPath = Path.Combine(gridPath, $"{appId}_hero.jpg");
            if (File.Exists(heroPath))
            {
                File.Delete(heroPath);
                Console.WriteLine($"[ShortcutRepository] Deletado Hero Image: {heroPath}");
            }

            // Deleta Poster Image (imagem vertical)
            string posterPath = Path.Combine(gridPath, $"{appId}p.jpg");
            if (File.Exists(posterPath))
            {
                File.Delete(posterPath);
                Console.WriteLine($"[ShortcutRepository] Deletado Poster Image: {posterPath}");
            }

            // Deleta Logo Image (logo/ícone)
            string logoPath = Path.Combine(gridPath, $"{appId}.jpg");
            if (File.Exists(logoPath))
            {
                File.Delete(logoPath);
                Console.WriteLine($"[ShortcutRepository] Deletado Logo Image: {logoPath}");
            }
        }

        private async Task DownloadImage(string url, string savePath, string imageType)
        {
            try
            {
                Console.WriteLine($"[ShortcutRepository] Baixando {imageType} de: {url}");
                
                var response = await _httpClient.GetAsync(url);
                response.EnsureSuccessStatusCode();

                var imageBytes = await response.Content.ReadAsByteArrayAsync();
                await File.WriteAllBytesAsync(savePath, imageBytes);

                Console.WriteLine($"[ShortcutRepository] {imageType} salva em: {savePath}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"[ShortcutRepository] Erro ao baixar {imageType}: {ex.Message}");
            }
        }

        public async Task<Either<ErrorBase, ShortcutModel>> Create(ShortcutModel shortcut)
        {
            var filepath = Path.Combine(_config.SteamPath, "userdata", _config.SteamUserId, "config", "shortcuts.vdf");
            List<ShortcutModel> shortcuts = new List<ShortcutModel>();
            if (File.Exists(filepath) && new FileInfo(filepath).Length > 0)
            {
                var getAllResult = GetAll().Result;
                if (getAllResult.IsRight)
                {
                    shortcuts = getAllResult.RightToList()[0];
                }
            }
        
            var appId = GenerateAppID(shortcut.Exe ?? "", shortcut.AppName ?? "");
            shortcut.AppId = BitConverter.GetBytes(appId);

            if(shortcuts.Any(s => s.AppId != null && BitConverter.ToUInt32(s.AppId, 0) == appId))
            {
                return new ErrorAlreadyExists();
            }

            shortcuts.Add(shortcut);
            WriteShortcuts(filepath, shortcuts);

            // Cria as imagens do grid após criar o shortcut
            await CreateGridImages(shortcut);

            return shortcut;
        }

        private static ShortcutModel ParseShortcut(BinaryReader reader)
        {
            var sc = new ShortcutModel();

            string index = ReadNullTerminatedString(reader);
            Debug.WriteLine($"Parsing shortcut index: {index}");

            while (true)
            {
                byte type = reader.ReadByte();
                if (type == 0x08) break; // end of this shortcut dict

                string key = ReadNullTerminatedString(reader);

                switch (type)
                {
                    case 0x00: // nested dict, e.g. tags
                        if (key == "tags")
                            sc.Tags = ParseTags(reader);
                        else
                            SkipDictionary(reader);
                        break;
                    case 0x01: // string
                        string val = ReadNullTerminatedString(reader);
                        AssignString(sc, key, val);
                        break;
                    case 0x02: // int32
                        int intval = reader.ReadInt32();
                        AssignInt(sc, key, intval);
                        break;
                    default:
                        throw new Exception($"Unknown type 0x{type:X2} for key '{key}'");
                }
            }
            return sc;
        }

        private static List<string> ParseTags(BinaryReader reader)
        {
            var tags = new List<string>();
            while (true)
            {
                byte type = reader.ReadByte();
                if (type == 0x08) break; // end of tags dict

                if (type != 0x01)
                    throw new Exception($"Unexpected type in tags dict: 0x{type:X2}");

                string val = ReadNullTerminatedString(reader);
                tags.Add(val);
            }
            return tags;
        }

        private static void SkipDictionary(BinaryReader reader)
        {
            while (true)
            {
                byte type = reader.ReadByte();
                if (type == 0x08) break; // end of dictionary

                switch (type)
                {
                    case 0x00:
                        SkipDictionary(reader);
                        break;
                    case 0x01:
                        ReadNullTerminatedString(reader);
                        break;
                    case 0x02:
                        reader.ReadInt32();
                        break;
                    default:
                        throw new Exception($"Unknown type 0x{type:X2} while skipping dict");
                }
            }
        }

        private static void AssignString(ShortcutModel sc, string key, string val)
        {
            switch (key)
            {
                case "appname": sc.AppName = val; break;
                case "Exe": sc.Exe = val; break;
                case "StartDir": sc.StartDir = val; break;
                case "icon": sc.Icon = val; break;
                case "ShortcutPath": sc.ShortcutPath = val; break;
                case "LaunchOptions": sc.LaunchOptions = val; break;
                case "FlatpakAppID": sc.FlatpakAppID = val; break;
                case "sortas": sc.SortAs = val; break;
                case "DevkitGameID": sc.DevkitGameID = val; break;
                default: break; // unknown string keys ignored
            }
        }

        private static void AssignInt(ShortcutModel sc, string key, int val)
        {
            switch (key)
            {
                case "appid": sc.AppId = BitConverter.GetBytes(val); break;
                case "IsHidden": sc.IsHidden = val != 0; break;
                case "AllowDesktopConfig": sc.AllowDesktopConfig = val != 0; break;
                case "AllowOverlay": sc.AllowOverlay = val != 0; break;
                case "OpenVR": sc.OpenVR = val != 0; break;
                case "Devkit": sc.Devkit = val != 0; break;
                case "DevkitOverrideAppID": sc.DevkitOverrideAppID = BitConverter.GetBytes(val); break;
                case "LastPlayTime": sc.LastPlayTime = BitConverter.GetBytes(val); break;
                default: break; // unknown int keys ignored
            }
        }
        private static string ReadNullTerminatedString(BinaryReader reader)
        {
            var bytes = new List<byte>();
            while (true)
            {
                byte b = reader.ReadByte();
                if (b == 0) break;
                bytes.Add(b);
            }
            return Encoding.UTF8.GetString(bytes.ToArray());
        }

        private static byte[] BuildShortcuts(List<ShortcutModel> shortcuts)
        {
            var seenAppIds = new System.Collections.Generic.HashSet<string>();

            for (int i = 0; i < shortcuts.Count; i++)
            {
                if (shortcuts[i].AppId == null)
                    continue;

                string appIdString = BitConverter.ToString(shortcuts[i].AppId ?? [0, 0, 0, 0]);
                if (seenAppIds.Contains(appIdString))
                {
                    Console.WriteLine($"Warning: Duplicate AppID found: {appIdString}. Aborting shortcut build.");
                    return Array.Empty<byte>();
                }
                seenAppIds.Add(appIdString);
            }

            using var ms = new MemoryStream();
            using var writer = new BinaryWriter(ms, Encoding.UTF8);

            writer.Write((byte)0x00); // null terminator
            writer.Write(Encoding.ASCII.GetBytes("shortcuts"));
            writer.Write((byte)0x00);

            if (shortcuts.Count > 0)
            {
                for (int i = 0; i < shortcuts.Count; i++)
                {
                    writer.Write((byte)0x00); // null terminator
                    writer.Write(Encoding.ASCII.GetBytes(i.ToString()));
                    writer.Write((byte)0x00);

                    writer.Write(BuildShortcut(shortcuts[i]));

                    writer.Write((byte)0x08); // end of shortcut
                }
            }
            else
            {
                Console.WriteLine("Warning: Empty list recived, no shortcuts to write.");
            }

            writer.Write((byte)0x08); // end of shortcuts dict
            writer.Write((byte)0x08); // end of root dict

            return ms.ToArray();
        }

        private static byte[] BuildShortcut(ShortcutModel shortcut)
        {
            using var ms = new MemoryStream();
            using var writer = new BinaryWriter(ms, Encoding.UTF8);

            // Write AppID: type (0x02), key, null terminator, then 4 raw bytes (no terminator)
            writer.Write((byte)0x02); // int32 type
            writer.Write(Encoding.ASCII.GetBytes("appid"));
            writer.Write((byte)0x00);
            if (shortcut.AppId != null && shortcut.AppId.Length == 4)
                writer.Write(shortcut.AppId);
            else
                writer.Write([0, 0, 0, 0]);

            if (shortcut.AppName == null || shortcut.Exe == null)
            {
                Console.WriteLine("Error: AppName and Exe are required fields for a shortcut. Aborting build.");
                return Array.Empty<byte>();
            }

            WriteStringField(writer, "appname", shortcut.AppName);
            WriteStringField(writer, "Exe", shortcut.Exe);
            WriteStringField(writer, "StartDir", shortcut.StartDir ?? "");
            WriteStringField(writer, "icon", shortcut.Icon ?? "");
            WriteStringField(writer, "ShortcutPath", shortcut.ShortcutPath ?? "");
            WriteStringField(writer, "LaunchOptions", shortcut.LaunchOptions ?? "");
            WriteBoolField(writer, "IsHidden", shortcut.IsHidden);
            WriteBoolField(writer, "AllowDesktopConfig", shortcut.AllowDesktopConfig);
            WriteBoolField(writer, "AllowOverlay", shortcut.AllowOverlay);
            WriteBoolField(writer, "OpenVR", shortcut.OpenVR);
            WriteBoolField(writer, "Devkit", shortcut.Devkit);
            WriteStringField(writer, "DevkitGameID", shortcut.DevkitGameID ?? "");
            WriteIntField(writer, "DevkitOverrideAppID", GetIntFromBytes(shortcut.DevkitOverrideAppID ?? [0, 0, 0, 0]));
            WriteIntField(writer, "LastPlayTime", GetIntFromBytes(shortcut.LastPlayTime ?? [0, 0, 0, 0]));
            WriteStringField(writer, "FlatpakAppID", shortcut.FlatpakAppID ?? "");
            WriteStringField(writer, "sortas", shortcut.SortAs ?? "");

            WriteTags(writer, shortcut.Tags);

            return ms.ToArray();
        }

        // Helper to write string fields
        private static void WriteStringField(BinaryWriter writer, string key, string value)
        {
            writer.Write((byte)0x01); // string type
            writer.Write(Encoding.ASCII.GetBytes(key));
            writer.Write((byte)0x00);
            writer.Write(Encoding.UTF8.GetBytes(value));
            writer.Write((byte)0x00);
        }

        // Helper to write bool fields (int32 with 0 or 1)
        private static void WriteBoolField(BinaryWriter writer, string key, bool value)
        {
            writer.Write((byte)0x02); // int32 type
            writer.Write(Encoding.ASCII.GetBytes(key));
            writer.Write((byte)0x00);
            writer.Write(value ? 1 : 0);
        }

        // Helper to write int32 fields
        private static void WriteIntField(BinaryWriter writer, string key, int value)
        {
            writer.Write((byte)0x02); // int32 type
            writer.Write(Encoding.ASCII.GetBytes(key));
            writer.Write((byte)0x00);
            writer.Write(value);
        }
        private static int GetIntFromBytes(byte[] bytes)
        {
            if (bytes == null || bytes.Length < 4) return 0;
            return BitConverter.ToInt32(bytes, 0);
        }

        // Helper to write tags dictionary
        private static void WriteTags(BinaryWriter writer, List<string> tags)
        {
            writer.Write((byte)0x00); // begin dict
            writer.Write(Encoding.ASCII.GetBytes("tags"));
            writer.Write((byte)0x00);

            for (int i = 0; i < tags.Count; i++)
            {
                writer.Write((byte)0x01); // string type
                writer.Write(Encoding.ASCII.GetBytes(i.ToString()));
                writer.Write((byte)0x00);
                writer.Write(Encoding.UTF8.GetBytes(tags[i]));
                writer.Write((byte)0x00);
            }

            writer.Write((byte)0x08); // end dict
        }

        private static void WriteShortcuts(string filePath, List<ShortcutModel> shortcuts)
        {
            using var fs = new FileStream(filePath, FileMode.Create, FileAccess.Write);
            using var writer = new BinaryWriter(fs, Encoding.UTF8);

            // Write root dictionary start
            writer.Write((byte)0x00);
            writer.Write(Encoding.UTF8.GetBytes("shortcuts"));
            writer.Write((byte)0x00);

            for (int i = 0; i < shortcuts.Count; i++)
            {
                writer.Write((byte)0x00); // dictionary key type (string)
                writer.Write(Encoding.UTF8.GetBytes(i.ToString()));
                writer.Write((byte)0x00);

                // Write shortcut binary data
                var shortcutBytes = BuildShortcut(shortcuts[i]);
                writer.Write(shortcutBytes);

                writer.Write((byte)0x08); // end of shortcut dictionary
            }

            // Write final end markers for shortcuts dictionary
            writer.Write((byte)0x08);
            writer.Write((byte)0x08);
        }

        private static uint ComputeCRC32(byte[] bytes)
        {
            const uint Polynomial = 0xEDB88320;
            uint[] table = new uint[256];
            for (uint i = 0; i < 256; i++)
            {
                uint temp = i;
                for (int j = 0; j < 8; j++)
                    temp = (temp & 1) == 1 ? (Polynomial ^ (temp >> 1)) : (temp >> 1);
                table[i] = temp;
            }

            uint crc = 0xFFFFFFFF;
            foreach (byte b in bytes)
            {
                byte index = (byte)((crc & 0xFF) ^ b);
                crc = (crc >> 8) ^ table[index];
            }
            return ~crc;
        }

        public static uint GenerateAppID(string exePath, string appName)
        {
            var key = Encoding.UTF8.GetBytes(exePath + appName);
            var hash = ComputeCRC32(key);
            var top = hash | 0x80000000;
            return (top << 32) | 0x02000000;
        }

        private static string GenerateEncryptedAppID(ShortcutModel shortcut)
        {
            uint appid = GenerateAppID(shortcut.Exe ?? "", shortcut.AppName ?? "");

            byte[] bytes = BitConverter.GetBytes(appid);
            if (!BitConverter.IsLittleEndian)
                Array.Reverse(bytes);

            return Encoding.Latin1.GetString(bytes);
        }

        public async Task<Either<ErrorBase, Unit>> Delete(string appId)
        {
            var filepath = Path.Combine(_config.SteamPath, "userdata", _config.SteamUserId, "config", "shortcuts.vdf");
            List<ShortcutModel> shortcuts = new List<ShortcutModel>();
            if (File.Exists(filepath) && new FileInfo(filepath).Length > 0)
            {
                var getAllResult = GetAll().Result;
                if (getAllResult.IsRight)
                {
                    shortcuts = getAllResult.RightToList()[0];
                }
            }

            var shortcutToRemove = shortcuts.FirstOrDefault(s => s.AppId != null && BitConverter.ToUInt32(s.AppId, 0).ToString() == appId);
            if (shortcutToRemove == null)
            {
                return new ErrorNotFound();
            }
        
            shortcuts.Remove(shortcutToRemove);
            WriteShortcuts(filepath, shortcuts);
            await DeleteGridImages(shortcutToRemove);

            return Unit.Default;
        }
    }
}
