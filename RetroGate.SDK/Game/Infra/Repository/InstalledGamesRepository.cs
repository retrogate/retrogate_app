using LanguageExt;
using RetroGate.SDK.Core.Domain.Models;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Models;
using RetroGate.SDK.Game.Domain.Repository;
using RetroGate.SDK.Game.Domain.Usecases;

namespace RetroGate.SDK.Game.Infra.Repository
{
    public class InstalledGamesRepository(
        ConfigModel config,
        IAvailableGamesRepository availableGamesRepository,
        IGetGameImages getGameImages) : GameRepository(getGameImages, "installed_games.json"), IInstalledGamesRepository
    {
        public async Task<Either<ErrorBase, List<GameModel>>> FindInstalledGames()
        {
            var games = new List<GameModel>();
            var InstalledGamesPath = config.InstalledGamesPath;
            var directoryInfo = new DirectoryInfo(InstalledGamesPath);
            if (!directoryInfo.Exists)
            {
                return games;
            }
            foreach (var dir in directoryInfo.GetDirectories())
            {
                var folderName = dir.Name!;
                var game = await availableGamesRepository.GetById(folderName);
                game.Match(
                    Right: async g =>
                    {
                        games.Add(g);
                        var create = await Create(g);
                    },
                    Left: _ => { }
                );
            }
            return games;
        }
    }
}