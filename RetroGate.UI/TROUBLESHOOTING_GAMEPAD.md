# Troubleshooting - Gamepad Xbox One

## 🎮 Problema: Gamepad não funciona no Flutter

### Sintomas
- ✅ Teclado funciona normalmente (setas + Enter)
- ❌ Joystick Xbox One não responde no app
- ✅ Joystick funciona em outras aplicações Windows

### Possíveis Causas e Soluções

#### 1. O App Não Está Recebendo Eventos do Gamepad

**Diagnóstico**: Verificar os logs do console

Procure por estas mensagens ao iniciar o app:
```
🎮 Checking for connected gamepads...
🎮 Connected gamepads: 1
  ✅ Xbox Controller (ID: ...)
```

Se aparecer:
```
🎮 Connected gamepads: 0
⚠️  No gamepads detected!
```

**Solução**: 
1. Conecte o gamepad ANTES de iniciar o app
2. Reinicie o app após conectar o gamepad
3. Verifique se o gamepad está pareado corretamente

#### 2. Eventos Chegam Mas Não São Reconhecidos

**Diagnóstico**: Aperte botões no gamepad e veja os logs

Você deve ver mensagens como:
```
🎮 Gamepad Event: type=button, key=button_a, value=1.0
🔘 Button: button_a = 1.0
```

Se aparecer `key` diferente (ex: `key=0`, `key=304`), os mapeamentos estão incorretos.

**Solução**: Adicione os novos mapeamentos no código

#### 3. Windows Gamepad API

O pacote `gamepads` usa a Windows Gaming Input API. Algumas versões do Windows podem ter problemas.

**Verificações**:

1. **Abrir Configurações de Controle do Windows**:
   - Pressione `Win + R`
   - Digite `joy.cpl`
   - Enter
   - Verifique se o Xbox Controller aparece
   - Clique em "Propriedades" e teste todos os botões

2. **Atualizar Driver**:
   - Configurações > Dispositivos Bluetooth e outros dispositivos
   - Encontre o Xbox Controller
   - Clique em "Remover dispositivo"
   - Reconecte o controle

3. **Testar em Outro App**:
   - Abra um jogo Steam
   - Ou use https://gamepad-tester.com/

#### 4. Dependências do Flutter

**Solução**: Reinstalar o pacote gamepads

```bash
flutter clean
flutter pub get
flutter run -d windows
```

#### 5. Hot Reload Pode Não Funcionar

O `Gamepads.events` stream pode não reinicializar com hot reload.

**Solução**: Use Hot Restart (não Hot Reload)
- Pressione `Shift + R` no terminal do Flutter
- Ou feche e reabra o app

### 🔍 Debug Mode

Os logs atuais mostram:

1. **Ao Iniciar**:
```
🎮 Checking for connected gamepads...
🎮 Connected gamepads: X
  ✅ Nome do Gamepad (ID: ...)
```

2. **Ao Pressionar Botão/Analógico**:
```
🎮 Gamepad Event: type=button/analog, key=X, value=X.X, gamepadId=...
🔘 Button: X = X.X
  ou
🕹️  Analog: X = X.X
```

3. **Ao Navegar**:
```
⬆️  D-Pad Up
⬇️  D-Pad Down
⬅️  D-Pad Left
➡️  D-Pad Right
```

4. **Ao Pressionar Teclado**:
```
⌨️  Keyboard: LogicalKeyboardKey#XXXXX
```

### 📋 Checklist de Testes

Execute estes testes e anote os resultados:

- [ ] Gamepad aparece no `joy.cpl`?
- [ ] Gamepad funciona no gamepad-tester.com?
- [ ] App mostra "Connected gamepads: 1" ou mais?
- [ ] Ao apertar qualquer botão, aparece "🎮 Gamepad Event" no console?
- [ ] D-Pad gera eventos?
- [ ] Analógico esquerdo gera eventos?
- [ ] Botão A gera eventos?
- [ ] Teclado funciona no app?

### 🛠️ Mapeamento Manual

Se o gamepad envia eventos mas com keys diferentes, podemos mapear manualmente.

**Exemplo de log**:
```
🎮 Gamepad Event: type=button, key=304, value=1.0
```

Neste caso, `304` seria o botão A no seu gamepad.

**Solução**: Atualize o código:

```dart
case 'button_a':
case '304': // Seu mapeamento customizado
  _selectCurrentItem();
  break;
```

### 📱 Contato

Se nenhuma solução funcionar, forneça:

1. **Versão do Windows**: (Win + R → `winver`)
2. **Modelo do Gamepad**: Xbox One S / X / Elite, etc.
3. **Conexão**: USB ou Bluetooth?
4. **Logs do Console**: Copie TODAS as mensagens que aparecem ao:
   - Iniciar o app
   - Apertar D-Pad (todas as direções)
   - Apertar botão A
   - Mover analógico esquerdo (todas as direções)

### 🔗 Links Úteis

- [Pacote gamepads](https://pub.dev/packages/gamepads)
- [Gamepad Tester](https://gamepad-tester.com/)
- [Windows Gaming Input API](https://learn.microsoft.com/en-us/uwp/api/windows.gaming.input)
