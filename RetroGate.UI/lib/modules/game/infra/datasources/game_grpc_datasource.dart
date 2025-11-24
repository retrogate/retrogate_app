import 'package:grpc/grpc.dart';
import '../../../../generated/game/proto/v1/game_service.pbgrpc.dart';
import '../../../../generated/game/proto/v1/game_model.pb.dart';
import '../../../../generated/game/proto/v1/game_images_model.pb.dart';
import '../../../../generated/google/protobuf/empty.pb.dart';

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

  Future<List<GameModel>> getAll() async {
    try {
      final response = await _client.getAll(Empty());
      return response.games;
    } catch (e) {
      throw Exception('Failed to get games: $e');
    }
  }

  Future<GameModel> getById(String id) async {
    try {
      final request = GetByIdRequest()..id = id;
      return await _client.getById(request);
    } catch (e) {
      throw Exception('Failed to get game by id: $e');
    }
  }

  Future<List<GameModel>> findByName(String name) async {
    try {
      final request = FindByNameRequest()..name = name;
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

  Future<GameModel> create(GameModel game) async {
    try {
      return await _client.create(game);
    } catch (e) {
      throw Exception('Failed to create game: $e');
    }
  }

  Future<GameModel> update(GameModel game) async {
    try {
      return await _client.update(game);
    } catch (e) {
      throw Exception('Failed to update game: $e');
    }
  }

  Future<void> delete(String id) async {
    try {
      final request = GetByIdRequest()..id = id;
      await _client.delete(request);
    } catch (e) {
      throw Exception('Failed to delete game: $e');
    }
  }

  void dispose() {
    channel.shutdown();
  }
}
