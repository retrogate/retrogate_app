//
//  Generated code. Do not modify.
//  source: installer/proto/v1/installer_service.proto
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

import '../../../google/protobuf/empty.pb.dart' as $1;
import 'installer_event_model.pb.dart' as $2;
import 'installer_service.pb.dart' as $0;

export 'installer_service.pb.dart';

@$pb.GrpcServiceName('installer.proto.v1.InstallerService')
class InstallerServiceClient extends $grpc.Client {
  static final _$install = $grpc.ClientMethod<$0.InstallRequest, $0.InstallResponse>(
      '/installer.proto.v1.InstallerService/Install',
      ($0.InstallRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.InstallResponse.fromBuffer(value));
  static final _$uninstall = $grpc.ClientMethod<$0.UninstallRequest, $1.Empty>(
      '/installer.proto.v1.InstallerService/Uninstall',
      ($0.UninstallRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$cancel = $grpc.ClientMethod<$0.CancelRequest, $1.Empty>(
      '/installer.proto.v1.InstallerService/Cancel',
      ($0.CancelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$subscribeEvents = $grpc.ClientMethod<$1.Empty, $2.InstallerEventModel>(
      '/installer.proto.v1.InstallerService/SubscribeEvents',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.InstallerEventModel.fromBuffer(value));
  static final _$getPendingInstallations = $grpc.ClientMethod<$1.Empty, $0.GetPendingInstallationsResponse>(
      '/installer.proto.v1.InstallerService/GetPendingInstallations',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetPendingInstallationsResponse.fromBuffer(value));

  InstallerServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.InstallResponse> install($0.InstallRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$install, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> uninstall($0.UninstallRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uninstall, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> cancel($0.CancelRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancel, request, options: options);
  }

  $grpc.ResponseStream<$2.InstallerEventModel> subscribeEvents($1.Empty request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$subscribeEvents, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$0.GetPendingInstallationsResponse> getPendingInstallations($1.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPendingInstallations, request, options: options);
  }
}

@$pb.GrpcServiceName('installer.proto.v1.InstallerService')
abstract class InstallerServiceBase extends $grpc.Service {
  $core.String get $name => 'installer.proto.v1.InstallerService';

  InstallerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.InstallRequest, $0.InstallResponse>(
        'Install',
        install_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.InstallRequest.fromBuffer(value),
        ($0.InstallResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UninstallRequest, $1.Empty>(
        'Uninstall',
        uninstall_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UninstallRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelRequest, $1.Empty>(
        'Cancel',
        cancel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CancelRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $2.InstallerEventModel>(
        'SubscribeEvents',
        subscribeEvents_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($2.InstallerEventModel value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.GetPendingInstallationsResponse>(
        'GetPendingInstallations',
        getPendingInstallations_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.GetPendingInstallationsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.InstallResponse> install_Pre($grpc.ServiceCall call, $async.Future<$0.InstallRequest> request) async {
    return install(call, await request);
  }

  $async.Future<$1.Empty> uninstall_Pre($grpc.ServiceCall call, $async.Future<$0.UninstallRequest> request) async {
    return uninstall(call, await request);
  }

  $async.Future<$1.Empty> cancel_Pre($grpc.ServiceCall call, $async.Future<$0.CancelRequest> request) async {
    return cancel(call, await request);
  }

  $async.Stream<$2.InstallerEventModel> subscribeEvents_Pre($grpc.ServiceCall call, $async.Future<$1.Empty> request) async* {
    yield* subscribeEvents(call, await request);
  }

  $async.Future<$0.GetPendingInstallationsResponse> getPendingInstallations_Pre($grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return getPendingInstallations(call, await request);
  }

  $async.Future<$0.InstallResponse> install($grpc.ServiceCall call, $0.InstallRequest request);
  $async.Future<$1.Empty> uninstall($grpc.ServiceCall call, $0.UninstallRequest request);
  $async.Future<$1.Empty> cancel($grpc.ServiceCall call, $0.CancelRequest request);
  $async.Stream<$2.InstallerEventModel> subscribeEvents($grpc.ServiceCall call, $1.Empty request);
  $async.Future<$0.GetPendingInstallationsResponse> getPendingInstallations($grpc.ServiceCall call, $1.Empty request);
}
