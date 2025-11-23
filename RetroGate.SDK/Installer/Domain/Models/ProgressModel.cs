namespace RetroGate.SDK.Installer.Domain.Models
{
    public enum ProgressStatus
    {
        Idle,
        Downloading,
        Extracting,
        ExecutingPostActions,
        AddingToLibrary,
        Paused,
        Completed,
        Failed,
    }

    public class ProgressModel
    {
        public string Id { get; set; } = string.Empty;
        public ProgressStatus Status { get; set; }
        public int Percentage { get; set; }
        public int SpeedInKbPerSec { get; set; }
    }
}
