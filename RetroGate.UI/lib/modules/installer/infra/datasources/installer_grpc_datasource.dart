import 'package:grpc/grpc.dart';
import '../../../../generated/installer/proto/v1/installer_service.pbgrpc.dart';
import '../../../../generated/installer/proto/v1/installer_event_model.pb.dart';
import '../../../../generated/google/protobuf/empty.pb.dart';

class InstallerGrpcDataSource {
  final ClientChannel channel;
  late final InstallerServiceClient _client;

  InstallerGrpcDataSource({
    required String host,
    required int port,
  }) : channel = ClientChannel(
          host,
          port: port,
          options: const ChannelOptions(
            credentials: ChannelCredentials.insecure(),
          ),
        ) {
    _client = InstallerServiceClient(channel);
  }

  /// Install a game
  Future<String> install({
    required String gameId,
    bool replace = false,
    bool restartSteam = false,
  }) async {
    try {
      final request = InstallRequest()
        ..gameId = gameId
        ..replace = replace
        ..restartSteam = restartSteam;

      final response = await _client.install(request);
      return response.installPath;
    } catch (e) {
      throw Exception('Failed to install game: $e');
    }
  }

  /// Delete game files
  Future<void> delete(List<String> paths) async {
    try {
      final request = DeleteRequest()..paths.addAll(paths);
      await _client.delete(request);
    } catch (e) {
      throw Exception('Failed to delete game: $e');
    }
  }

  /// Cancel installation
  Future<void> cancel(String id) async {
    try {
      final request = CancelRequest()..id = id;
      await _client.cancel(request);
    } catch (e) {
      throw Exception('Failed to cancel installation: $e');
    }
  }

  /// Subscribe to installation events (stream)
  Stream<InstallerEventModel> subscribeEvents() {
    try {
      final request = Empty();
      return _client.subscribeEvents(request);
    } catch (e) {
      throw Exception('Failed to subscribe to installer events: $e');
    }
  }

  /// Dispose resources
  Future<void> dispose() async {
    await channel.shutdown();
  }
}
