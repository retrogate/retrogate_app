namespace RetroGate.SDK.Core.Errors
{
    public class ErrorBase
    {
        public string Message { get; set; } = string.Empty;
        public ErrorBase(string message = "")
        {
            Message = message;
        }
    }
}
