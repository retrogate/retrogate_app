using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RetroGate.SDK.Shortcut.Domain.Models
{
    public class ShortcutModel
    {
        public byte[]? AppId { get; set; }
        public string? AppName { get; set; }
        public string? Exe { get; set; }
        public string? StartDir { get; set; }
        public string? Icon { get; set; }
        public string? ShortcutPath { get; set; }
        public string? LaunchOptions { get; set; }
        public bool IsHidden { get; set; }
        public bool AllowDesktopConfig { get; set; }
        public bool AllowOverlay { get; set; }
        public bool OpenVR { get; set; }
        public bool Devkit { get; set; }
        public string? DevkitGameID { get; set; }
        public byte[]? DevkitOverrideAppID { get; set; }
        public byte[]? LastPlayTime { get; set; }
        public string? FlatpakAppID { get; set; }
        public string? SortAs { get; set; }
        public string? ImageHeroUrl { get; set; }
        public string? ImagePosterUrl { get; set; }
        public string? ImageLogoUrl { get; set; }
        public List<string> Tags { get; set; } = new List<string>();
    }
}
