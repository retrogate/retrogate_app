using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RetroGate.SDK.Game.Domain.Usecases
{
    public interface IUpdateGame
    {
        Task<Either<ErrorBase, GameModel>> Call(GameModel game);
    }
}
