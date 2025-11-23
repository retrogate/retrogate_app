using RetroGate.CLI;
using RetroGate.SDK.Core.Infra;
using RetroGate.SDK.Core.Infra.Usecases;

var configRepository = new ConfigRepository();
var getConfig = new GetConfig(configRepository);
var configResult = await getConfig.Call();
var config = configResult.Match(
    Right: cfg => cfg,
    Left: err =>
    {
        Console.WriteLine($"Erro ao carregar configuração: {err.Message}");
        Environment.Exit(1);
        return null; // Nunca alcançado
    }
);

var modules = new List<ICLIModule>
{
    new Shortcuts(config),
    new Installer()
};

// Tenta processar com cada módulo
foreach (var module in modules)
{
    if (module.CanHandle(args))
    {
        await module.Run(args);
        return;
    }
}

// Se nenhum módulo processou, mostra ajuda geral
ShowGeneralHelp();

static void ShowGeneralHelp()
{
    Console.WriteLine("RetroGate CLI");
    Console.WriteLine();
    Console.WriteLine("Available modules:");
    Console.WriteLine("  shortcuts    Manage Steam shortcuts");
    Console.WriteLine("  install      Install and manage games");
    Console.WriteLine();
    Console.WriteLine("Usage:");
    Console.WriteLine("  RetroGate.CLI <module> <command> [options]");
    Console.WriteLine();
    Console.WriteLine("Examples:");
    Console.WriteLine("  RetroGate.CLI shortcuts list shortcuts.vdf");
    Console.WriteLine("  RetroGate.CLI install game game123");
    Console.WriteLine("  RetroGate.CLI shortcuts help");
    Console.WriteLine("  RetroGate.CLI install help");
}
