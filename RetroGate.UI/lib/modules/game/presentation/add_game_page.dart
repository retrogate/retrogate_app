import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../core/widgets/gamepad_navigation_scope.dart';
import '../../../core/widgets/gamepad_focusable.dart';
import '../../../core/widgets/app_drawer.dart';
import '../domain/models/game.dart';
import 'bloc/games_bloc.dart';
import 'bloc/games_event.dart';
import 'bloc/games_state.dart';

class AddGamePage extends StatefulWidget {
  const AddGamePage({super.key});

  @override
  State<AddGamePage> createState() => _AddGamePageState();
}

class _AddGamePageState extends State<AddGamePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _executablePathController = TextEditingController();
  final _downloadUrlController = TextEditingController();
  final _settingsFileController = TextEditingController();
  
  bool _hasRegisteredActions = false;
  bool _gameJustCreated = false;
  String? _heroImageUrl;
  String? _posterImageUrl;
  String? _logoImageUrl;

  late final GamesBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = Modular.get<GamesBloc>();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _executablePathController.dispose();
    _downloadUrlController.dispose();
    _settingsFileController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
      
      // Back button goes back
      GamepadNavigationScope.registerBackAction(
        context,
        () {
          Navigator.of(context).pop();
        },
      );
      _hasRegisteredActions = true;
    }
  }

  void _handleCreateGame() {
    if (_formKey.currentState!.validate()) {
      final settingsFile = _settingsFileController.text.trim();
      
      final game = Game(
        id: '', // Server will generate ID
        name: _nameController.text,
        executablePath: _executablePathController.text,
        downloadUrl: _downloadUrlController.text,
        imageHeroUrl: _heroImageUrl ?? '',
        imagePosterUrl: _posterImageUrl ?? '',
        imageLogoUrl: _logoImageUrl ?? '',
        installationMethod: GameInstallationMethod.extract,
        settingsFile: settingsFile.isEmpty ? null : settingsFile,
      );

      _bloc.add(CreateGameEvent(game));
    }
  }

  void _loadImagePreview() {
    if (_nameController.text.isNotEmpty) {
      _bloc.add(LoadGameImagesEvent(_nameController.text));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a game name first'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF1B2838),
      drawer: const AppDrawer(currentRoute: '/games/add'),
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
      body: BlocConsumer<GamesBloc, GamesState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is GameCreatedState) {
            // Mark that we just created a game
            _gameJustCreated = true;
            // Reload games list
            _bloc.add(const LoadGamesEvent());
          } else if (state is GamesLoadedState && _gameJustCreated) {
            // Games reloaded after creation - now we can go back
            _gameJustCreated = false;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Game created successfully!'),
                backgroundColor: Color(0xFF66C0F4),
                duration: Duration(seconds: 2),
              ),
            );
            Navigator.of(context).pop();
          } else if (state is GameImagesLoadedState) {
            setState(() {
              _heroImageUrl = state.images.heroUrl;
              _posterImageUrl = state.images.posterUrl;
              _logoImageUrl = state.images.logoUrl;
            });
          }
        },
        builder: (context, state) {
          final isLoading = state is GameCreatingState || state is GameImagesLoadingState;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title Section
                  Row(
                    children: [
                      const Icon(
                        Icons.add_circle,
                        color: Color(0xFF66C0F4),
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'ADD GAME',
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
                    'Add a new game to the RetroGate catalog',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Name Field
                  TextFormField(
                    controller: _nameController,
                    enabled: !isLoading,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Game Name',
                      labelStyle: TextStyle(color: Color(0xFF66C0F4)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF66C0F4)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF66C0F4), width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a game name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Preview Images Button
                  GamepadFocusable(
                    onPressed: state is GameImagesLoadingState ? null : _loadImagePreview,
                    child: OutlinedButton.icon(
                      onPressed: state is GameImagesLoadingState ? null : _loadImagePreview,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF66C0F4),
                        side: const BorderSide(color: Color(0xFF66C0F4)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      icon: state is GameImagesLoadingState
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF66C0F4),
                                ),
                              ),
                            )
                          : const Icon(Icons.image_search),
                      label: Text(
                        state is GameImagesLoadingState
                            ? 'Loading Images...'
                            : 'Preview Images from SteamGridDB',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Executable Path Field
                  TextFormField(
                    controller: _executablePathController,
                    enabled: !isLoading,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Executable Path',
                      labelStyle: TextStyle(color: Color(0xFF66C0F4)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF66C0F4)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF66C0F4), width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the executable path';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Download URL Field
                  TextFormField(
                    controller: _downloadUrlController,
                    enabled: !isLoading,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Download URL',
                      labelStyle: TextStyle(color: Color(0xFF66C0F4)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF66C0F4)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF66C0F4), width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the download URL';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Settings File Field (Optional)
                  TextFormField(
                    controller: _settingsFileController,
                    enabled: !isLoading,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Settings File (Optional)',
                      hintText: 'e.g., game.ini, config.cfg, settings.json',
                      hintStyle: TextStyle(color: Colors.white38),
                      labelStyle: TextStyle(color: Color(0xFF66C0F4)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF66C0F4)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF66C0F4), width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Image Preview Section
                  if (_heroImageUrl != null || _posterImageUrl != null || _logoImageUrl != null)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF171A21),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Images from SteamGridDB',
                            style: TextStyle(
                              color: Color(0xFF66C0F4),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (_heroImageUrl != null) ...[
                            const Text(
                              'Hero Image:',
                              style: TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(height: 4),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.network(
                                _heroImageUrl!,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 150,
                                    color: Colors.red.withOpacity(0.3),
                                    child: const Center(
                                      child: Text(
                                        'Failed to load image',
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                          if (_posterImageUrl != null) ...[
                            const Text(
                              'Poster Image:',
                              style: TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(height: 4),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.network(
                                _posterImageUrl!,
                                height: 200,
                                width: 150,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 200,
                                    width: 150,
                                    color: Colors.red.withOpacity(0.3),
                                    child: const Center(
                                      child: Text(
                                        'Failed to load image',
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                          if (_logoImageUrl != null) ...[
                            const Text(
                              'Logo Image:',
                              style: TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(height: 4),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.network(
                                _logoImageUrl!,
                                height: 100,
                                width: 200,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 100,
                                    width: 200,
                                    color: Colors.red.withOpacity(0.3),
                                    child: const Center(
                                      child: Text(
                                        'Failed to load image',
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  
                  if (state is GameImagesLoadingState)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(
                              color: Color(0xFF66C0F4),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Loading images from SteamGridDB...',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ),
                  
                  const SizedBox(height: 24),

                  // Submit Button
                  GamepadFocusable(
                    onPressed: isLoading ? null : _handleCreateGame,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _handleCreateGame,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF66C0F4),
                        foregroundColor: const Color(0xFF171A21),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF171A21),
                                ),
                              ),
                            )
                          : const Text(
                              'Add Game',
                              style: TextStyle(
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
}
