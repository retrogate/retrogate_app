using System.Collections.Concurrent;

namespace RetroGate.Grpc.Common
{
    public class Subscriber<T>
    {
        public ConcurrentQueue<T> Queue { get; } = new();
        public AsyncAutoResetEvent DataAvailable { get; } = new();
    }
}