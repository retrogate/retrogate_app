using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RetroGate.SDK.Core.Errors
{
    public class ErrorException : ErrorBase
    {
        public ErrorException(Exception exception)
        {
            Message = $"An exception occurred: {exception.Message}";
        }
    }
}
