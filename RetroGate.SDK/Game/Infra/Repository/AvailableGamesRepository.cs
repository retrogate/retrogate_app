using RetroGate.SDK.Game.Domain.Repository;
using RetroGate.SDK.Game.Domain.Usecases;

namespace RetroGate.SDK.Game.Infra.Repository
{
    public class AvailableGamesRepository(IGetGameImages getGameImages) : GameRepository(getGameImages, "games.json"), IAvailableGamesRepository
    {
    }
}