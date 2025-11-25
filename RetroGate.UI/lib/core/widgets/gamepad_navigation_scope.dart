import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamepads/gamepads.dart';
import 'package:window_manager/window_manager.dart';

/// Global gamepad navigation scope that manages gamepad input for the entire app
class GamepadNavigationScope extends StatefulWidget {
  final Widget child;

  const GamepadNavigationScope({
    super.key,
    required this.child,
  });

  @override
  State<GamepadNavigationScope> createState() => _GamepadNavigationScopeState();

  static _GamepadNavigationScopeState? of(BuildContext context) {
    return context.findAncestorStateOfType<_GamepadNavigationScopeState>();
  }
  
  /// Register a callback for the menu button (Start button)
  static void registerMenuAction(BuildContext context, VoidCallback callback) {
    of(context)?.registerMenuAction(callback);
  }
  
  /// Register a callback for the back button (B button)
  static void registerBackAction(BuildContext context, VoidCallback callback) {
    of(context)?.registerBackAction(callback);
  }
  
  /// Unregister the menu button callback
  static void unregisterMenuAction(BuildContext context) {
    of(context)?.unregisterMenuAction();
  }
  
  /// Unregister the back button callback
  static void unregisterBackAction(BuildContext context) {
    of(context)?.unregisterBackAction();
  }
}

class _GamepadNavigationScopeState extends State<GamepadNavigationScope> {
  StreamSubscription<GamepadEvent>? _gamepadSubscription;
  List<String> _connectedGamepads = [];
  
  // Custom actions that can be registered by widgets
  VoidCallback? _onMenuButtonPressed;
  VoidCallback? _onBackButtonPressed;

  @override
  void initState() {
    super.initState();
    _checkConnectedGamepads();
    _initGamepad();
  }

  @override
  void dispose() {
    _gamepadSubscription?.cancel();
    super.dispose();
  }

  void _checkConnectedGamepads() async {
    try {
      final gamepads = await Gamepads.list();
      setState(() {
        _connectedGamepads = gamepads.map((g) => g.id).toList();
      });
    } catch (e) {
      // Silently handle errors
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
    if (event.value < 0.5) return;

    switch (event.key) {
      // Menu button (Xbox button / PS button / Start)
      case 'button_select':
      case 'button_start':
      case 'button_mode':
      case '7': // Start button
      case 'button-7':
        _onMenuButtonPressed?.call();
        break;

      // Back button (B / Circle / Escape)
      case 'button_b':
      case 'button_circle':
      case '1':
      case 'button-1':
        _onBackButtonPressed?.call();
        break;

      // A button will be handled by focused widgets
      case 'button_a':
      case 'button_cross':
      case '0':
      case 'button-0':
        // Trigger activation on currently focused widget
        if(event.value == 1.0) {
          _activateFocusedWidget();
        }
        break;
    }
  }

  void _handleAnalogInput(GamepadEvent event) {
    // POV (D-Pad) navigation
    if (event.key == 'pov') {
      if (event.value == 65535.0) return; // Neutral

      if (event.value >= 0.0 && event.value < 4500.0) {
        // Up
        _moveFocus(TraversalDirection.up);
      } else if (event.value >= 4500.0 && event.value < 13500.0) {
        // Right
        _moveFocus(TraversalDirection.right);
      } else if (event.value >= 13500.0 && event.value < 22500.0) {
        // Down
        _moveFocus(TraversalDirection.down);
      } else if (event.value >= 22500.0 && event.value < 31500.0) {
        // Left
        _moveFocus(TraversalDirection.left);
      }
    }
  }

  void _moveFocus(TraversalDirection direction) {
    final FocusNode? currentFocus = FocusManager.instance.primaryFocus;
    if (currentFocus != null) {
      currentFocus.focusInDirection(direction);
    }
  }

  void _activateFocusedWidget() {
    final FocusNode? currentFocus = FocusManager.instance.primaryFocus;
    if (currentFocus != null && currentFocus.context != null) {
      // Try to activate the widget using onKey callback
      final result = currentFocus.onKeyEvent?.call(
        currentFocus,
        KeyDownEvent(
          physicalKey: PhysicalKeyboardKey.enter,
          logicalKey: LogicalKeyboardKey.enter,
          timeStamp: Duration.zero,
        ),
      );
      
      if (result != KeyEventResult.handled) {
        // Fallback: try to find and tap the widget
        final RenderBox? renderBox = currentFocus.context?.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          // Widget will handle activation through its own onTap/onPressed
        }
      }
    }
  }

  void registerMenuAction(VoidCallback callback) {
    _onMenuButtonPressed = callback;
  }

  void registerBackAction(VoidCallback callback) {
    _onBackButtonPressed = callback;
  }

  void unregisterMenuAction() {
    _onMenuButtonPressed = null;
  }

  void unregisterBackAction() {
    _onBackButtonPressed = null;
  }

  bool get hasGamepad => _connectedGamepads.isNotEmpty;

  int get gamepadCount => _connectedGamepads.length;

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (node, event) {
        // Handle F11 to toggle fullscreen
        if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.f11) {
          _toggleFullscreen();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: widget.child,
    );
  }
  
  Future<void> _toggleFullscreen() async {
    final isFullScreen = await windowManager.isFullScreen();
    await windowManager.setFullScreen(!isFullScreen);
  }
}

/// Widget indicator showing gamepad status
class GamepadStatusIndicator extends StatelessWidget {
  const GamepadStatusIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = GamepadNavigationScope.of(context);
    
    if (scope == null || !scope.hasGamepad) {
      return const SizedBox.shrink();
    }

    return Container(
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
            '${scope.gamepadCount} gamepad(s)',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
