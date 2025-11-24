# Gerenciamento de Estado com BLoC

## Visão Geral

O projeto foi refatorado para usar o padrão **BLoC (Business Logic Component)** para gerenciar estados da aplicação, separando a lógica de negócio da camada de apresentação.

## Estrutura do BLoC

```
lib/modules/game/presentation/bloc/
├── bloc.dart                 # Arquivo barrel para exports
├── games_bloc.dart          # BLoC principal
├── games_event.dart         # Eventos do BLoC
└── games_state.dart         # Estados do BLoC
```

## Eventos (Events)

Eventos são ações que o usuário ou sistema dispara:

```dart
abstract class GamesEvent extends Equatable {
  const GamesEvent();
  @override
  List<Object?> get props => [];
}

// Carregar jogos pela primeira vez
class LoadGamesEvent extends GamesEvent {
  const LoadGamesEvent();
}

// Recarregar/atualizar lista de jogos
class RefreshGamesEvent extends GamesEvent {
  const RefreshGamesEvent();
}
```

### Como disparar eventos:

```dart
// Na UI
BlocProvider.of<GamesBloc>(context).add(const LoadGamesEvent());

// Ou usando shorthand (cuidado com conflitos)
context.read<GamesBloc>().add(const RefreshGamesEvent());
```

## Estados (States)

Estados representam diferentes situações da aplicação:

```dart
abstract class GamesState extends Equatable {
  const GamesState();
  @override
  List<Object?> get props => [];
}

// Estado inicial
class GamesInitialState extends GamesState {
  const GamesInitialState();
}

// Carregando dados
class GamesLoadingState extends GamesState {
  const GamesLoadingState();
}

// Dados carregados com sucesso
class GamesLoadedState extends GamesState {
  final List<Game> games;
  const GamesLoadedState(this.games);
  
  @override
  List<Object?> get props => [games];
}

// Nenhum jogo encontrado
class GamesEmptyState extends GamesState {
  const GamesEmptyState();
}

// Erro ao carregar
class GamesErrorState extends GamesState {
  final String message;
  const GamesErrorState(this.message);
  
  @override
  List<Object?> get props => [message];
}
```

## BLoC (Business Logic Component)

O BLoC recebe eventos e emite estados:

```dart
class GamesBloc extends Bloc<GamesEvent, GamesState> {
  final GetAllGamesUseCase getAllGamesUseCase;

  GamesBloc({required this.getAllGamesUseCase}) 
    : super(const GamesInitialState()) {
    on<LoadGamesEvent>(_onLoadGames);
    on<RefreshGamesEvent>(_onRefreshGames);
  }

  Future<void> _onLoadGames(
    LoadGamesEvent event, 
    Emitter<GamesState> emit
  ) async {
    emit(const GamesLoadingState());
    await _fetchGames(emit);
  }

  Future<void> _onRefreshGames(
    RefreshGamesEvent event, 
    Emitter<GamesState> emit
  ) async {
    emit(const GamesLoadingState());
    await _fetchGames(emit);
  }

  Future<void> _fetchGames(Emitter<GamesState> emit) async {
    final result = await getAllGamesUseCase();

    result.fold(
      (error) => emit(GamesErrorState(error.toString())),
      (games) {
        if (games.isEmpty) {
          emit(const GamesEmptyState());
        } else {
          emit(GamesLoadedState(games));
        }
      },
    );
  }
}
```

## Uso na Interface (UI)

### 1. Prover o BLoC

```dart
class GamesListPage extends StatelessWidget {
  const GamesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Criar instância do BLoC e carregar dados iniciais
      create: (context) => Modular.get<GamesBloc>()
        ..add(const LoadGamesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('RetroGate - Games'),
        ),
        body: const _GamesListBody(),
        floatingActionButton: const _RefreshButton(),
      ),
    );
  }
}
```

### 2. Observar Estados com BlocBuilder

