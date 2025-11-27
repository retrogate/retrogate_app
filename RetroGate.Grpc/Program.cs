using System.Collections.Concurrent;
using RetroGate.Grpc.Common;
using RetroGate.Grpc.Services;
using RetroGate.SDK.Core.Domain.Repository;
using RetroGate.SDK.Core.Domain.Usecases;
using RetroGate.SDK.Core.Infra;
using RetroGate.SDK.Core.Infra.Usecases;
using RetroGate.SDK.Game.Domain.Repository;
using RetroGate.SDK.Game.Domain.Usecases;
using RetroGate.SDK.Game.Infra.Repository;
using RetroGate.SDK.Game.Infra.Usecases;
using RetroGate.SDK.Installer.Domain.Models;
using RetroGate.SDK.Installer.Domain.Repository;
using RetroGate.SDK.Installer.Domain.Usecases;
using RetroGate.SDK.Installer.Infra.Repository;
using RetroGate.SDK.Installer.Infra.Usecases;
using RetroGate.SDK.Shortcut.Domain.Repository;
using RetroGate.SDK.Shortcut.Domain.Usecases;
using RetroGate.SDK.Shortcut.Infra.Repository;
using RetroGate.SDK.Shortcut.Infra.Usecases;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddGrpc();
builder.Services.AddGrpcReflection();

var configRepository = new ConfigRepository();
var config = configRepository.GetConfig().Result.Match(
    Right: cfg => cfg,
    Left: _ => new RetroGate.SDK.Core.Domain.Models.ConfigModel()
);
builder.Services.AddSingleton(config);

var installerEventsSubscribers = new ConcurrentDictionary<string, Subscriber<InstallerEventModel>>();
builder.Services.AddSingleton(installerEventsSubscribers);

// Config service instances
builder.Services.AddSingleton<IConfigRepository, ConfigRepository>();
builder.Services.AddSingleton<IGetConfig, GetConfig>();
builder.Services.AddSingleton<ISetConfig, SetConfig>();

// Steam shortcut instances
builder.Services.AddSingleton<IShortcutRepository, ShortcutRepository>();
builder.Services.AddSingleton<IGetAllShortcuts, GetAllShortcuts>();
builder.Services.AddSingleton<ICreateShortcut, CreateShortcut>();
builder.Services.AddSingleton<IDeleteShortcut, DeleteShortcut>();

// Game service instances
builder.Services.AddSingleton<IAvailableGamesRepository, AvailableGamesRepository>();
builder.Services.AddSingleton<IInstalledGamesRepository, InstalledGamesRepository>();
builder.Services.AddSingleton<IGameImagesRepository, GameImagesRepository>();
builder.Services.AddSingleton<ICreateGame, CreateGame>();
builder.Services.AddSingleton<IFindGameByName, FindGameByName>();
builder.Services.AddSingleton<IGetAllGames, GetAllGames>();
builder.Services.AddSingleton<IGetGameById, GetGameById>();
builder.Services.AddSingleton<IUpdateGame, UpdateGame>();
builder.Services.AddSingleton<IFindInstalledGames, FindInstalledGames>();
builder.Services.AddSingleton<ILaunchGame, LaunchGame>();
builder.Services.AddSingleton<IDeleteGame, DeleteGame>();
builder.Services.AddSingleton<IGetGameImages, GetGameImages>();

// Installer service instances
builder.Services.AddSingleton<IInstallerRepository, InstallerRepository>();
builder.Services.AddSingleton<IInstallGame, InstallGame>();
builder.Services.AddSingleton<IUninstallGame, UninstallGame>();
builder.Services.AddSingleton<ICancelInstallation, CancelInstallation>();

var app = builder.Build();

// Configure the HTTP request pipeline.
app.MapGrpcService<ConfigService>();
app.MapGrpcService<ShortcutService>();
app.MapGrpcService<GameService>();
app.MapGrpcService<InstallerService>();

if (app.Environment.IsDevelopment())
{
    app.MapGrpcReflectionService();
}

app.MapGet("/", () => "Communication with gRPC endpoints must be made through a gRPC client. To learn how to create a client, visit: https://go.microsoft.com/fwlink/?linkid=2086909");

app.Run();

internal interface IAddGameImage
{
}