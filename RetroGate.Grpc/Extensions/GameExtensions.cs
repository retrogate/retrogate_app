using Google.Protobuf.Collections;
using RetroGate.Protos.Game.Proto.V1;

namespace RetroGate.Grpc.Extensions
{
    public static class GameExtensions
    {
        public static GameModel ToProto(this SDK.Game.Domain.Models.GameModel domain)
        {
            var proto = new GameModel
            {
                Id = domain.Id,
                Name = domain.Name ?? string.Empty,
                DownloadUrl = domain.DownloadUrl ?? string.Empty,
                ExecutablePath = domain.ExecutablePath ?? string.Empty,
                ImageHeroUrl = domain.ImageHeroUrl ?? string.Empty,
                ImagePosterUrl = domain.ImagePosterUrl ?? string.Empty,
                ImageLogoUrl = domain.ImageLogoUrl ?? string.Empty,
            };
            
            if (domain.SettingsFile != null)
            {
                proto.SettingsFile = domain.SettingsFile;
            }
            
            return proto;
        }

        public static SDK.Game.Domain.Models.GameModel ToDomain(this GameModel proto)
        {
            return new SDK.Game.Domain.Models.GameModel
            {
                Id = proto.Id,
                Name = proto.Name,
                DownloadUrl = proto.DownloadUrl,
                ExecutablePath = proto.ExecutablePath,
                ImageHeroUrl = proto.ImageHeroUrl,
                ImagePosterUrl = proto.ImagePosterUrl,
                ImageLogoUrl = proto.ImageLogoUrl,
                SettingsFile = proto.HasSettingsFile ? proto.SettingsFile : null,
            };
        }

        public static IEnumerable<GameModel> ToProto(this IEnumerable<SDK.Game.Domain.Models.GameModel> domains)
        {
            return domains.Select(d => d.ToProto());
        }

        public static IEnumerable<SDK.Game.Domain.Models.GameModel> ToDomain(this IEnumerable<GameModel> protos)
        {
            return protos.Select(p => p.ToDomain());
        }

        public static void AddRangeFromDomain(this RepeatedField<GameModel> field, IEnumerable<SDK.Game.Domain.Models.GameModel> domains)
        {
            field.AddRange(domains.ToProto());
        }

        public static GameImagesModel ToProto(this SDK.Game.Domain.Models.GameImagesModel domain)
        {
            var proto = new GameImagesModel
            {
                HeroUrl = domain.HeroUrl,
                PosterUrl = domain.PosterUrl,
                LogoUrl = domain.LogoUrl
            };
            return proto;
        }

        public static SDK.Game.Domain.Models.GameImagesModel ToDomain(this GameImagesModel proto)
        {
            return new SDK.Game.Domain.Models.GameImagesModel
            {
                HeroUrl = proto.HeroUrl,
                PosterUrl = proto.PosterUrl,
                LogoUrl = proto.LogoUrl
            };
        }

        public static GameSource ToProto(SDK.Game.Domain.Models.GameSource source)
        {
            return source switch
            {
                SDK.Game.Domain.Models.GameSource.AvailableGames => GameSource.Available,
                SDK.Game.Domain.Models.GameSource.InstalledGames => GameSource.Installed,
                _ => throw new ArgumentOutOfRangeException(nameof(source), source, null)
            };
        }

        public static SDK.Game.Domain.Models.GameSource ToDomain(this GameSource proto)
        {
            return proto switch
            {
                GameSource.Available => SDK.Game.Domain.Models.GameSource.AvailableGames,
                GameSource.Installed => SDK.Game.Domain.Models.GameSource.InstalledGames,
                _ => throw new ArgumentOutOfRangeException(nameof(proto), proto, null)
            };
        }
    }
}
