# GameImagesRepository - Documentação

## Visão Geral

O `GameImagesRepository` é uma implementação da interface `IGameImagesRepository` que utiliza a biblioteca **SteamGridDBNet** para buscar imagens de jogos (Hero, Poster e Logo) do banco de dados [SteamGridDB](https://www.steamgriddb.com/).

## Localização

```
RetroGate.SDK/
  └── Game/
      ├── Domain/
      │   ├── Models/
      │   │   └── GameImagesModel.cs
      │   └── Repository/
      │       └── IGameImagesRepository.cs
      └── Infra/
          └── Repository/
              └── GameImagesRepository.cs  ← Implementação
```

## Biblioteca Utilizada

- **craftersmine.SteamGridDBNet** - Cliente .NET para API do SteamGridDB
- GitHub: https://github.com/craftersmine/SteamGridDB.NET
- NuGet: `craftersmine.SteamGridDBNet`

## Funcionalidade

### GetGameImages(string gameName)

Busca imagens para um jogo pelo nome usando a API do SteamGridDB.

**Parâmetros:**
- `gameName`: Nome do jogo a ser pesquisado

**Retorno:**
- `Either<ErrorBase, GameImagesModel>`: 
  - `Right`: Objeto `GameImagesModel` com as URLs das imagens
  - `Left`: `ErrorNotFound` se o jogo não for encontrado ou nenhuma imagem disponível
  - `Left`: `ErrorBase` em caso de erro geral

## Modelos

### GameImagesModel

```csharp
public class GameImagesModel
{
    public string HeroUrl { get; set; } = string.Empty;     // Imagem horizontal grande
    public string PosterUrl { get; set; } = string.Empty;   // Imagem vertical (grid)
    public string LogoUrl { get; set; } = string.Empty;     // Logo do jogo
}
```

## API Key Necessária

O SteamGridDB requer uma API key para funcionar. Você pode obter uma em:
https://www.steamgriddb.com/profile/preferences/api

### Exemplo de Configuração

```csharp
var apiKey = "YOUR_STEAMGRIDDB_API_KEY";
var repository = new GameImagesRepository(apiKey);
```

## Implementação

### Construtor

```csharp
public GameImagesRepository(string apiKey)
{
    if (string.IsNullOrEmpty(apiKey))
    {
        throw new ArgumentException("SteamGridDB API key is required", nameof(apiKey));
    }

    _steamGridDb = new SteamGridDb(apiKey);
}
```

### Fluxo de Busca

1. **Busca o jogo** usando `SearchForGamesAsync(gameName)`
   - Retorna array de resultados
   - Pega o primeiro resultado (mais relevante)

2. **Busca Hero Image** usando `GetHeroesByGameIdAsync(gameId)`
   - Filtro: `types: SteamGridDbTypes.Static` (apenas imagens estáticas)
   - Dimensões típicas: 1920x620px, 3840x1240px, 1600x650px
   - Pega a primeira imagem encontrada

3. **Busca Grid/Poster Image** usando `GetGridsByGameIdAsync(gameId)`
   - Filtro: `types: SteamGridDbTypes.Static` (apenas imagens estáticas)
   - Dimensões típicas: 600x900px (vertical)
   - Pega a primeira imagem encontrada

4. **Busca Logo** usando `GetLogosByGameIdAsync(gameId)`
   - Filtro: `types: SteamGridDbTypes.Static` (apenas imagens estáticas)
   - Formato: PNG transparente
   - Pega a primeira imagem encontrada

### Tratamento de Erros

A implementação é **resiliente a falhas**:

- ✅ Cada tipo de imagem é buscado independentemente
- ✅ Se uma busca falha, as outras continuam
- ✅ Logs detalhados para debugging
- ✅ Retorna erro apenas se NENHUMA imagem for encontrada

## Exemplo de Uso

### Uso Básico

```csharp
var apiKey = "your-api-key-here";
var repository = new GameImagesRepository(apiKey);

var result = repository.GetGameImages("The Witcher 3");

result.Match(
    Right: images => 
    {
        Console.WriteLine($"Hero: {images.HeroUrl}");
        Console.WriteLine($"Poster: {images.PosterUrl}");
        Console.WriteLine($"Logo: {images.LogoUrl}");
    },
    Left: error => 
    {
        Console.WriteLine($"Erro: {error.Message}");
    }
);
```

### Com Dependency Injection

```csharp
// Program.cs
var apiKey = configuration["SteamGridDB:ApiKey"];
builder.Services.AddSingleton<IGameImagesRepository>(
    new GameImagesRepository(apiKey)
);

// Usage
public class GameService
{
    private readonly IGameImagesRepository _imagesRepo;

    public GameService(IGameImagesRepository imagesRepo)
    {
        _imagesRepo = imagesRepo;
    }

    public void LoadGameImages(string gameName)
    {
        var result = _imagesRepo.GetGameImages(gameName);
        // ...
    }
}
```

## Exemplo de Log de Sucesso

```
[GameImagesRepository] Buscando imagens para: The Witcher 3
[GameImagesRepository] Jogo encontrado: The Witcher 3: Wild Hunt (ID: 1234)
[GameImagesRepository] Hero encontrada: https://cdn2.steamgriddb.com/hero/abc123.png
[GameImagesRepository] Poster encontrado: https://cdn2.steamgriddb.com/grid/def456.png
[GameImagesRepository] Logo encontrado: https://cdn2.steamgriddb.com/logo/ghi789.png
[GameImagesRepository] Imagens obtidas com sucesso para: The Witcher 3
```

## Exemplo de Log com Jogo Não Encontrado

```
[GameImagesRepository] Buscando imagens para: JogoInexistente123
[GameImagesRepository] Nenhum jogo encontrado para: JogoInexistente123
```

## Exemplo de Log com Imagens Parciais

```
[GameImagesRepository] Buscando imagens para: Indie Game
[GameImagesRepository] Jogo encontrado: Indie Game (ID: 5678)
[GameImagesRepository] Hero encontrada: https://cdn2.steamgriddb.com/hero/abc123.png
[GameImagesRepository] Nenhum Poster encontrado
[GameImagesRepository] Erro ao buscar Logo: The remote server returned an error: (404) Not Found.
[GameImagesRepository] Imagens obtidas com sucesso para: Indie Game
```

## Tipos de Imagem

### Hero Image (Horizontal)
- **Uso**: Imagem grande exibida no topo da página do jogo no Steam
- **Dimensões comuns**: 
  - 1920x620px
  - 3840x1240px
  - 1600x650px
- **Formato**: PNG, JPEG, WEBP
- **Propriedade**: `GameImagesModel.HeroUrl`

### Poster/Grid Image (Vertical)
- **Uso**: Imagem exibida na visualização em grid da biblioteca
- **Dimensões comuns**:
  - 600x900px
  - 342x482px
  - 660x930px
- **Formato**: PNG, JPEG, WEBP
- **Propriedade**: `GameImagesModel.PosterUrl`

### Logo Image
- **Uso**: Logo do jogo exibido sobre a hero image
- **Formato**: PNG (geralmente transparente)
- **Propriedade**: `GameImagesModel.LogoUrl`

## Filtros Aplicados

A implementação utiliza os seguintes filtros para garantir qualidade:

```csharp
types: SteamGridDbTypes.Static
```

- ✅ **Static**: Apenas imagens estáticas (PNG, JPEG)
- ❌ **Animated**: Exclui imagens animadas (APNG, WEBP animado)

Isso evita problemas de compatibilidade e garante que as imagens sejam adequadas para uso no Steam.

## Integração com Installer

O `GameImagesRepository` pode ser usado em conjunto com o `InstallerRepository` para obter automaticamente as imagens ao instalar um jogo:

```csharp
// Busca o jogo
var gameResult = await getGameById.Call(gameId);
var game = gameResult.RightAsEnumerable().First();

// Busca as imagens
var imagesResult = gameImagesRepository.GetGameImages(game.Name);

if (imagesResult.IsRight)
{
    var images = imagesResult.RightAsEnumerable().First();
    
    // Atualiza o GameModel com as URLs
    game.ImageHeroUrl = images.HeroUrl;
    game.ImagePosterUrl = images.PosterUrl;
    game.ImageLogoUrl = images.LogoUrl;
}

// Continua com a instalação...
```

## Considerações de Performance

### Chamadas Síncronas

A implementação atual usa `.Wait()` para aguardar métodos assíncronos:

```csharp
var heroesTask = _steamGridDb.GetHeroesByGameIdAsync(game.Id);
heroesTask.Wait();
var heroes = heroesTask.Result;
```

**Razão**: A interface `IGameImagesRepository` define um método síncrono `GetGameImages()`.

**Melhoria futura**: Considerar alterar a interface para assíncrona:

```csharp
public interface IGameImagesRepository
{
    Task<Either<ErrorBase, GameImagesModel>> GetGameImagesAsync(string gameName);
}
```

### Cache de Resultados

Para melhorar performance, considere implementar cache:

```csharp
private readonly Dictionary<string, GameImagesModel> _cache = new();

public Either<ErrorBase, GameImagesModel> GetGameImages(string gameName)
{
    if (_cache.TryGetValue(gameName, out var cached))
    {
        return cached;
    }

    // Busca da API...
    
    if (result.IsRight)
    {
        _cache[gameName] = images;
    }

    return result;
}
```

## Limitações

1. **Rate Limiting**: A API do SteamGridDB tem limites de taxa
   - Grátis: 500 requisições/dia
   - Considere implementar retry com backoff exponencial

2. **Disponibilidade**: Nem todos os jogos têm todas as imagens
   - A implementação trata isso graciosamente

3. **Precisão de Busca**: A busca pode retornar jogos similares
   - Sempre pega o primeiro resultado (mais relevante)

## Próximos Passos (Opcional)

1. **Versão Assíncrona**: Migrar para interface assíncrona
2. **Cache**: Implementar cache em memória ou disco
3. **Retry Logic**: Adicionar retry automático em caso de falhas temporárias
4. **Melhor Seleção**: Permitir escolher entre múltiplos resultados
5. **Validação**: Verificar se URLs retornadas são válidas antes de retornar

## Conclusão

O `GameImagesRepository` fornece uma integração completa e robusta com o SteamGridDB para obter imagens de alta qualidade para jogos. A implementação é resiliente a falhas e fornece logs detalhados para debugging! 🎮✨
