# Sistema de Navegação por Gamepad - RetroGate

## 🎮 Arquitetura

O sistema de navegação por gamepad foi refatorado para ser **genérico e reutilizável** em todo o aplicativo, permitindo uma experiência similar a consoles modernos.

## 📦 Componentes Principais

### 1. GamepadNavigationScope
**Localização**: `lib/core/widgets/gamepad_navigation_scope.dart`

Widget raiz que gerencia eventos de gamepad globalmente para toda a aplicação.

**Responsabilidades**:
- ✅ Escutar eventos de gamepad (botões e D-Pad)
- ✅ Gerenciar ações globais (Menu, Back)
- ✅ Delegar navegação direcional para o sistema de Focus do Flutter
- ✅ Detectar gamepads conectados

**Uso**:
```dart
// Envolver o MaterialApp no main.dart
GamepadNavigationScope(
  child: MaterialApp.router(...),
)
```

**Ações Globais**:
- **Start Button** → Ação customizável (ex: abrir menu)
- **B Button** → Ação customizável (ex: voltar)
- **A Button** → Ativar widget focado
- **D-Pad** → Navegar entre widgets focáveis

### 2. GamepadFocusable
**Localização**: `lib/core/widgets/gamepad_focusable.dart`

Widget que torna qualquer elemento navegável e ativável por gamepad.

**Features**:
- ✅ Borda azul quando focado (#66C0F4)
- ✅ Responde a botão A e tecla Enter
- ✅ Animação suave de foco (150ms)
- ✅ Suporte para autofocus

**Uso**:
```dart
GamepadFocusable(
  autofocus: true,
  onPressed: () {
    // Ação ao pressionar A ou Enter
  },
  child: ListTile(...),
)
```

### 3. GamepadNavigationWrapper (Grid)
**Localização**: `lib/modules/game/presentation/widgets/gamepad_navigation_wrapper.dart`

Wrapper especializado para navegação em grid de jogos.

**Features**:
- ✅ Navegação em grade (colunas x linhas)
- ✅ D-Pad para mover seleção
- ✅ Fallback de teclado (setas)
- ✅ Indicador visual de seleção

**Mantido para**:
- Grid de jogos (uso específico com índices)
- Controle preciso de scroll
- Lógica de grid personalizada

### 4. GamepadStatusIndicator
**Localização**: `lib/core/widgets/gamepad_navigation_scope.dart`

Indicador visual que mostra gamepads conectados.

**Uso**:
```dart
Positioned(
  top: 16,
  left: 16,
  child: GamepadStatusIndicator(),
)
```

## 🎯 Mapeamento de Botões

### Xbox Controller
| Botão        | Ação                           | Código              |
|--------------|--------------------------------|---------------------|
| **Start**    | Abrir menu / Ação customizada | `button_start`, `6` |
| **B**        | Voltar / Ação customizada     | `button_b`, `1`     |
| **A**        | Selecionar / Ativar           | `button_a`, `0`     |
| **D-Pad ↑**  | Navegar para cima            | POV 0°              |
| **D-Pad →**  | Navegar para direita         | POV 90°             |
| **D-Pad ↓**  | Navegar para baixo           | POV 180°            |
| **D-Pad ←**  | Navegar para esquerda        | POV 270°            |

### POV (Point of View) Mapping
```dart
if (event.key == 'pov') {
  0° - 44°    → Up
  45° - 134°  → Right
  135° - 224° → Down
  225° - 314° → Left
  65535       → Neutral
}
```

## 🔄 Fluxo de Navegação

### 1. Navegação no Drawer
```
[Start Button] → Abre Drawer
[D-Pad ↑/↓]   → Navega entre itens (GamepadFocusable)
[A Button]    → Seleciona item
[B Button]    → Fecha drawer / volta
```

### 2. Navegação no Grid de Jogos
```
[D-Pad ↑/↓/←/→] → Move seleção na grade
[A Button]      → Seleciona jogo
[Start Button]  → Abre menu
```

### 3. Navegação em Formulários
```
[D-Pad ↑/↓]     → Navega entre campos
[A Button]      → Foca campo / confirma
[B Button]      → Volta para tela anterior
```

## 💡 Como Adicionar Navegação em Nova Tela

### Passo 1: Registrar Ações Globais (Opcional)
```dart
class MyPage extends StatefulWidget {
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool _hasRegisteredActions = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // Register actions only once
    if (!_hasRegisteredActions) {
      // Ação para botão Start
      GamepadNavigationScope.registerMenuAction(context, () {
        // Abrir menu, etc
      });
      
      // Ação para botão B
      GamepadNavigationScope.registerBackAction(context, () {
        Navigator.pop(context);
      });
      
      _hasRegisteredActions = true;
    }
  }
  
  // Não precisa unregister no dispose - é feito automaticamente
  // quando a página sai da árvore
}
```

### Passo 2: Tornar Widgets Navegáveis
```dart
// Botão simples
GamepadFocusable(
  autofocus: true,
  onPressed: () => _handleAction(),
  child: ElevatedButton(...),
)

// Item de lista
GamepadFocusable(
  onPressed: () => _selectItem(),
  child: ListTile(...),
)

// Card customizado
GamepadFocusable(
  onPressed: () => _openDetails(),
  child: Card(...),
)
```

## 🎨 Personalização Visual

### Cor de Foco Padrão
```dart
Border.all(
  color: Color(0xFF66C0F4), // Steam blue
  width: 3,
)
```

### Customizar Borda de Foco
```dart
GamepadFocusable(
  child: Container(
    decoration: BoxDecoration(
      // Sua decoração personalizada
    ),
    child: YourWidget(),
  ),
)
```

## 🔧 Debounce

**Removido**: O debounce foi removido para navegação instantânea e responsiva.

Se necessário reintroduzir:
```dart
DateTime _lastInputTime = DateTime.now();
static const _delay = Duration(milliseconds: 100);

if (now.difference(_lastInputTime) < _delay) return;
_lastInputTime = now;
```

## ✅ Vantagens do Novo Sistema

### Antes (Wrapper Específico)
- ❌ Apenas para grid de jogos
- ❌ Código duplicado para cada tela
- ❌ Difícil adicionar novas navegações
- ❌ Sem padronização

### Depois (Sistema Genérico)
- ✅ Reutilizável em qualquer tela
- ✅ Navegação automática via Focus do Flutter
- ✅ Fácil adicionar novos elementos navegáveis
- ✅ Ações globais (menu, voltar)
- ✅ Experiência consistente de console

## 📱 Telas Implementadas

### ✅ Games Library
- Grid de jogos navegável
- Drawer com navegação
- Botão Start abre menu
- D-Pad navega pelos jogos

### ✅ Settings
- Formulário navegável
- Botão B volta para games
- D-Pad navega entre campos
- A para focar/confirmar

## 🚀 Próximos Passos

1. **Auto-scroll no grid**: Manter item selecionado visível
2. **Navegação em tabs**: Adicionar suporte para abas
3. **Deadzone para analógico**: Se reintroduzir analógico
4. **Vibração de feedback**: Haptic feedback em ações
5. **Tutorial in-game**: Mostrar controles na primeira execução

## 🎮 Experiência de Console

O objetivo é criar uma interface que funcione 100% com gamepad, sem necessidade de mouse/teclado:

```
🎮 Ligar app → Usar apenas gamepad
✅ Navegar biblioteca
✅ Abrir menu
✅ Ajustar configurações
✅ Selecionar e executar jogos
✅ Voltar/fechar
```

**RetroGate**: A experiência de console moderna para seus jogos retro! 🚀
