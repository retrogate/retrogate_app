import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'gamepad_focusable.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;

  const AppDrawer({
    super.key,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    final isGamesRoute = currentRoute == '/games/' || currentRoute == '/games/add';
    final isConfigRoute = currentRoute == '/config/';
    
    return Drawer(
      backgroundColor: const Color(0xFF171A21),
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF1B2838),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.gamepad,
                  size: 64,
                  color: const Color(0xFF66C0F4),
                ),
                const SizedBox(height: 16),
                const Text(
                  'RETROGATE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          GamepadFocusable(
            autofocus: isGamesRoute,
            onPressed: () {
              Navigator.pop(context);
              if (currentRoute != '/games/') {
                Modular.to.navigate('/games/');
              }
            },
            child: ListTile(
              leading: const Icon(
                Icons.videogame_asset,
                color: Color(0xFF66C0F4),
              ),
              title: const Text(
                'Browse Games',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              selected: isGamesRoute,
              selectedTileColor: const Color(0xFF1B2838),
            ),
          ),
          GamepadFocusable(
            autofocus: isConfigRoute,
            onPressed: () {
              Navigator.pop(context);
              if (currentRoute != '/config/') {
                Modular.to.navigate('/config/');
              }
            },
            child: ListTile(
              leading: const Icon(
                Icons.settings,
                color: Color(0xFF8F98A0),
              ),
              title: const Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              selected: isConfigRoute,
              selectedTileColor: const Color(0xFF1B2838),
            ),
          ),
          const Spacer(),
          const Divider(color: Color(0xFF2A475E)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Version 1.0.0',
              style: TextStyle(
                color: const Color(0xFF8F98A0),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
