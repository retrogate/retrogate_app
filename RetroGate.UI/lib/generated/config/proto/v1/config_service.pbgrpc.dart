//
//  Generated code. Do not modify.
//  source: config/proto/v1/config_service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../../google/protobuf/empty.pb.dart' as $0;
import 'config_model.pb.dart' as $1;

export 'config_service.pb.dart';

@$pb.GrpcServiceName('config.proto.v1.ConfigService')
class ConfigServiceClient extends $grpc.Client {
  static final _$getConfig = $grpc.ClientMethod<$0.Empty, $1.ConfigModel>(
      '/config.proto.v1.ConfigService/GetConfig',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ConfigModel.fromBuffer(value));
  static final _$setConfig = $grpc.ClientMethod<$1.ConfigModel, $0.Empty>(
      '/config.proto.v1.ConfigService/SetConfig',
      ($1.ConfigModel value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));

  ConfigServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$1.ConfigModel> getConfig($0.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getConfig, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> setConfig($1.ConfigModel request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setConfig, request, options: options);
  }
}

@$pb.GrpcServiceName('config.proto.v1.ConfigService')
abstract class ConfigServiceBase extends $grpc.Service {
  $core.String get $name => 'config.proto.v1.ConfigService';

  ConfigServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.ConfigModel>(
        'GetConfig',
        getConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.ConfigModel value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ConfigModel, $0.Empty>(
        'SetConfig',
        setConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ConfigModel.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$1.ConfigModel> getConfig_Pre($grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getConfig(call, await request);
  }

  $async.Future<$0.Empty> setConfig_Pre($grpc.ServiceCall call, $async.Future<$1.ConfigModel> request) async {
    return setConfig(call, await request);
  }

  $async.Future<$1.ConfigModel> getConfig($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.Empty> setConfig($grpc.ServiceCall call, $1.ConfigModel request);
}
