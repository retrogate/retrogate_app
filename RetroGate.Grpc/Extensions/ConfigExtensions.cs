using Google.Protobuf.Collections;
using RetroGate.Protos.Config.Proto.V1;

namespace RetroGate.Grpc.Extensions
{
    public static class ConfigExtensions
    {
        public static ConfigModel ToProto(this SDK.Core.Domain.Models.ConfigModel configModel)
        {
            return new ConfigModel
            {
                SteamPath = configModel.SteamPath,
                SteamUserId = configModel.SteamUserId,
                SteamGridDbApiKey = configModel.SteamGridDbApiKey,
                InstalledGamesPath = configModel.InstalledGamesPath
            };
        }

        public static SDK.Core.Domain.Models.ConfigModel ToDomain(this ConfigModel configModel)
        {
            return new SDK.Core.Domain.Models.ConfigModel
            {
                SteamPath = configModel.SteamPath,
                SteamUserId = configModel.SteamUserId,
                SteamGridDbApiKey = configModel.SteamGridDbApiKey,
                InstalledGamesPath = configModel.InstalledGamesPath
            };
        }
    }
}