```dart
class _GamesListBody extends StatelessWidget {
  const _GamesListBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamesBloc, GamesState>(
      builder: (context, state) {
        // Estado de carregamento
        if (state is GamesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        // Estado de erro
        if (state is GamesErrorState) {
          return _buildErrorView(context, state.message);
        }

        // Estado vazio
        if (state is GamesEmptyState) {
          return const Center(child: Text('No games found'));
        }

        // Estado com dados
        if (state is GamesLoadedState) {
          return _buildGamesList(state.games);
        }

        return const SizedBox.shrink();
      },
    );
  }
}
```

### 3. Disparar Eventos

```dart
class _RefreshButton extends StatelessWidget {
  const _RefreshButton();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Disparar evento de refresh
        BlocProvider.of<GamesBloc>(context)
          .add(const RefreshGamesEvent());
      },
      tooltip: 'Refresh',
      child: const Icon(Icons.refresh),
    );
  }
}
```

## Injeção de Dependência

O BLoC é registrado no módulo usando flutter_modular:

```dart
class GameModule extends Module {
  @override
  void binds(Injector i) {
    // ... outros binds
    
    // BLoC - usa add() para criar nova instância a cada solicitação
    i.add<GamesBloc>(
      () => GamesBloc(
        getAllGamesUseCase: i.get<GetAllGamesUseCase>()
      ),
    );
  }
}
```

## Vantagens do BLoC

1. **Separação de Responsabilidades**: Lógica de negócio separada da UI
2. **Testabilidade**: Fácil de testar BLoCs isoladamente
3. **Reatividade**: UI reage automaticamente a mudanças de estado
4. **Previsibilidade**: Fluxo de dados unidirecional
5. **Debugabilidade**: Fácil rastrear eventos e estados

## Fluxo de Dados

```
┌─────────────┐
│     UI      │
└──────┬──────┘
       │ dispatch event
       ▼
┌─────────────┐
│    BLoC     │
└──────┬──────┘
       │ call use case
       ▼
┌─────────────┐
│  Use Case   │
└──────┬──────┘
       │ call repository
       ▼
┌─────────────┐
│ Repository  │
└──────┬──────┘
       │ fetch data
       ▼
┌─────────────┐
│ Data Source │
└──────┬──────┘
       │ return result
       ▼
┌─────────────┐
│    BLoC     │
└──────┬──────┘
       │ emit state
       ▼
┌─────────────┐
│     UI      │ (rebuild)
└─────────────┘
```

## BlocBuilder vs BlocListener vs BlocConsumer

### BlocBuilder
Reconstrói a UI quando o estado muda:

```dart
BlocBuilder<GamesBloc, GamesState>(
  builder: (context, state) {
    return YourWidget();
  },
)
```

### BlocListener
Executa ações (navegação, snackbar) sem reconstruir:

```dart
BlocListener<GamesBloc, GamesState>(
  listener: (context, state) {
    if (state is GamesErrorState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  },
  child: YourWidget(),
)
```

### BlocConsumer
Combina BlocBuilder e BlocListener:

```dart
BlocConsumer<GamesBloc, GamesState>(
  listener: (context, state) {
    // Side effects
  },
  builder: (context, state) {
    // UI
    return YourWidget();
  },
)
```

## Testes

### Testar BLoC

```dart
void main() {
  group('GamesBloc', () {
    late GamesBloc bloc;
    late MockGetAllGamesUseCase mockUseCase;

    setUp(() {
      mockUseCase = MockGetAllGamesUseCase();
      bloc = GamesBloc(getAllGamesUseCase: mockUseCase);
    });

    tearDown(() {
      bloc.close();
    });

    test('estado inicial é GamesInitialState', () {
      expect(bloc.state, const GamesInitialState());
    });

    blocTest<GamesBloc, GamesState>(
      'emite [GamesLoadingState, GamesLoadedState] quando LoadGamesEvent é bem-sucedido',
      build: () {
        when(() => mockUseCase())
          .thenAnswer((_) async => Right([mockGame]));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadGamesEvent()),
      expect: () => [
        const GamesLoadingState(),
        GamesLoadedState([mockGame]),
      ],
    );
  });
}
```

## Próximos Passos

1. Adicionar BLoC para outras features (instalação, configuração, etc.)
2. Implementar BlocObserver para logging global
3. Adicionar testes unitários para os BLoCs
4. Implementar estados de refresh pull-to-refresh
5. Adicionar debounce para eventos de busca
