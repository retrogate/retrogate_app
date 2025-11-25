import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:window_manager/window_manager.dart';
import 'app_module.dart';
import 'core/widgets/gamepad_navigation_scope.dart';
import 'core/preferences/app_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize local preferences
  await AppPreferences.initialize();
  
  // Configure window for desktop platforms
  await windowManager.ensureInitialized();
  
  // Read fullscreen preference
  final startFullscreen = AppPreferences.isFullscreenEnabled();
  // final windowWidth = AppPreferences.getWindowWidth();
  // final windowHeight = AppPreferences.getWindowHeight();
  
  WindowOptions windowOptions = WindowOptions(
    // size: Size(windowWidth, windowHeight),
    // minimumSize: const Size(800, 600),
    // center: true,
    backgroundColor: const Color(0xFF1B2838),
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal, // Use normal title bar so window can be dragged
    fullScreen: startFullscreen, // Use preference
  );
  
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  
  runApp(ModularApp(module: AppModule(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GamepadNavigationScope(
      child: MaterialApp.router(
        title: 'RetroGate',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: Modular.routerConfig,
      ),
    );
  }
}
