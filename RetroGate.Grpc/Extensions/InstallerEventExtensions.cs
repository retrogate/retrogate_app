using RetroGate.Protos.Installer.Proto.V1;

namespace RetroGate.Grpc.Extensions
{
    public static class InstallerEventExtensions
    {
        public static InstallerEventModel ToProto(this SDK.Installer.Domain.Models.InstallerEventModel domain)
        {
            return domain.EventType switch
            {
                SDK.Installer.Domain.Models.InstallerEventType.ProgressChanged => new InstallerEventModel
                {
                    ProgressChanged = domain.ProgressChanged!.ToProto(),
                },
                _ => new InstallerEventModel
                {
                },
            };
        }

        public static SDK.Installer.Domain.Models.InstallerEventModel ToDomain(this InstallerEventModel proto)
        {
            return proto.EventCase switch
            {
                InstallerEventModel.EventOneofCase.ProgressChanged => new SDK.Installer.Domain.Models.InstallerEventModel
                {
                    EventType = SDK.Installer.Domain.Models.InstallerEventType.ProgressChanged,
                    ProgressChanged = proto.ProgressChanged.ToDomain(),
                },
                _ => new SDK.Installer.Domain.Models.InstallerEventModel
                {
                    EventType = SDK.Installer.Domain.Models.InstallerEventType.ProgressChanged,
                },
            };
        }

        public static InstallerEventProgressChangedModel ToProto(this SDK.Installer.Domain.Models.InstallerEventProgressChangedModel domain)
        {
            return new InstallerEventProgressChangedModel
            {
                GameId = domain.GameId,
                State = domain.State.ToProto(),
                Percentage = domain.Percentage,
                SpeedInKbPerSec = domain.SpeedInKbPerSec,
            };
        }

        public static SDK.Installer.Domain.Models.InstallerEventProgressChangedModel ToDomain(this InstallerEventProgressChangedModel proto)
        {
            return new SDK.Installer.Domain.Models.InstallerEventProgressChangedModel
            {
                GameId = proto.GameId,
                State = proto.State.ToDomain(),
                Percentage = proto.Percentage,
                SpeedInKbPerSec = proto.SpeedInKbPerSec,
            };
        }

        public static InstallerProgressState ToProto(this SDK.Installer.Domain.Models.InstallerProgressState domain)
        {
            return domain switch
            {
                SDK.Installer.Domain.Models.InstallerProgressState.Idle => InstallerProgressState.Idle,
                SDK.Installer.Domain.Models.InstallerProgressState.Downloading => InstallerProgressState.Downloading,
                SDK.Installer.Domain.Models.InstallerProgressState.Extracting => InstallerProgressState.Extracting,
                SDK.Installer.Domain.Models.InstallerProgressState.CreatingShortcut => InstallerProgressState.CreatingShortcut,
                SDK.Installer.Domain.Models.InstallerProgressState.Paused => InstallerProgressState.Paused,
                SDK.Installer.Domain.Models.InstallerProgressState.Failed => InstallerProgressState.Failed,
                SDK.Installer.Domain.Models.InstallerProgressState.Completed => InstallerProgressState.Completed,
                _ => InstallerProgressState.Idle,
            };
        }

        public static SDK.Installer.Domain.Models.InstallerProgressState ToDomain(this InstallerProgressState proto)
        {
            return proto switch
            {
                InstallerProgressState.Idle => SDK.Installer.Domain.Models.InstallerProgressState.Idle,
                InstallerProgressState.Downloading => SDK.Installer.Domain.Models.InstallerProgressState.Downloading,
                InstallerProgressState.Extracting => SDK.Installer.Domain.Models.InstallerProgressState.Extracting,
                InstallerProgressState.CreatingShortcut => SDK.Installer.Domain.Models.InstallerProgressState.CreatingShortcut,
                InstallerProgressState.Paused => SDK.Installer.Domain.Models.InstallerProgressState.Paused,
                InstallerProgressState.Failed => SDK.Installer.Domain.Models.InstallerProgressState.Failed,
                InstallerProgressState.Completed => SDK.Installer.Domain.Models.InstallerProgressState.Completed,
                _ => SDK.Installer.Domain.Models.InstallerProgressState.Idle,
            };
        }
    }
}