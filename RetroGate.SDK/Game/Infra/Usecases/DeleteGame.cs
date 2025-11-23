using LanguageExt;
using RetroGate.SDK.Core.Errors;
using RetroGate.SDK.Game.Domain.Repository;
using RetroGate.SDK.Game.Domain.Usecases;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RetroGate.SDK.Game.Infra.Usecases
{
    public class DeleteGame(IGameRepository gameRepository) : IDeleteGame
    {
        public async Task<Either<ErrorBase, Unit>> Call(string id)
        {
            return await gameRepository.Delete(id);
        }
    }
}
