namespace RetroGate.SDK.Core.Errors
{
    public class ErrorAlreadyExists : ErrorBase
    {
        public ErrorAlreadyExists()
        {
            Message = "The resource already exists.";
        }
    }
}
