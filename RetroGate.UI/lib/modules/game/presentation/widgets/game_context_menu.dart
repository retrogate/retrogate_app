import 'package:flutter/material.dart';
import '../../domain/models/game.dart';

enum GameContextMenuAction {
  install,
  edit,
  hide,
  play,
  addToFavorites,
  uninstall,
}

class _MenuOption {
  final IconData icon;
  final String label;
  final GameContextMenuAction action;
  final bool isDestructive;

  _MenuOption({
    required this.icon,
    required this.label,
    required this.action,
    this.isDestructive = false,
  });
}

class GameContextMenu extends StatefulWidget {
  final Game game;
  final VoidCallback onClose;
  final Function(GameContextMenuAction) onActionSelected;

  const GameContextMenu({
    super.key,
    required this.game,
    required this.onClose,
    required this.onActionSelected,
  });

  @override
  State<GameContextMenu> createState() => _GameContextMenuState();
}

class _GameContextMenuState extends State<GameContextMenu> {
  int _selectedIndex = 0;
  late List<_MenuOption> _options;

  @override
  void initState() {
    super.initState();
    _buildOptions();
  }

  void _buildOptions() {
    if (widget.game.isInstalled) {
      _options = [
        _MenuOption(
          icon: Icons.play_arrow,
          label: 'Play',
          action: GameContextMenuAction.play,
        ),
        _MenuOption(
          icon: Icons.favorite_border,
          label: 'Add to Favorites',
          action: GameContextMenuAction.addToFavorites,
        ),
        _MenuOption(
          icon: Icons.delete_outline,
          label: 'Uninstall',
          action: GameContextMenuAction.uninstall,
          isDestructive: true,
        ),
      ];
    } else {
      _options = [
        _MenuOption(
          icon: Icons.download,
          label: 'Install',
          action: GameContextMenuAction.install,
        ),
        _MenuOption(
          icon: Icons.edit,
          label: 'Edit',
          action: GameContextMenuAction.edit,
        ),
        _MenuOption(
          icon: Icons.visibility_off,
          label: 'Hide',
          action: GameContextMenuAction.hide,
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClose,
      child: Container(
        color: Colors.black.withValues(alpha: 0.7),
        child: Center(
          child: GestureDetector(
            onTap: () {}, // Prevent tap from closing when clicking on menu
            child: Container(
              width: 400,
              decoration: BoxDecoration(
                color: const Color(0xFF1B2838),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF66C0F4),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF66C0F4).withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Color(0xFF171A21),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.menu,
                          color: Color(0xFF66C0F4),
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            widget.game.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Options
                  ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: _options.length,
                    itemBuilder: (context, index) {
                      final option = _options[index];
                      final isSelected = index == _selectedIndex;
                      
                      return _buildMenuItem(
                        option: option,
                        isSelected: isSelected,
                        onTap: () {
                          widget.onActionSelected(option.action);
                          widget.onClose();
                        },
                      );
                    },
                  ),
                  // Footer hint
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Color(0xFF171A21),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(6),
                        bottomRight: Radius.circular(6),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildHint(Icons.close, 'Back'),
                        const SizedBox(width: 24),
                        _buildHint(Icons.check, 'Select'),
                      ],
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

  Widget _buildMenuItem({
    required _MenuOption option,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF66C0F4).withValues(alpha: 0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: isSelected
                ? Border.all(
                    color: const Color(0xFF66C0F4),
                    width: 2,
                  )
                : null,
          ),
          child: Row(
            children: [
              Icon(
                option.icon,
                color: option.isDestructive
                    ? const Color(0xFFD32F2F)
                    : isSelected
                        ? const Color(0xFF66C0F4)
                        : Colors.white,
                size: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  option.label,
                  style: TextStyle(
                    color: option.isDestructive
                        ? const Color(0xFFD32F2F)
                        : isSelected
                            ? const Color(0xFF66C0F4)
                            : Colors.white,
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF66C0F4),
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHint(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFF66C0F4).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: const Color(0xFF66C0F4),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            size: 16,
            color: const Color(0xFF66C0F4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF8F98A0),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
