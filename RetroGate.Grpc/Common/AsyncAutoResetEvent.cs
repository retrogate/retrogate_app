namespace RetroGate.Grpc.Common
{
    public class AsyncAutoResetEvent
    {
        private TaskCompletionSource _tcs = new(TaskCreationOptions.RunContinuationsAsynchronously);

        public Task WaitAsync(CancellationToken cancellationToken = default)
        {
            return cancellationToken.CanBeCanceled
                ? Task.WhenAny(_tcs.Task, Task.Delay(Timeout.Infinite, cancellationToken))
                : _tcs.Task;
        }

        public void Set()
        {
            var tcs = _tcs;
            _tcs = new TaskCompletionSource(TaskCreationOptions.RunContinuationsAsynchronously);
            tcs.SetResult();
        }
    }
}