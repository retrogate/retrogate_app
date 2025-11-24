import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../core/widgets/gamepad_navigation_scope.dart';
import '../../../core/widgets/app_drawer.dart';
import 'bloc/config_bloc.dart';
import 'bloc/config_event.dart';
import 'bloc/config_state.dart';
import '../domain/models/config.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _steamPathController = TextEditingController();
  final _steamUserIdController = TextEditingController();
  final _steamGridDbApiKeyController = TextEditingController();
  
  bool _hasRegisteredActions = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ConfigBloc>(context).add(LoadConfig());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF1B2838),
      appBar: AppBar(
        backgroundColor: const Color(0xFF171A21),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF66C0F4),
        ),
      ),
      drawer: const AppDrawer(currentRoute: '/config/'),
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

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'RetroGate Configuration',
                    style: TextStyle(
                      color: Color(0xFF66C0F4),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Configure your Steam and SteamGridDB settings',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 32),
                  
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
                        disabledBackgroundColor: const Color(0xFF66C0F4).withOpacity(0.5),
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
        },
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
