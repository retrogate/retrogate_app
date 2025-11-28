import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamepads/gamepads.dart';
import '../../domain/models/game.dart';
import '../../../installer/domain/models/installer_progress.dart';

enum GameContextMenuAction {
  install,
  cancelInstallation,
  edit,
  hide,
  play,
  addToFavorites,
  uninstall,
  delete,
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
  final InstallerProgress? installProgress;

  const GameContextMenu({
    super.key,
    required this.game,
    required this.onClose,
    required this.onActionSelected,
    this.installProgress,
  });

  @override
  State<GameContextMenu> createState() => _GameContextMenuState();
}

class _GameContextMenuState extends State<GameContextMenu> {
  int _selectedIndex = 0;
  late List<_MenuOption> _options;
  StreamSubscription<GamepadEvent>? _gamepadSubscription;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _buildOptions();
    _initGamepad();
  }

  @override
  void dispose() {
    _gamepadSubscription?.cancel();
    super.dispose();
  }

  void _initGamepad() {
    _gamepadSubscription = Gamepads.events.listen((event) {
      if (!mounted) return;

      if (event.type == KeyType.button) {
        _handleButtonInput(event);
      } else if (event.type == KeyType.analog) {
        _handleAnalogInput(event);
      }
    });
  }

  void _handleButtonInput(GamepadEvent event) {
    if (event.value < 0.5) return;

    switch (event.key) {
      case 'button_a':
      case 'button_cross':
      case '0':
      case 'button-0':
        _selectCurrentItem();
        break;
      case 'button_b':
      case 'button_circle':
      case '1':
      case 'button-1':
      case 'button_select':
      case 'button_back':
      case 'button_share':
      case '8':
      case 'button-8':
        widget.onClose();
        break;
    }
  }

  void _handleAnalogInput(GamepadEvent event) {
    if (event.key == 'pov') {
      if (event.value == 65535.0) return; // Neutral

      if (event.value >= 0.0 && event.value < 4500.0) {
        // Up
        _moveSelection(-1);
      } else if (event.value >= 13500.0 && event.value < 22500.0) {
        // Down
        _moveSelection(1);
      }
    }
  }

  void _moveSelection(int delta) {
    setState(() {
      _selectedIndex = (_selectedIndex + delta).clamp(0, _options.length - 1);
    });
  }

  void _selectCurrentItem() {
    if (!mounted || _isProcessing) return;
    _isProcessing = true;
    
    final option = _options[_selectedIndex];
    widget.onActionSelected(option.action);
    widget.onClose();
  }

  void _buildOptions() {
    final isInstalling = widget.installProgress != null && widget.installProgress!.isInProgress;
    
    if (widget.game.isInstalled) {
      _options = [
        _MenuOption(
          icon: Icons.play_arrow,
          label: 'Play',
          action: GameContextMenuAction.play,
        ),
        // _MenuOption(
        //   icon: Icons.favorite_border,
        //   label: 'Add to Favorites',
        //   action: GameContextMenuAction.addToFavorites,
        // ),
        _MenuOption(
          icon: Icons.delete_outline,
          label: 'Uninstall',
          action: GameContextMenuAction.uninstall,
          isDestructive: true,
        ),
      ];
    } else if (isInstalling) {
      // Quando está instalando, mostrar apenas opção de cancelar
      _options = [
        _MenuOption(
          icon: Icons.cancel,
          label: 'Cancel Installation',
          action: GameContextMenuAction.cancelInstallation,
          isDestructive: true,
        ),
        // _MenuOption(
        //   icon: Icons.edit,
        //   label: 'Edit',
        //   action: GameContextMenuAction.edit,
        // ),
        // _MenuOption(
        //   icon: Icons.visibility_off,
        //   label: 'Hide',
        //   action: GameContextMenuAction.hide,
        // ),
      ];
    } else {
      // Jogo disponível para instalar
      _options = [
        _MenuOption(
          icon: Icons.download,
          label: 'Install',
          action: GameContextMenuAction.install,
        ),
        _MenuOption(
          icon: Icons.remove_circle_outline,
          label: 'Delete',
          action: GameContextMenuAction.delete,
          isDestructive: true,
        ),
        // _MenuOption(
        //   icon: Icons.edit,
        //   label: 'Edit',
        //   action: GameContextMenuAction.edit,
        // ),
        // _MenuOption(
        //   icon: Icons.visibility_off,
        //   label: 'Hide',
        //   action: GameContextMenuAction.hide,
        // ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          switch (event.logicalKey) {
            case LogicalKeyboardKey.arrowUp:
              _moveSelection(-1);
              return KeyEventResult.handled;
            case LogicalKeyboardKey.arrowDown:
              _moveSelection(1);
              return KeyEventResult.handled;
            case LogicalKeyboardKey.enter:
            case LogicalKeyboardKey.space:
              _selectCurrentItem();
              return KeyEventResult.handled;
            case LogicalKeyboardKey.escape:
              widget.onClose();
              return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: GestureDetector(
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
                          if (!mounted) return;
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
    ));
  }

  Widget _buildMenuItem({
    required _MenuOption option,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        if (_isProcessing) return;
        _isProcessing = true;
        onTap();
      },
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
