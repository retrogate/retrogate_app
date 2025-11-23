using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Models;
using RetroGate.SDK.Game.Domain.Repository;
using craftersmine.SteamGridDBNet;
using RetroGate.SDK.Core.Domain.Models;

namespace RetroGate.SDK.Game.Infra.Repository
{
    public class GameImagesRepository : IGameImagesRepository
    {
        private readonly SteamGridDb _steamGridDb;

        public GameImagesRepository(ConfigModel config)
        {
            if (string.IsNullOrEmpty(config.SteamGridDbApiKey))
            {
                throw new ArgumentException("SteamGridDB API key is required", nameof(config.SteamGridDbApiKey));
            }

            _steamGridDb = new SteamGridDb(config.SteamGridDbApiKey);
        }

        public async Task<Either<ErrorBase, GameImagesModel>> GetGameImages(string gameName)
        {
            try
            {
                Console.WriteLine($"[GameImagesRepository] Buscando imagens para: {gameName}");

                // Busca o jogo no SteamGridDB (método assíncrono)
                var searchTask = _steamGridDb.SearchForGamesAsync(gameName);
                searchTask.Wait();
                var searchResults = searchTask.Result;

                if (searchResults == null || searchResults.Length == 0)
                {
                    Console.WriteLine($"[GameImagesRepository] Nenhum jogo encontrado para: {gameName}");
                    return new ErrorNotFound { Message = $"Jogo '{gameName}' não encontrado no SteamGridDB" };
                }

                // Pega o primeiro resultado (mais relevante)
                var game = searchResults[0];
                Console.WriteLine($"[GameImagesRepository] Jogo encontrado: {game.Name} (ID: {game.Id})");

                var imagesModel = new GameImagesModel();

                // Busca Hero (imagem horizontal grande)
                try
                {
                    var heroesTask = _steamGridDb.GetHeroesByGameIdAsync(
                        game.Id,
                        types: SteamGridDbTypes.Static);  // Apenas imagens estáticas
                    var heroes = await heroesTask;

                    if (heroes != null && heroes.Length > 0)
                    {
                        imagesModel.HeroUrl = heroes[0].FullImageUrl;
                        Console.WriteLine($"[GameImagesRepository] Hero encontrada: {imagesModel.HeroUrl}");
                    }
                    else
                    {
                        Console.WriteLine($"[GameImagesRepository] Nenhuma Hero encontrada");
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"[GameImagesRepository] Erro ao buscar Hero: {ex.Message}");
                }

                // Busca Grid (imagem vertical - poster)
                try
                {
                    var gridsTask = _steamGridDb.GetGridsByGameIdAsync(
                        game.Id,
                        types: SteamGridDbTypes.Static);  // Apenas imagens estáticas
                    gridsTask.Wait();
                    var grids = gridsTask.Result;

                    if (grids != null && grids.Length > 0)
                    {
                        imagesModel.PosterUrl = grids[0].FullImageUrl;
                        Console.WriteLine($"[GameImagesRepository] Poster encontrado: {imagesModel.PosterUrl}");
                    }
                    else
                    {
                        Console.WriteLine($"[GameImagesRepository] Nenhum Poster encontrado");
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"[GameImagesRepository] Erro ao buscar Poster: {ex.Message}");
                }

                // Busca Logo
                try
                {
                    var logosTask = _steamGridDb.GetLogosByGameIdAsync(
                        game.Id,
                        types: SteamGridDbTypes.Static);  // Apenas imagens estáticas
                    logosTask.Wait();
                    var logos = logosTask.Result;

                    if (logos != null && logos.Length > 0)
                    {
                        imagesModel.LogoUrl = logos[0].FullImageUrl;
                        Console.WriteLine($"[GameImagesRepository] Logo encontrado: {imagesModel.LogoUrl}");
                    }
                    else
                    {
                        Console.WriteLine($"[GameImagesRepository] Nenhum Logo encontrado");
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"[GameImagesRepository] Erro ao buscar Logo: {ex.Message}");
                }

                // Verifica se ao menos uma imagem foi encontrada
                if (string.IsNullOrEmpty(imagesModel.HeroUrl) && 
                    string.IsNullOrEmpty(imagesModel.PosterUrl) && 
                    string.IsNullOrEmpty(imagesModel.LogoUrl))
                {
                    Console.WriteLine($"[GameImagesRepository] Nenhuma imagem disponível para: {gameName}");
                    return new ErrorNotFound { Message = $"Nenhuma imagem disponível para '{gameName}'" };
                }

                Console.WriteLine($"[GameImagesRepository] Imagens obtidas com sucesso para: {gameName}");
                return imagesModel;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"[GameImagesRepository] Erro ao buscar imagens: {ex.Message}");
                return new ErrorBase { Message = $"Erro ao buscar imagens: {ex.Message}" };
            }
        }
    }
}