using LanguageExt;
using RetroGate.SDK.Core.Errors;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RetroGate.SDK.Game.Domain.Usecases
{
    public interface IDeleteGame
    {
        Task<Either<ErrorBase, Unit>> Call(string id);
    }
}
