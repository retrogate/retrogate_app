import 'package:shared_preferences/shared_preferences.dart';
import 'app_preferences_keys.dart';

/// Singleton wrapper for SharedPreferences
/// Manages all app-specific local preferences
class AppPreferences {
  static SharedPreferences? _prefs;

  // Private constructor
  AppPreferences._();

  /// Initialize SharedPreferences
  /// Must be called before using any other methods
  static Future<void> initialize() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Ensure preferences are initialized
  static SharedPreferences get _instance {
    if (_prefs == null) {
      throw StateError(
        'AppPreferences not initialized. Call AppPreferences.initialize() first.',
      );
    }
    return _prefs!;
  }

  // ==================== Display Settings ====================

  /// Get fullscreen enabled preference
  static bool isFullscreenEnabled() {
    return _instance.getBool(AppPreferencesKeys.fullscreenEnabled) ??
        AppPreferencesKeys.defaultFullscreenEnabled;
  }

  /// Set fullscreen enabled preference
  static Future<bool> setFullscreenEnabled(bool enabled) {
    return _instance.setBool(AppPreferencesKeys.fullscreenEnabled, enabled);
  }

  /// Get window width
  static double getWindowWidth() {
    return _instance.getDouble(AppPreferencesKeys.windowWidth) ??
        AppPreferencesKeys.defaultWindowWidth;
  }

  /// Set window width
  static Future<bool> setWindowWidth(double width) {
    return _instance.setDouble(AppPreferencesKeys.windowWidth, width);
  }

  /// Get window height
  static double getWindowHeight() {
    return _instance.getDouble(AppPreferencesKeys.windowHeight) ??
        AppPreferencesKeys.defaultWindowHeight;
  }

  /// Set window height
  static Future<bool> setWindowHeight(double height) {
    return _instance.setDouble(AppPreferencesKeys.windowHeight, height);
  }

  // ==================== UI Settings ====================

  /// Get theme preference
  static String getTheme() {
    return _instance.getString(AppPreferencesKeys.theme) ??
        AppPreferencesKeys.defaultTheme;
  }

  /// Set theme preference
  static Future<bool> setTheme(String theme) {
    return _instance.setString(AppPreferencesKeys.theme, theme);
  }

  /// Get language preference
  static String getLanguage() {
    return _instance.getString(AppPreferencesKeys.language) ??
        AppPreferencesKeys.defaultLanguage;
  }

  /// Set language preference
  static Future<bool> setLanguage(String language) {
    return _instance.setString(AppPreferencesKeys.language, language);
  }

  // ==================== Gamepad Settings ====================

  /// Get gamepad enabled preference
  static bool isGamepadEnabled() {
    return _instance.getBool(AppPreferencesKeys.gamepadEnabled) ??
        AppPreferencesKeys.defaultGamepadEnabled;
  }

  /// Set gamepad enabled preference
  static Future<bool> setGamepadEnabled(bool enabled) {
    return _instance.setBool(AppPreferencesKeys.gamepadEnabled, enabled);
  }

  /// Get gamepad vibration preference
  static bool isGamepadVibrationEnabled() {
    return _instance.getBool(AppPreferencesKeys.gamepadVibration) ??
        AppPreferencesKeys.defaultGamepadVibration;
  }

  /// Set gamepad vibration preference
  static Future<bool> setGamepadVibrationEnabled(bool enabled) {
    return _instance.setBool(AppPreferencesKeys.gamepadVibration, enabled);
  }

  // ==================== Utility Methods ====================

  /// Clear all preferences
  static Future<bool> clearAll() {
    return _instance.clear();
  }

  /// Remove a specific preference
  static Future<bool> remove(String key) {
    return _instance.remove(key);
  }
}
