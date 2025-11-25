import 'package:flutter/material.dart';
import '../../domain/models/game.dart';
import '../../domain/models/game_source.dart';
import 'gamepad_navigation_wrapper.dart';

class GameCard extends StatefulWidget {
  final Game game;
  final int index;
  final VoidCallback? onTap;
  final GameSource source;

  const GameCard({
    super.key,
    required this.game,
    required this.index,
    this.onTap,
    required this.source,
  });

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
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
          onTap: widget.onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
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
                  _buildGameImage(),
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
                  Positioned(
                    left: 12,
                    right: 12,
                    bottom: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                  if (_isHovered || isSelected)
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF66C0F4).withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          widget.source == GameSource.available 
                              ? Icons.download 
                              : Icons.play_arrow,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
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
