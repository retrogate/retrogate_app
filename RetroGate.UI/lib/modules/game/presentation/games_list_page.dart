import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../core/widgets/gamepad_focusable.dart';
import '../../../core/widgets/gamepad_navigation_scope.dart';
import '../../../core/widgets/app_drawer.dart';
import '../domain/models/game.dart';
import '../domain/models/game_source.dart';
import 'bloc/games_bloc.dart';
import 'bloc/games_event.dart';
import 'bloc/games_state.dart';
import 'widgets/games_grid.dart';

class GamesListPage extends StatefulWidget {
  const GamesListPage({super.key});

  @override
  State<GamesListPage> createState() => _GamesListPageState();
}

class _GamesListPageState extends State<GamesListPage> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _hasRegisteredActions = false;
  bool _isDrawerOpen = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (mounted && _tabController.indexIsChanging) {
      // Unfocus current widget and focus first widget in new tab
      FocusManager.instance.primaryFocus?.unfocus();
      
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          FocusScope.of(context).nextFocus();
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    if (!_hasRegisteredActions) {
      // Register menu button action to toggle drawer
      GamepadNavigationScope.registerMenuAction(context, () {
        final scaffoldState = _scaffoldKey.currentState;
        if (scaffoldState != null) {
          if (scaffoldState.isDrawerOpen) {
            Navigator.of(context).pop(); // Close drawer
          } else {
            scaffoldState.openDrawer(); // Open drawer
          }
        }
      });
      
      // Register L1/R1 for tab navigation
      GamepadNavigationScope.registerLeftBumperAction(context, () {
        if (_tabController.index > 0) {
          _tabController.animateTo(_tabController.index - 1);
        }
      });
      
      GamepadNavigationScope.registerRightBumperAction(context, () {
        if (_tabController.index < _tabController.length - 1) {
          _tabController.animateTo(_tabController.index + 1);
        }
      });
      
      _hasRegisteredActions = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Modular.get<GamesBloc>(),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color(0xFF1B2838),
        onDrawerChanged: (isOpen) {
          setState(() {
            _isDrawerOpen = isOpen;
          });
        },
        drawer: const AppDrawer(currentRoute: '/games/'),
        body: _GamesListBody(
          isDrawerOpen: _isDrawerOpen,
          tabController: _tabController,
        ),
        floatingActionButton: Stack(
          children: [
            // Menu button (bottom left)
            Positioned(
              left: 16,
              bottom: 16,
              child: FloatingActionButton(
                onPressed: () {
                  final scaffoldState = _scaffoldKey.currentState;
                  if (scaffoldState != null) {
                    if (scaffoldState.isDrawerOpen) {
                      Navigator.of(context).pop();
                    } else {
                      scaffoldState.openDrawer();
                    }
                  }
                },
                backgroundColor: const Color(0xFF66C0F4),
                heroTag: 'menu_button',
                tooltip: 'Menu',
                child: const Icon(Icons.menu, color: Color(0xFF171A21)),
              ),
            ),
            // Add and Refresh buttons (bottom right) - Only visible on Available tab
            Positioned(
              right: 16,
              bottom: 16,
              child: AnimatedBuilder(
                animation: _tabController,
                builder: (context, child) {
                  // Only show on Available tab (index 0)
                  if (_tabController.index != 0) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GamepadFocusable(
                        onPressed: () {
                          Modular.to.pushNamed('/games/add');
                        },
                        child: FloatingActionButton(
                          onPressed: () {
                            Modular.to.pushNamed('/games/add');
                          },
                          backgroundColor: const Color(0xFF66C0F4),
                          heroTag: 'add_game',
                          tooltip: 'Add Game',
                          child: const Icon(Icons.add, color: Color(0xFF171A21)),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const _RefreshButton(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class _RefreshButton extends StatelessWidget {
  const _RefreshButton();

  @override
  Widget build(BuildContext context) {
    return GamepadFocusable(
      onPressed: () {
        BlocProvider.of<GamesBloc>(context).add(const RefreshGamesEvent(GameSource.available));
      },
      child: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<GamesBloc>(context).add(const RefreshGamesEvent(GameSource.available));
        },
        backgroundColor: const Color(0xFF66C0F4),
        heroTag: 'refresh_games',
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh, color: Color(0xFF171A21)),
      ),
    );
  }
}

class _GamesListBody extends StatelessWidget {
  final bool isDrawerOpen;
  final TabController tabController;

  const _GamesListBody({
    this.isDrawerOpen = false,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header with Tabs
        Container(
          color: const Color(0xFF171A21),
          child: Column(
            children: [
              // Title
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.videogame_asset,
                      color: Color(0xFF66C0F4),
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'GAMES LIBRARY',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              // Tabs
              TabBar(
                controller: tabController,
                indicatorColor: const Color(0xFF66C0F4),
                indicatorWeight: 3,
                labelColor: const Color(0xFF66C0F4),
                unselectedLabelColor: const Color(0xFF8F98A0),
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
                tabs: const [
                  Tab(text: 'AVAILABLE'),
                  Tab(text: 'INSTALLED'),
                ],
              ),
            ],
          ),
        ),
        // Tab Content
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              _GameTabContent(
                source: GameSource.available,
                isDrawerOpen: isDrawerOpen,
                emptyMessage: 'No games available yet',
                tabController: tabController,
                tabIndex: 0,
              ),
              _GameTabContent(
                source: GameSource.installed,
                isDrawerOpen: isDrawerOpen,
                emptyMessage: 'No installed games yet',
                tabController: tabController,
                tabIndex: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GameTabContent extends StatefulWidget {
  final GameSource source;
  final bool isDrawerOpen;
  final String emptyMessage;
  final TabController tabController;
  final int tabIndex;

  const _GameTabContent({
    required this.source,
    this.isDrawerOpen = false,
    required this.emptyMessage,
    required this.tabController,
    required this.tabIndex,
  });

  @override
  State<_GameTabContent> createState() => _GameTabContentState();
}

class _GameTabContentState extends State<_GameTabContent> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // Load games when tab is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<GamesBloc>(context).add(LoadGamesEvent(widget.source));
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return BlocBuilder<GamesBloc, GamesState>(
      builder: (context, state) {
        if (state is GamesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GamesErrorState) {
          return _buildErrorView(context, state.message);
        }

        if (state is GamesEmptyState) {
          return _buildEmptyView();
        }

        if (state is GamesLoadedState) {
          return _buildGamesList(state.games);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.videogame_asset_off,
            size: 64,
            color: const Color(0xFF8F98A0),
          ),
          const SizedBox(height: 16),
          const Text(
            'NO GAMES FOUND',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.emptyMessage,
            style: const TextStyle(
              color: Color(0xFF8F98A0),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Color(0xFFD32F2F)),
          const SizedBox(height: 24),
          Text(
            'Error loading games',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF8F98A0)),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<GamesBloc>(context).add(RefreshGamesEvent(widget.source));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF66C0F4),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: const Text(
              'TRY AGAIN',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGamesList(List<Game> games) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Count badge
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
          child: Row(
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF66C0F4).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF66C0F4),
                    width: 1,
                  ),
                ),
                child: Text(
                  '${games.length} ${games.length == 1 ? 'game' : 'games'}',
                  style: const TextStyle(
                    color: Color(0xFF66C0F4),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Games Grid
        Expanded(
          child: AnimatedBuilder(
            animation: widget.tabController,
            builder: (context, child) {
              // Only enable gamepad navigation when this tab is active
              final isActive = widget.tabController.index == widget.tabIndex;
              return GamesGrid(
                games: games,
                isDrawerOpen: widget.isDrawerOpen || !isActive,
              );
            },
          ),
        ),
      ],
    );
  }
}
