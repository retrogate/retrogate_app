import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:window_manager/window_manager.dart';
import '../../../core/widgets/gamepad_navigation_scope.dart';
import '../../../core/widgets/app_drawer.dart';
import '../../../core/preferences/app_preferences.dart';
import 'bloc/config_bloc.dart';
import 'bloc/config_event.dart';
import 'bloc/config_state.dart';
import '../domain/models/config.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _steamPathController = TextEditingController();
  final _steamUserIdController = TextEditingController();
  final _steamGridDbApiKeyController = TextEditingController();
  
  late TabController _tabController;
  bool _hasRegisteredActions = false;
  
  // App preferences state
  bool _fullscreenEnabled = true;
  bool _gamepadEnabled = true;
  bool _gamepadVibration = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    BlocProvider.of<ConfigBloc>(context).add(LoadConfig());
    _loadAppPreferences();
  }
  
  void _loadAppPreferences() {
    setState(() {
      _fullscreenEnabled = AppPreferences.isFullscreenEnabled();
      _gamepadEnabled = AppPreferences.isGamepadEnabled();
      _gamepadVibration = AppPreferences.isGamepadVibrationEnabled();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // Register gamepad actions only once
    if (!_hasRegisteredActions) {
      // Menu button toggles drawer
      GamepadNavigationScope.registerMenuAction(context, () {
        final scaffoldState = _scaffoldKey.currentState;
        if (scaffoldState != null) {
          if (scaffoldState.isDrawerOpen) {
            Navigator.of(context).pop(); // Close drawer
          } else {
            scaffoldState.openDrawer(); // Open drawer
          }
        }
      });
      
      // Back button goes to games
      GamepadNavigationScope.registerBackAction(context, () {
        Modular.to.navigate('/games/');
      });
      
      _hasRegisteredActions = true;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _steamPathController.dispose();
    _steamUserIdController.dispose();
    _steamGridDbApiKeyController.dispose();
    super.dispose();
  }

  void _saveConfig() {
    if (_formKey.currentState!.validate()) {
      final config = Config(
        steamPath: _steamPathController.text,
        steamUserId: _steamUserIdController.text,
        steamGridDbApiKey: _steamGridDbApiKeyController.text,
      );

      BlocProvider.of<ConfigBloc>(context).add(SaveConfig(config));
    }
  }
  
  Future<void> _toggleFullscreen(bool value) async {
    setState(() {
      _fullscreenEnabled = value;
    });
    await AppPreferences.setFullscreenEnabled(value);
    await windowManager.setFullScreen(value);
  }
  
  Future<void> _setGamepadEnabled(bool value) async {
    setState(() {
      _gamepadEnabled = value;
    });
    await AppPreferences.setGamepadEnabled(value);
  }
  
  Future<void> _setGamepadVibration(bool value) async {
    setState(() {
      _gamepadVibration = value;
    });
    await AppPreferences.setGamepadVibrationEnabled(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF1B2838),
      drawer: const AppDrawer(currentRoute: '/config/'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final scaffoldState = _scaffoldKey.currentState;
          if (scaffoldState != null) {
            if (scaffoldState.isDrawerOpen) {
              Navigator.of(context).pop();
            } else {
              scaffoldState.openDrawer();
            }
          }
        },
        backgroundColor: const Color(0xFF66C0F4),
        tooltip: 'Menu',
        child: const Icon(Icons.menu, color: Color(0xFF171A21)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: BlocConsumer<ConfigBloc, ConfigState>(
        listener: (context, state) {
          if (state is ConfigSaved) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Configuration saved successfully!'),
                backgroundColor: Color(0xFF66C0F4),
              ),
            );
          } else if (state is ConfigError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ConfigLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF66C0F4),
              ),
            );
          }

          if (state is ConfigLoaded || state is ConfigSaved) {
            final config = state is ConfigLoaded ? state.config : (state as ConfigSaved).config;
            
            // Update controllers with loaded data
            if (_steamPathController.text.isEmpty) {
              _steamPathController.text = config.steamPath;
              _steamUserIdController.text = config.steamUserId;
              _steamGridDbApiKeyController.text = config.steamGridDbApiKey;
            }
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.settings,
                          color: Color(0xFF66C0F4),
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'SETTINGS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Configure your Steam, SteamGridDB and application settings',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Tab Bar
              TabBar(
                controller: _tabController,
                indicatorColor: const Color(0xFF66C0F4),
                labelColor: const Color(0xFF66C0F4),
                unselectedLabelColor: Colors.white70,
                tabs: const [
                  Tab(text: 'Server'),
                  Tab(text: 'Application'),
                ],
              ),
              
              // Tab Bar View
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildServerSettings(state),
                    _buildAppSettings(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  
  Widget _buildServerSettings(ConfigState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Steam Path
            _buildTextField(
              controller: _steamPathController,
              label: 'Steam Path',
              hint: 'C:\\Program Files (x86)\\Steam',
              icon: Icons.folder,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Steam path';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            
            // Steam User ID
            _buildTextField(
              controller: _steamUserIdController,
              label: 'Steam User ID',
              hint: '1234567890',
              icon: Icons.person,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Steam User ID';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            
            // SteamGridDB API Key
            _buildTextField(
              controller: _steamGridDbApiKeyController,
              label: 'SteamGridDB API Key',
              hint: 'Get your key from steamgriddb.com',
              icon: Icons.key,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter SteamGridDB API Key';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),
            
            // Save Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: state is ConfigSaving ? null : _saveConfig,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF66C0F4),
                  disabledBackgroundColor: const Color(0xFF66C0F4).withValues(alpha: 0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: state is ConfigSaving
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Save Configuration',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildAppSettings() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display Section
          const Text(
            'Display',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildSettingTile(
            icon: Icons.fullscreen,
            title: 'Fullscreen',
            subtitle: 'Launch application in fullscreen mode',
            value: _fullscreenEnabled,
            onChanged: _toggleFullscreen,
          ),
          const SizedBox(height: 24),
          
          // Gamepad Section
          const Text(
            'Gamepad',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildSettingTile(
            icon: Icons.gamepad,
            title: 'Gamepad Navigation',
            subtitle: 'Enable gamepad support',
            value: _gamepadEnabled,
            onChanged: _setGamepadEnabled,
          ),
          const SizedBox(height: 12),
          _buildSettingTile(
            icon: Icons.vibration,
            title: 'Gamepad Vibration',
            subtitle: 'Enable vibration feedback',
            value: _gamepadVibration,
            onChanged: _setGamepadVibration,
          ),
          const SizedBox(height: 32),
          
          // Info Box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF171A21),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: const Color(0xFF66C0F4).withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: Color(0xFF66C0F4),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tip',
                        style: TextStyle(
                          color: Color(0xFF66C0F4),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Press F11 anytime to toggle fullscreen mode',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF171A21),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFF2A475E), width: 1),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF66C0F4),
            size: 28,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: const Color(0xFF66C0F4),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white38),
            prefixIcon: Icon(icon, color: const Color(0xFF66C0F4)),
            filled: true,
            fillColor: const Color(0xFF171A21),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFF2A475E), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFF66C0F4), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
