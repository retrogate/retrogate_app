import 'package:flutter/material.dart';
import '../../domain/models/game.dart';
import '../../../installer/domain/models/installer_progress.dart';
import 'gamepad_navigation_wrapper.dart';

class GameCard extends StatefulWidget {
  final Game game;
  final int index;
  final VoidCallback? onTap;
  final InstallerProgress? installProgress;
  final bool isPending;

  const GameCard({
    super.key,
    required this.game,
    required this.index,
    this.onTap,
    this.installProgress,
    this.isPending = false,
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
                        child: _buildCenterIcon(),
                      ),
                    ),
                  // Installation progress overlay
                  if (widget.installProgress != null && widget.installProgress!.isInProgress)
                    _buildProgressOverlay(),
                  // Pending overlay
                  if (widget.isPending)
                    _buildPendingOverlay(),
                  // Installation status badge (subtle, always visible)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: widget.game.isInstalled
                            ? const Color(0xFF5C7E10).withValues(alpha: 0.9) // Green
                            : const Color(0xFF2A475E).withValues(alpha: 0.9), // Gray-blue
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: widget.game.isInstalled
                              ? const Color(0xFF7BA428)
                              : const Color(0xFF66C0F4).withValues(alpha: 0.5),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            widget.game.isInstalled
                                ? Icons.check_circle
                                : Icons.cloud_download_outlined,
                            color: Colors.white,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.game.isInstalled ? 'Installed' : 'Available',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Gamepad selection indicator (overlays status badge when selected)
                  if (isSelected)
                    Positioned(
                      top: 8,
                      left: 8,
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

  Widget _buildCenterIcon() {
    // If pending, show clock icon
    if (widget.isPending) {
      return const Icon(
        Icons.schedule,
        color: Colors.orange,
        size: 32,
      );
    }
    
    // If installing, show spinner
    if (widget.installProgress != null && widget.installProgress!.isInProgress) {
      return const CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 3,
      );
    }

    // Show download icon for available games, play for installed
    return Icon(
      widget.game.isInstalled 
          ? Icons.play_arrow
          : Icons.download,
      color: Colors.white,
      size: 32,
    );
  }

  Widget _buildProgressOverlay() {
    final progress = widget.installProgress!;
    
    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.85),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Progress circle with percentage
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    value: progress.percentage / 100,
                    strokeWidth: 6,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF66C0F4)),
                  ),
                ),
                Text(
                  '${progress.percentage}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // State label
            Text(
              progress.stateLabel,
              style: const TextStyle(
                color: Color(0xFF66C0F4),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            // Speed indicator (only for downloading)
            if (progress.state == InstallerProgressState.downloading)
              Text(
                progress.speedFormatted,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPendingOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.75),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.schedule,
              color: Colors.orange,
              size: 48,
            ),
            SizedBox(height: 12),
            Text(
              'IN QUEUE',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Waiting for installation...',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
