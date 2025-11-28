namespace RetroGate.SDK.Installer.Domain.Models
{
    public enum InstallerProgressState
    {
        Idle,
        Downloading,
        Pending,
        Extracting,
        CreatingShortcut,
        Paused,
        Completed, 
        Failed,
        Cancelled,
        Uninstalled
    }

    public enum InstallerEventType
    {
        ProgressChanged
    }

    public class InstallerEventProgressChangedModel
    {
        public string GameId { get; set; } = string.Empty;
        public InstallerProgressState State { get; set; }
        public int Percentage { get; set; }
        public int SpeedInKbPerSec { get; set; }
    }

    public class InstallerEventModel
    {
        public InstallerEventType EventType { get; set; }
        public InstallerEventProgressChangedModel? ProgressChanged { get; set; }
    }
}