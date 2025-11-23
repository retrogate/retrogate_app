using System.Threading.Tasks;

namespace RetroGate.CLI
{
    public interface ICLIModule
    {
        bool CanHandle(string[] args);
        Task Run(string[] args);
    }
}