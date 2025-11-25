using RetroGate.SDK.Game.Domain.Repository;
using RetroGate.SDK.Game.Domain.Usecases;

namespace RetroGate.SDK.Game.Infra.Repository
{
    public class InstalledGamesRepository(IGetGameImages getGameImages) : GameRepository(getGameImages, "installed_games.json"), IInstalledGamesRepository
    {
    }
}