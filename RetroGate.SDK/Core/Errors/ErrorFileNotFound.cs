using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RetroGate.SDK.Core.Errors
{
    public class ErrorFileNotFound : ErrorBase
    {
        public ErrorFileNotFound()
        {
            Message = "The specified file was not found or is empry.";
        }
    }
}
