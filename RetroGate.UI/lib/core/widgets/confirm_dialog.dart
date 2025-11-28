import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamepads/gamepads.dart';

class ConfirmDialog extends StatefulWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final IconData? icon;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmLabel = 'Confirm',
    this.cancelLabel = 'Cancel',
    this.icon,
  });

  @override
  State<ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  int _selectedIndex = 0; // 0 = Confirm, 1 = Cancel
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
    Gamepads.events.listen(_handleGamepad);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleGamepad(GamepadEvent event) {
    if (!mounted) return;
    if (event.type == KeyType.button && event.value > 0.5) {
      switch (event.key) {
        case 'button_a':
        case 'button_cross':
        case '0':
        case 'button-0':
          _selectCurrent();
          break;
        case 'button_b':
        case 'button_circle':
        case '1':
        case 'button-1':
        case 'button_back':
        case 'button_select':
        case 'button_share':
        case '8':
        case 'button-8':
          Navigator.of(context).pop(false);
          break;
      }
    } else if (event.type == KeyType.analog && event.key == 'pov') {
      if (event.value == 65535.0) return;
      if (event.value >= 0.0 && event.value < 4500.0) {
        // Up
        setState(() => _selectedIndex = 0);
      } else if (event.value >= 13500.0 && event.value < 22500.0) {
        // Down
        setState(() => _selectedIndex = 1);
      }
    }
  }

  void _selectCurrent() {
    Navigator.of(context).pop(_selectedIndex == 0);
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      focusNode: _focusNode,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          switch (event.logicalKey) {
            case LogicalKeyboardKey.arrowUp:
              setState(() => _selectedIndex = 0);
              return KeyEventResult.handled;
            case LogicalKeyboardKey.arrowDown:
              setState(() => _selectedIndex = 1);
              return KeyEventResult.handled;
            case LogicalKeyboardKey.enter:
            case LogicalKeyboardKey.space:
              _selectCurrent();
              return KeyEventResult.handled;
            case LogicalKeyboardKey.escape:
              Navigator.of(context).pop(false);
              return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: Dialog(
        backgroundColor: const Color(0xFF1B2838),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          width: 380,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null)
                Icon(widget.icon, size: 48, color: const Color(0xFF66C0F4)),
              const SizedBox(height: 12),
              Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                widget.message,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton(
                    label: widget.confirmLabel,
                    selected: _selectedIndex == 0,
                    color: const Color(0xFF66C0F4),
                    onTap: () => Navigator.of(context).pop(true),
                  ),
                  const SizedBox(width: 24),
                  _buildButton(
                    label: widget.cancelLabel,
                    selected: _selectedIndex == 1,
                    color: const Color(0xFFD32F2F),
                    onTap: () => Navigator.of(context).pop(false),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required bool selected,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? color.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: selected ? color : color.withOpacity(0.5),
            width: selected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? color : Colors.white,
            fontSize: 16,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
