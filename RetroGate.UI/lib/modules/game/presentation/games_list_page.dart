import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../core/widgets/gamepad_focusable.dart';
import '../../../core/widgets/gamepad_navigation_scope.dart';
import '../../../core/widgets/app_drawer.dart';
import '../domain/models/game.dart';
import 'bloc/games_bloc.dart';
import 'bloc/games_event.dart';
import 'bloc/games_state.dart';
import 'widgets/gamepad_navigation_wrapper.dart';

class GamesListPage extends StatefulWidget {
  const GamesListPage({super.key});

  @override
  State<GamesListPage> createState() => _GamesListPageState();
}

class _GamesListPageState extends State<GamesListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _hasRegisteredActions = false;
  bool _isDrawerOpen = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // Register menu button action to toggle drawer
    if (!_hasRegisteredActions) {
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
      _hasRegisteredActions = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Modular.get<GamesBloc>()..add(const LoadGamesEvent()),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color(0xFF1B2838),
        onDrawerChanged: (isOpen) {
          setState(() {
            _isDrawerOpen = isOpen;
          });
        },
        drawer: const AppDrawer(currentRoute: '/games/'),
        body: _GamesListBody(isDrawerOpen: _isDrawerOpen),
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
            // Add and Refresh buttons (bottom right)
            Positioned(
              right: 16,
              bottom: 16,
              child: Column(
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
        BlocProvider.of<GamesBloc>(context).add(const RefreshGamesEvent());
      },
      child: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<GamesBloc>(context).add(const RefreshGamesEvent());
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

  const _GamesListBody({this.isDrawerOpen = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamesBloc, GamesState>(
      builder: (context, state) {
        if (state is GamesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GamesErrorState) {
          return _buildErrorView(context, state.message);
        }

        if (state is GamesEmptyState) {
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
                const Text(
                  'No games available yet',
                  style: TextStyle(
                    color: Color(0xFF8F98A0),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }

        if (state is GamesLoadedState) {
          return _buildGamesList(state.games);
        }

        return const SizedBox.shrink();
      },
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
              BlocProvider.of<GamesBloc>(context).add(const RefreshGamesEvent());
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
        // Title Section
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
                'AVAILABLE GAMES',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
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
          child: _GamesGrid(games: games, isDrawerOpen: isDrawerOpen),
        ),
      ],
    );
  }
}

class _GamesGrid extends StatefulWidget {
  final List<Game> games;
  final bool isDrawerOpen;

  const _GamesGrid({required this.games, required this.isDrawerOpen});

  @override
  State<_GamesGrid> createState() => _GamesGridState();
}

class _GamesGridState extends State<_GamesGrid> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildGamesGrid(widget.games);
  }

  Widget _buildGamesGrid(List<Game> games) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive grid: more columns on wider screens
        // Adjusted for vertical poster images
        int crossAxisCount;
        if (constraints.maxWidth > 1400) {
          crossAxisCount = 6;
        } else if (constraints.maxWidth > 1100) {
          crossAxisCount = 5;
        } else if (constraints.maxWidth > 900) {
          crossAxisCount = 4;
        } else if (constraints.maxWidth > 600) {
          crossAxisCount = 3;
        } else if (constraints.maxWidth > 400) {
          crossAxisCount = 2;
        } else {
          crossAxisCount = 1;
        }

        return GamepadNavigationWrapper(
          itemCount: games.length,
          crossAxisCount: crossAxisCount,
          enabled: !widget.isDrawerOpen, // Disable when drawer is open
          scrollController: _scrollController,
          onItemSelected: (index) {
            // TODO: Navigate to game details or launch game
            final game = games[index];
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Selected: ${game.name}'),
                duration: const Duration(seconds: 2),
                backgroundColor: const Color(0xFF66C0F4),
              ),
            );
          },
          child: GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 3 / 4, // Portrait ratio for poster images (vertical)
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: games.length,
            itemBuilder: (context, index) {
              final game = games[index];
              return _GameCard(game: game, index: index);
            },
          ),
        );
      },
    );
  }
}

class _GameCard extends StatefulWidget {
  final Game game;
  final int index;

  const _GameCard({required this.game, required this.index});

  @override
  State<_GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<_GameCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Check if this card is selected by gamepad
    final selectedIndex = GamepadSelectionProvider.of(context);
    final isSelected = selectedIndex == widget.index;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: _isHovered || isSelected ? 1.05 : 1.0,
        child: GestureDetector(
          onTap: () {
            // TODO: Navigate to game details
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              // Highlight border when selected
              border: isSelected 
                ? Border.all(
                    color: const Color(0xFF66C0F4),
                    width: 3,
                  )
                : null,
              boxShadow: _isHovered || isSelected
                  ? [
                      BoxShadow(
                        color: const Color(0xFF66C0F4).withValues(alpha: 0.5),
                        blurRadius: 16,
                        spreadRadius: 2,
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Background Image (Hero image)
                  _buildGameImage(),
                  
                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.7),
                          Colors.black.withValues(alpha: 0.9),
                        ],
                        stops: const [0.0, 0.6, 1.0],
                      ),
                    ),
                  ),
                  
                  // Game Info
                  Positioned(
                    left: 12,
                    right: 12,
                    bottom: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Game Title
                        _buildGameTitle(),
                        
                        if (_isHovered) ...[
                          const SizedBox(height: 8),
                          Text(
                            widget.game.executablePath.split('\\').last,
                            style: const TextStyle(
                              color: Color(0xFF8F98A0),
                              fontSize: 11,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  
                  // Play Icon on Hover
                  if (_isHovered || isSelected)
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF66C0F4).withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  
                  // Gamepad indicator when selected
                  if (isSelected)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF66C0F4),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.gamepad,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameImage() {
    // Use poster image (vertical/portrait format) for grid layout
    // Poster is the primary image for game cards, similar to game covers
    final imageUrl = widget.game.imagePosterUrl.isNotEmpty
        ? widget.game.imagePosterUrl
        : widget.game.imageHeroUrl.isNotEmpty
            ? widget.game.imageHeroUrl
            : '';

    if (imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildFallbackImage(),
      );
    }

    return _buildFallbackImage();
  }

  Widget _buildFallbackImage() {
    return Container(
      color: const Color(0xFF2A475E),
      child: const Center(
        child: Icon(
          Icons.games,
          size: 48,
          color: Color(0xFF66C0F4),
        ),
      ),
    );
  }

  Widget _buildGameTitle() {
    return Text(
      widget.game.name,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(
            color: Colors.black,
            offset: Offset(1, 1),
            blurRadius: 2,
          ),
        ],
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
