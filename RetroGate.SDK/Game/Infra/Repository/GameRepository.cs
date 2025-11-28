using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Models;
using RetroGate.SDK.Game.Domain.Repository;
using RetroGate.SDK.Game.Domain.Usecases;
using RetroGate.SDK.Shortcut.Infra.Repository;

namespace RetroGate.SDK.Game.Infra.Repository
{
    public class GameRepository(IGetGameImages getGameImages, string fileName) : IGameRepository
    {
        public async Task<Either<ErrorBase, GameModel>> Create(GameModel game)
        {
            if((game.ImageHeroUrl == null || game.ImageHeroUrl == "") && 
                (game.ImagePosterUrl == null || game.ImagePosterUrl == "") &&
                (game.ImageLogoUrl == null || game.ImageLogoUrl == ""))
            {
                var imagesResult = await getGameImages.Call(game.Name);
                imagesResult.Match(
                    Right: images =>
                    {
                        game.ImageHeroUrl = images.HeroUrl;
                        game.ImagePosterUrl = images.PosterUrl;
                        game.ImageLogoUrl = images.LogoUrl;
                    },
                    Left: _ => { }
                );
            }
            var getAll = await GetAll();
            return getAll.Match(
                Right: games =>
                {
                    if(game.Id == null || game.Id == "")
                    {
                        game.Id = ShortcutRepository.GenerateAppID(game.ExecutablePath, game.Name).ToString();
                    }
                    games.Add(game);
                    SaveToFile(games);
                    return Prelude.Right<ErrorBase, GameModel>(game);
                },
                Left: Prelude.Left<ErrorBase, GameModel>
            );
        }

        public async Task<Either<ErrorBase, List<GameModel>>> FindByName(string name)
        {
            var getAll = await GetAll();
            return getAll.Match(
                Right: games =>
                {
                    var filteredGames = games.Where(g => g.Name.Contains(name, StringComparison.OrdinalIgnoreCase)).ToList();
                    return Prelude.Right<ErrorBase, List<GameModel>>(filteredGames);
                },
                Left: Prelude.Left<ErrorBase, List<GameModel>>
            );
        }

        public Task<Either<ErrorBase, List<GameModel>>> GetAll()
        {
            var games = LoadFromFile();
            return Task.FromResult(Prelude.Right<ErrorBase, List<GameModel>>(games));
        }

        public async Task<Either<ErrorBase, GameModel>> GetById(string id)
        {
            var getAll = await GetAll();
            return getAll.Match(
                Right: games =>
                {
                    var game = games.FirstOrDefault(g => g.Id == id.ToString());
                    if (game != null)
                    {
                        return Prelude.Right<ErrorBase, GameModel>(game);
                    }
                    else
                    {
                        return Prelude.Left<ErrorBase, GameModel>(new ErrorNotFound());
                    }
                },
                Left: Prelude.Left<ErrorBase, GameModel>
            );
        }

        public async Task<Either<ErrorBase, GameModel>> Update(GameModel game)
        {
            var getAll = await GetAll();
            return getAll.Match(
                Right: games =>
                {
                    var index = games.FindIndex(g => g.Id == game.Id);
                    if (index != -1)
                    {
                        games[index] = game;
                        SaveToFile(games);
                        return Prelude.Right<ErrorBase, GameModel>(game);
                    }
                    else
                    {
                        return Prelude.Left<ErrorBase, GameModel>(new ErrorNotFound());
                    }
                },
                Left: Prelude.Left<ErrorBase, GameModel>
            );
        }

        public async Task<Either<ErrorBase, Unit>> Delete(string id)
        {
            var getAll = await GetAll();
            return getAll.Match(
                Right: games =>
                {
                    var gameToRemove = games.FirstOrDefault(g => g.Id == id);
                    if (gameToRemove != null)
                    {
                        games.Remove(gameToRemove);
                        SaveToFile(games);
                        return Prelude.Right<ErrorBase, Unit>(Unit.Default);
                    }
                    else
                    {
                        return Prelude.Left<ErrorBase, Unit>(new ErrorNotFound());
                    }
                },
                Left: Prelude.Left<ErrorBase, Unit>
            );
        }

        private void SaveToFile(List<GameModel> games)
        {
            var json = System.Text.Json.JsonSerializer.Serialize(games);
            File.WriteAllText(fileName, json);
        }

        private List<GameModel> LoadFromFile()
        {
            if (!File.Exists(fileName))
            {
                return new List<GameModel>();
            }
            var json = File.ReadAllText(fileName);
            return System.Text.Json.JsonSerializer.Deserialize<List<GameModel>>(json) ?? new List<GameModel>();
        }
    }
}
