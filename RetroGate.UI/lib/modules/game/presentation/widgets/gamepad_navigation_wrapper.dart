import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamepads/gamepads.dart';

class GamepadNavigationWrapper extends StatefulWidget {
  final Widget child;
  final int itemCount;
  final int crossAxisCount;
  final Function(int index) onItemSelected;
  final bool enabled;
  final ScrollController? scrollController;

  const GamepadNavigationWrapper({
    super.key,
    required this.child,
    required this.itemCount,
    required this.crossAxisCount,
    required this.onItemSelected,
    this.enabled = true,
    this.scrollController,
  });

  @override
  State<GamepadNavigationWrapper> createState() => _GamepadNavigationWrapperState();
}

class _GamepadNavigationWrapperState extends State<GamepadNavigationWrapper> {
  int _selectedIndex = 0;
  StreamSubscription<GamepadEvent>? _gamepadSubscription;
  List<String> _connectedGamepads = [];

  @override
  void initState() {
    super.initState();
    _checkConnectedGamepads();
    _initGamepad();
  }

  void _checkConnectedGamepads() async {
    try {
      final gamepads = await Gamepads.list();
      setState(() {
        _connectedGamepads = gamepads.map((g) => g.id).toList();
      });
    } catch (e) {
      // Silently handle gamepad detection errors
    }
  }

  void _initGamepad() {
    _gamepadSubscription = Gamepads.events.listen((event) {
      if (event.type == KeyType.button) {
        _handleButtonInput(event);
      } else if (event.type == KeyType.analog) {
        _handleAnalogInput(event);
      }
    });
  }

  void _handleButtonInput(GamepadEvent event) {
    if (!widget.enabled) return; // Ignore input when disabled
    if (event.value < 0.5) return; // Button not pressed enough
    
    switch (event.key) {
      // Xbox controller buttons
      case 'button_a':
      case 'button_cross':
      case '0':
      case 'button-0':
        _selectCurrentItem();
        break;
    }
  }

  void _handleAnalogInput(GamepadEvent event) {
    if (!widget.enabled) return; // Ignore input when disabled
    
    // POV (D-Pad) - Point of View hat switch
    // Values in degrees * 100: 0=up, 9000=right, 18000=down, 27000=left, 65535=neutral
    if (event.key == 'pov') {
      if (event.value == 65535.0) {
        // Neutral position
        return;
      } else if (event.value >= 0.0 && event.value < 4500.0) {
        // Up (0° ± 45°)
        _moveSelection(-widget.crossAxisCount);
      } else if (event.value >= 4500.0 && event.value < 13500.0) {
        // Right (90° ± 45°)
        _moveSelection(1);
      } else if (event.value >= 13500.0 && event.value < 22500.0) {
        // Down (180° ± 45°)
        _moveSelection(widget.crossAxisCount);
      } else if (event.value >= 22500.0 && event.value < 31500.0) {
        // Left (270° ± 45°)
        _moveSelection(-1);
      }
      return;
    }
    
    // Ignore all other analog inputs (left stick, right stick, triggers)
  }

  void _moveSelection(int delta) {
    setState(() {
      final newIndex = _selectedIndex + delta;
      if (newIndex >= 0 && newIndex < widget.itemCount) {
        _selectedIndex = newIndex;
        _scrollToSelected();
      }
    });
  }

  void _scrollToSelected() {
    if (widget.scrollController == null || !widget.scrollController!.hasClients) {
      return;
    }

    // Calculate the position of the selected item
    final scrollController = widget.scrollController!;
    final viewportHeight = scrollController.position.viewportDimension;
    final maxScroll = scrollController.position.maxScrollExtent;
    
    // Calculate row and approximate item height
    final row = _selectedIndex ~/ widget.crossAxisCount;
    final totalRows = (widget.itemCount / widget.crossAxisCount).ceil();
    
    // Estimate the scroll position for this row
    // This assumes uniform item heights
    final estimatedItemHeight = (maxScroll + viewportHeight) / totalRows;
    final targetScrollTop = row * estimatedItemHeight;
    final targetScrollBottom = (row + 1) * estimatedItemHeight;
    
    final currentScroll = scrollController.offset;
    final currentViewportBottom = currentScroll + viewportHeight;
    
    // Scroll if item is not fully visible
    if (targetScrollTop < currentScroll) {
      // Item is above viewport, scroll up
      scrollController.animateTo(
        targetScrollTop,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (targetScrollBottom > currentViewportBottom) {
      // Item is below viewport, scroll down
      final newScroll = targetScrollBottom - viewportHeight;
      scrollController.animateTo(
        newScroll.clamp(0.0, maxScroll),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _selectCurrentItem() {
    widget.onItemSelected(_selectedIndex);
  }

  @override
  void dispose() {
    _gamepadSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Focus(
          autofocus: true,
          onKeyEvent: (node, event) {
            // Ignore keyboard events if gamepad is connected (prevents double input)
            if (_connectedGamepads.isNotEmpty) {
              return KeyEventResult.ignored;
            }
            
            // Keyboard fallback for testing without gamepad
            if (event is KeyDownEvent) {
              switch (event.logicalKey) {
                case LogicalKeyboardKey.arrowUp:
                  _moveSelection(-widget.crossAxisCount);
                  return KeyEventResult.handled;
                case LogicalKeyboardKey.arrowDown:
                  _moveSelection(widget.crossAxisCount);
                  return KeyEventResult.handled;
                case LogicalKeyboardKey.arrowLeft:
                  _moveSelection(-1);
                  return KeyEventResult.handled;
                case LogicalKeyboardKey.arrowRight:
                  _moveSelection(1);
                  return KeyEventResult.handled;
                case LogicalKeyboardKey.enter:
                case LogicalKeyboardKey.space:
                  _selectCurrentItem();
                  return KeyEventResult.handled;
              }
            }
            return KeyEventResult.ignored;
          },
          child: GamepadSelectionProvider(
            selectedIndex: _selectedIndex,
            child: widget.child,
          ),
        ),
        
        // Gamepad status indicator
        if (_connectedGamepads.isNotEmpty)
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF66C0F4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.gamepad,
                    color: Colors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${_connectedGamepads.length} gamepad(s)',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class GamepadSelectionProvider extends InheritedWidget {
  final int selectedIndex;

  const GamepadSelectionProvider({
    super.key,
    required this.selectedIndex,
    required super.child,
  });

  static int of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<GamepadSelectionProvider>();
    return provider?.selectedIndex ?? -1;
  }

  @override
  bool updateShouldNotify(GamepadSelectionProvider oldWidget) {
    return selectedIndex != oldWidget.selectedIndex;
  }
}
