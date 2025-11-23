using Google.Protobuf.Collections;
using RetroGate.Protos.Shortcut.Proto.V1;

namespace RetroGate.Grpc.Extensions
{
    public static class ShortcutExtensions
    {
        public static ShortcutModel ToProto(this SDK.Shortcut.Domain.Models.ShortcutModel domain)
        {
            var proto = new ShortcutModel
            {
                AppId = domain.AppId != null ? BitConverter.ToUInt32(domain.AppId) : 0,
                AppName = domain.AppName ?? string.Empty,
                Exe = domain.Exe ?? string.Empty,
                StartDir = domain.StartDir ?? string.Empty,
                Icon = domain.Icon ?? string.Empty,
                ShortcutPath = domain.ShortcutPath ?? string.Empty,
                LaunchOptions = domain.LaunchOptions ?? string.Empty,
                IsHidden = domain.IsHidden,
                AllowDesktopConfig = domain.AllowDesktopConfig,
                AllowOverlay = domain.AllowOverlay,
                OpenVr = domain.OpenVR,
                Devkit = domain.Devkit,
                DevkitGameId = domain.DevkitGameID ?? string.Empty,
                DevkitOverrideAppId = domain.DevkitOverrideAppID != null ? BitConverter.ToUInt32(domain.DevkitOverrideAppID) : 0,
                LastPlayTime = domain.LastPlayTime != null ? BitConverter.ToUInt32(domain.LastPlayTime) : 0,
                FlatpakAppId = domain.FlatpakAppID ?? string.Empty,
                SortAs = domain.SortAs ?? string.Empty,
            };

            //proto.Tags.AddRange(domain.Tags);

            return proto;
        }

        public static SDK.Shortcut.Domain.Models.ShortcutModel ToDomain(this ShortcutModel proto)
        {
            return new SDK.Shortcut.Domain.Models.ShortcutModel
            {
                AppId = BitConverter.GetBytes(proto.AppId),
                AppName = proto.AppName,
                Exe = proto.Exe,
                StartDir = proto.StartDir,
                Icon = proto.Icon,
                ShortcutPath = proto.ShortcutPath,
                LaunchOptions = proto.LaunchOptions,
                IsHidden = proto.IsHidden,
                AllowDesktopConfig = proto.AllowDesktopConfig,
                AllowOverlay = proto.AllowOverlay,
                OpenVR = proto.OpenVr,
                Devkit = proto.Devkit,
                DevkitGameID = proto.DevkitGameId,
                DevkitOverrideAppID = BitConverter.GetBytes(proto.DevkitOverrideAppId),
                LastPlayTime = BitConverter.GetBytes(proto.LastPlayTime),
                FlatpakAppID = proto.FlatpakAppId,
                SortAs = proto.SortAs,
                //Tags = proto.Tags.ToList()
            };
        }

        public static IEnumerable<ShortcutModel> ToProto(this IEnumerable<SDK.Shortcut.Domain.Models.ShortcutModel> domains)
        {
            return domains.Select(d => d.ToProto());
        }

        public static IEnumerable<SDK.Shortcut.Domain.Models.ShortcutModel> ToDomain(this IEnumerable<ShortcutModel> protos)
        {
            return protos.Select(p => p.ToDomain());
        }

        public static void AddRangeFromDomain(this RepeatedField<ShortcutModel> field, IEnumerable<SDK.Shortcut.Domain.Models.ShortcutModel> domains)
        {
            field.AddRange(domains.ToProto());
        }
    }
}
