import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../domain/models/game.dart';
import '../../domain/models/game_source.dart';
import '../../../installer/presentation/bloc/installer_bloc.dart';
import '../../../installer/presentation/bloc/installer_state.dart';
import 'game_card.dart';
import 'gamepad_navigation_wrapper.dart';

class GamesGrid extends StatefulWidget {
  final List<Game> games;
  final bool isDrawerOpen;
  final void Function(Game game, GameSource source, int index)? onGameSelected;
  final GameSource source;

  const GamesGrid({
    super.key,
    required this.games,
    this.isDrawerOpen = false,
    this.onGameSelected,  
    required this.source,
  });

  @override
  State<GamesGrid> createState() => _GamesGridState();
}

class _GamesGridState extends State<GamesGrid> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          itemCount: widget.games.length,
          crossAxisCount: crossAxisCount,
          enabled: !widget.isDrawerOpen, // Disable when drawer is open
          scrollController: _scrollController,
          onItemSelected: (index) {
            final game = widget.games[index];
            
            // Call custom callback if provided
            if (widget.onGameSelected != null) {
              widget.onGameSelected!(game, widget.source, index);
            } else {
              // Default behavior: show snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Selected: ${game.name}'),
                  duration: const Duration(seconds: 2),
                  backgroundColor: const Color(0xFF66C0F4),
                ),
              );
            }
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
            itemCount: widget.games.length,
            itemBuilder: (context, index) {
              final game = widget.games[index];
              
              return BlocBuilder<InstallerBloc, InstallerState>(
                bloc: Modular.get<InstallerBloc>(),
                builder: (context, installerState) {
                  final progress = installerState is InstallerDataState
                      ? installerState.getProgress(game.id)
                      : null;
                  
                  return GameCard(
                    game: game,
                    index: index,
                    source: widget.source,
                    installProgress: progress,
                    onTap: () {
                      if (widget.onGameSelected != null) {
                        widget.onGameSelected!(game, widget.source, index);
                      }
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
