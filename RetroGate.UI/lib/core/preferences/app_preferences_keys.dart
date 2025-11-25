/// Keys for SharedPreferences storage
class AppPreferencesKeys {
  // Prevent instantiation
  AppPreferencesKeys._();

  // Display preferences
  static const String fullscreenEnabled = 'fullscreen_enabled';
  static const String windowWidth = 'window_width';
  static const String windowHeight = 'window_height';
  
  // UI preferences
  static const String theme = 'theme';
  static const String language = 'language';
  
  // Gamepad preferences
  static const String gamepadEnabled = 'gamepad_enabled';
  static const String gamepadVibration = 'gamepad_vibration';
  
  // Defaults
  static const bool defaultFullscreenEnabled = true;
  static const double defaultWindowWidth = 1280.0;
  static const double defaultWindowHeight = 720.0;
  static const String defaultTheme = 'dark';
  static const String defaultLanguage = 'en';
  static const bool defaultGamepadEnabled = true;
  static const bool defaultGamepadVibration = true;
}
