import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamepads/gamepads.dart';

/// Wrapper that provides grid-based navigation for game cards
/// Handles its own gamepad input for grid navigation
class GamepadNavigationWrapper extends StatefulWidget {
  final Widget child;
  final int itemCount;
  final int crossAxisCount;
  final Function(int index) onItemSelected;
  final Function(int index)? onContextMenu;
  final bool enabled;
  final ScrollController? scrollController;

  const GamepadNavigationWrapper({
    super.key,
    required this.child,
    required this.itemCount,
    required this.crossAxisCount,
    required this.onItemSelected,
    this.onContextMenu,
    this.enabled = true,
    this.scrollController,
  });

  @override
  State<GamepadNavigationWrapper> createState() => _GamepadNavigationWrapperState();
}

class _GamepadNavigationWrapperState extends State<GamepadNavigationWrapper> {
  int _selectedIndex = 0;
  StreamSubscription<GamepadEvent>? _gamepadSubscription;

  @override
  void initState() {
    super.initState();
    _initGamepad();
  }

  @override
  void dispose() {
    _gamepadSubscription?.cancel();
    super.dispose();
  }

  void _initGamepad() {
    _gamepadSubscription = Gamepads.events.listen((event) {
      if (!widget.enabled || !mounted) return;
      
      try {
        if (event.type == KeyType.button) {
          _handleButtonInput(event);
        } else if (event.type == KeyType.analog) {
          _handleAnalogInput(event);
        }
      } catch (e) {
        debugPrint('Gamepad grid navigation error: $e');
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
      case 'button_select':
      case 'button_back':
      case 'button_share':
      case '6':
      case 'button-6':
        _openContextMenu();
        break;
    }
  }

  void _handleAnalogInput(GamepadEvent event) {
    if (event.key == 'pov') {
      if (event.value == 65535.0) return; // Neutral
      
      if (event.value >= 0.0 && event.value < 4500.0) {
        _moveSelection(-widget.crossAxisCount); // Up
      } else if (event.value >= 4500.0 && event.value < 13500.0) {
        _moveSelection(1); // Right
      } else if (event.value >= 13500.0 && event.value < 22500.0) {
        _moveSelection(widget.crossAxisCount); // Down
      } else if (event.value >= 22500.0 && event.value < 31500.0) {
        _moveSelection(-1); // Left
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: widget.enabled,
      onKeyEvent: (node, event) {
        if (!widget.enabled) return KeyEventResult.ignored;
        
        // Keyboard fallback
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
    );
  }

  void _moveSelection(int delta) {
    if (!widget.enabled) return;
    
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

    final scrollController = widget.scrollController!;
    final viewportHeight = scrollController.position.viewportDimension;
    final maxScroll = scrollController.position.maxScrollExtent;
    
    // Calculate row and approximate item height
    final row = _selectedIndex ~/ widget.crossAxisCount;
    final totalRows = (widget.itemCount / widget.crossAxisCount).ceil();
    
    // Estimate the scroll position for this row
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
    if (!widget.enabled) return;
    widget.onItemSelected(_selectedIndex);
  }

  void _openContextMenu() {
    if (!widget.enabled) return;
    widget.onContextMenu?.call(_selectedIndex);
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
