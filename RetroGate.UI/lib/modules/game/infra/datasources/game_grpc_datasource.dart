import 'package:grpc/grpc.dart';
import '../../../../generated/game/proto/v1/game_service.pbgrpc.dart';
import '../../../../generated/game/proto/v1/game_model.pb.dart';
import '../../../../generated/game/proto/v1/game_images_model.pb.dart';

class GameGrpcDataSource {
  final ClientChannel channel;
  late final GameServiceClient _client;

  GameGrpcDataSource({
    required String host,
    required int port,
  }) : channel = ClientChannel(
          host,
          port: port,
          options: const ChannelOptions(
            credentials: ChannelCredentials.insecure(),
          ),
        ) {
    _client = GameServiceClient(channel);
  }

  Future<List<GameModel>> getAll(GameSource source) async {
    try {
      var request = GetAllRequest(source: source);
      final response = await _client.getAll(request);
      return response.games;
    } catch (e) {
      throw Exception('Failed to get games: $e');
    }
  }

  Future<GameModel> getById(GameSource source, String id) async {
    try {
      final request = GetByIdRequest()
        ..source = source
        ..id = id;
      return await _client.getById(request);
    } catch (e) {
      throw Exception('Failed to get game by id: $e');
    }
  }

  Future<List<GameModel>> findByName(GameSource source, String name) async {
    try {
      final request = FindByNameRequest()
        ..source = source
        ..name = name;
      final response = await _client.findByName(request);
      return response.games;
    } catch (e) {
      throw Exception('Failed to find games by name: $e');
    }
  }

  Future<GameImagesModel> getImages(String gameName) async {
    try {
      final request = GetImagesRequest()..gameName = gameName;
      return await _client.getImages(request);
    } catch (e) {
      throw Exception('Failed to get game images: $e');
    }
  }

  Future<GameModel> create(GameSource source, GameModel game) async {
    try {
      final request = CreateGameRequest()
        ..source = source
        ..game = game;
      return await _client.create(request);
    } catch (e) {
      throw Exception('Failed to create game: $e');
    }
  }

  Future<GameModel> update(GameSource source, GameModel game) async {
    try {
      final request = UpdateGameRequest()
        ..source = source
        ..game = game;
      return await _client.update(request);
    } catch (e) {
      throw Exception('Failed to update game: $e');
    }
  }

  Future<void> delete(GameSource source, String id) async {
    try {
      final request = GetByIdRequest()
        ..source = source
        ..id = id;
      await _client.delete(request);
    } catch (e) {
      throw Exception('Failed to delete game: $e');
    }
  }

  Future<void> launchGame(String id) async {
    try {
      final request = LaunchGameRequest()..gameId = id;
      await _client.launchGame(request);
    } catch (e) {
      throw Exception('Failed to launch game: $e');
    }
  }

  void dispose() {
    channel.shutdown();
  }
}
