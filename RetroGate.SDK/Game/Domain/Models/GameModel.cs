namespace RetroGate.SDK.Game.Domain.Models
{
    public enum GameInstallationMethod
    {
        Extract,
    }

    public class GameModel
    {
        public string Id { get; set; } = string.Empty;
        public string Name { get; set; } = string.Empty;
        public string DownloadUrl { get; set; } = string.Empty;
        public string ExecutablePath { get; set; } = string.Empty;
        public string ImageHeroUrl { get; set; } = string.Empty;
        public string ImagePosterUrl { get; set; } = string.Empty;
        public string ImageLogoUrl { get; set; } = string.Empty;
        public GameInstallationMethod InstallationMethod { get; set; }
    }
}
