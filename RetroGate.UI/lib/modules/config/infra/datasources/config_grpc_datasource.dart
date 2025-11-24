import 'package:grpc/grpc.dart';
import '../../../../generated/config/proto/v1/config_model.pb.dart';
import '../../../../generated/config/proto/v1/config_service.pbgrpc.dart';
import '../../../../generated/google/protobuf/empty.pb.dart';

class ConfigGrpcDataSource {
  final ClientChannel channel;
  late final ConfigServiceClient _client;

  ConfigGrpcDataSource({
    required String host,
    required int port,
  }) : channel = ClientChannel(
          host,
          port: port,
          options: const ChannelOptions(
            credentials: ChannelCredentials.insecure(),
          ),
        ) {
    _client = ConfigServiceClient(channel);
  }

  Future<ConfigModel> getConfig() async {
    try {
      final response = await _client.getConfig(Empty());
      return response;
    } catch (e) {
      throw Exception('Failed to get config: $e');
    }
  }

  Future<void> setConfig(ConfigModel config) async {
    try {
      await _client.setConfig(config);
    } catch (e) {
      throw Exception('Failed to set config: $e');
    }
  }
}
