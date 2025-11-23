using RetroGate.Protos.Installer.Proto.V1;

namespace RetroGate.Grpc.Extensions
{
    public static class InstallerExtensions
    {
        // ProgressModel conversions
        public static ProgressModel ToProto(this SDK.Installer.Domain.Models.ProgressModel domain)
        {
            return new ProgressModel
            {
                Id = domain.Id,
                Status = domain.Status.ToProto(),
                Percentage = domain.Percentage,
                SpeedInKbPerSec = domain.SpeedInKbPerSec
            };
        }

        public static SDK.Installer.Domain.Models.ProgressModel ToDomain(this ProgressModel proto)
        {
            return new SDK.Installer.Domain.Models.ProgressModel
            {
                Id = proto.Id,
                Status = proto.Status.ToDomain(),
                Percentage = proto.Percentage,
                SpeedInKbPerSec = proto.SpeedInKbPerSec
            };
        }

        // ProgressStatus conversions
        public static ProgressStatus ToProto(this SDK.Installer.Domain.Models.ProgressStatus domain)
        {
            return domain switch
            {
                SDK.Installer.Domain.Models.ProgressStatus.Idle => ProgressStatus.Idle,
                SDK.Installer.Domain.Models.ProgressStatus.Downloading => ProgressStatus.Downloading,
                SDK.Installer.Domain.Models.ProgressStatus.Extracting => ProgressStatus.Extracting,
                SDK.Installer.Domain.Models.ProgressStatus.AddingToLibrary => ProgressStatus.AddingToLibrary,
                SDK.Installer.Domain.Models.ProgressStatus.Paused => ProgressStatus.Paused,
                SDK.Installer.Domain.Models.ProgressStatus.Completed => ProgressStatus.Completed,
                SDK.Installer.Domain.Models.ProgressStatus.Failed => ProgressStatus.Failed,
                _ => ProgressStatus.Idle
            };
        }

        public static SDK.Installer.Domain.Models.ProgressStatus ToDomain(this ProgressStatus proto)
        {
            return proto switch
            {
                ProgressStatus.Idle => SDK.Installer.Domain.Models.ProgressStatus.Idle,
                ProgressStatus.Downloading => SDK.Installer.Domain.Models.ProgressStatus.Downloading,
                ProgressStatus.Extracting => SDK.Installer.Domain.Models.ProgressStatus.Extracting,
                ProgressStatus.AddingToLibrary => SDK.Installer.Domain.Models.ProgressStatus.AddingToLibrary,
                ProgressStatus.Paused => SDK.Installer.Domain.Models.ProgressStatus.Paused,
                ProgressStatus.Completed => SDK.Installer.Domain.Models.ProgressStatus.Completed,
                ProgressStatus.Failed => SDK.Installer.Domain.Models.ProgressStatus.Failed,
                _ => SDK.Installer.Domain.Models.ProgressStatus.Idle
            };
        }
    }
}
