//
//  Generated code. Do not modify.
//  source: shortcut/proto/v1/shortcut_service.proto
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
import 'shortcut_service.pb.dart' as $1;

export 'shortcut_service.pb.dart';

@$pb.GrpcServiceName('shortcut.proto.v1.ShortcutService')
class ShortcutServiceClient extends $grpc.Client {
  static final _$getAll = $grpc.ClientMethod<$0.Empty, $1.GetAllShortcutsResponse>(
      '/shortcut.proto.v1.ShortcutService/GetAll',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.GetAllShortcutsResponse.fromBuffer(value));
  static final _$create = $grpc.ClientMethod<$1.CreateRequest, $1.CreateResponse>(
      '/shortcut.proto.v1.ShortcutService/Create',
      ($1.CreateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.CreateResponse.fromBuffer(value));

  ShortcutServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$1.GetAllShortcutsResponse> getAll($0.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAll, request, options: options);
  }

  $grpc.ResponseFuture<$1.CreateResponse> create($1.CreateRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$create, request, options: options);
  }
}

@$pb.GrpcServiceName('shortcut.proto.v1.ShortcutService')
abstract class ShortcutServiceBase extends $grpc.Service {
  $core.String get $name => 'shortcut.proto.v1.ShortcutService';

  ShortcutServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.GetAllShortcutsResponse>(
        'GetAll',
        getAll_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.GetAllShortcutsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CreateRequest, $1.CreateResponse>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.CreateRequest.fromBuffer(value),
        ($1.CreateResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.GetAllShortcutsResponse> getAll_Pre($grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getAll(call, await request);
  }

  $async.Future<$1.CreateResponse> create_Pre($grpc.ServiceCall call, $async.Future<$1.CreateRequest> request) async {
    return create(call, await request);
  }

  $async.Future<$1.GetAllShortcutsResponse> getAll($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$1.CreateResponse> create($grpc.ServiceCall call, $1.CreateRequest request);
}
