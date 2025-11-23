namespace RetroGate.SDK.Core.Errors
{
    public class ErrorNotFound : ErrorBase
    {
        public ErrorNotFound()
        {
            Message = "The requested resource was not found.";
        }
    }
}
