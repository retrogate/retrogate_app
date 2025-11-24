# Navegação com Gamepad/Joystick

## 🎮 Suporte a Controles

O RetroGate.UI agora suporta navegação completa usando gamepad/joystick, proporcionando uma experiência similar ao Steam Big Picture!

## 📦 Dependência

```yaml
dependencies:
  gamepads: ^0.1.9  # Suporte para gamepads
```

## 🕹️ Controles Suportados

### D-Pad
- **↑ Cima**: Move seleção para cima (uma linha)
- **↓ Baixo**: Move seleção para baixo (uma linha)
- **← Esquerda**: Move seleção para esquerda
- **→ Direita**: Move seleção para direita

### Botões
- **A / Cross (✕)**: Seleciona/Abre o jogo
- **B / Circle (○)**: Voltar (futuro)
- **Start**: Menu (futuro)

## ⌨️ Atalhos de Teclado (Fallback)

Para testar sem um gamepad conectado:
- **Setas direcionais**: Navegação
- **Enter / Espaço**: Selecionar

## 🎯 Funcionalidades

### Navegação em Grid
O sistema calcula automaticamente a navegação baseado no número de colunas:
- Setas esquerda/direita: Move 1 item
- Setas cima/baixo: Move `crossAxisCount` itens (1 linha)

### Debounce
- Delay de 150ms entre inputs para navegação suave e responsiva
- Reset automático ao soltar o D-Pad para resposta instantânea

### Visual Feedback
- Item selecionado recebe destaque visual (borda azul + ícone de gamepad)
- Auto-scroll para manter item selecionado visível (futuro)

## ⚠️ Nota sobre Analógico

O suporte para navegação com analógico esquerdo foi removido temporariamente por questões de responsividade. Atualmente apenas o **D-Pad** está implementado para garantir uma navegação precisa e fluida.

## 🔧 Implementação Técnica

### GamepadNavigationWrapper

Widget que envolve o grid e gerencia a navegação:

```dart
GamepadNavigationWrapper(
  itemCount: games.length,
  crossAxisCount: crossAxisCount,
  onItemSelected: (index) {
    // Ação quando item é selecionado
    final game = games[index];
    // Navegar para detalhes, iniciar jogo, etc.
  },
  child: GridView.builder(...),
)
```

### Eventos do Gamepad

O wrapper escuta eventos do gamepad em tempo real:

```dart
Gamepads.events.listen((event) {
  if (event.type == KeyType.button) {
    // Botões digitais (D-pad, A, B, etc.)
  } else if (event.type == KeyType.analog) {
    // Analógicos (sticks)
  }
});
```

### Mapeamento de Botões

| Gamepad | Key | Ação |
|---------|-----|------|
| D-Pad Up | `pov=0` | Navegar para cima |
| D-Pad Down | `pov=18000` | Navegar para baixo |
| D-Pad Left | `pov=27000` | Navegar para esquerda |
| D-Pad Right | `pov=9000` | Navegar para direita |
| Button A (Xbox) / Cross (PS) | `button_a` / `button_cross` | Selecionar |

**Nota**: O POV (Point of View) usa valores em graus × 100. Valor 65535 indica posição neutra.

## 🚀 Uso

### 1. Conectar Gamepad

Conecte um gamepad USB ou Bluetooth ao seu dispositivo antes de iniciar o app.

### 2. Navegação Automática

O gamepad é detectado automaticamente. Basta usar os controles para navegar.

### 3. Teclado como Fallback

Se não houver gamepad, use as setas do teclado e Enter/Espaço.

## 🐛 Troubleshooting

### Gamepad não detectado

1. Verifique se o gamepad está conectado
2. Em Windows, abra "Configurações > Dispositivos > Bluetooth e outros dispositivos"
3. Teste o gamepad em "joy.cpl" (Controladores de Jogo)
4. Reinicie o aplicativo

### Navegação muito rápida/lenta

Ajuste o `_dpadDelay` em `GamepadNavigationWrapper`:

```dart
static const _dpadDelay = Duration(milliseconds: 150); // Ajuste aqui (100-250ms)
```

### D-Pad não responde

1. Verifique se o gamepad está conectado antes de iniciar o app
2. Reinicie o app após conectar o gamepad
3. Teste o D-Pad em `joy.cpl` (Windows)
4. Verifique se o D-Pad envia eventos `pov` no console

## 🎨 Visual Feedback

### Item Selecionado

O item atualmente selecionado pelo gamepad pode receber um indicador visual:

```dart
// Em _GameCard
final selectedIndex = _GamepadSelectionProvider.of(context);
final isSelected = selectedIndex == /* card index */;

Container(
  decoration: BoxDecoration(
    border: isSelected 
      ? Border.all(color: Color(0xFF66C0F4), width: 3)
      : null,
  ),
)
```

## 📱 Plataformas Suportadas

- ✅ Windows
- ✅ Linux
- ✅ macOS
- ✅ Android (com gamepad Bluetooth)
- ⚠️ iOS (limitado)
- ⚠️ Web (suporte limitado do navegador)

## 🔮 Melhorias Futuras

- [ ] Auto-scroll para manter item selecionado visível
- [ ] Vibração do controle ao selecionar
- [ ] Configuração de botões personalizados
- [ ] Suporte para múltiplos gamepads
- [ ] Indicador visual de gamepad conectado
- [ ] Navegação por abas/seções
- [ ] Atalhos rápidos (LB/RB para pular páginas)
- [ ] **Navegação com analógico esquerdo** (implementação mais responsiva)

## 📚 Referências

- [Package gamepads](https://pub.dev/packages/gamepads)
- [Flutter Input Handling](https://docs.flutter.dev/development/ui/advanced/gestures)
