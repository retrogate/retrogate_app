//
//  Generated code. Do not modify.
//  source: game/proto/v1/game_service.proto
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

import '../../../google/protobuf/empty.pb.dart' as $2;
import 'game_images_model.pb.dart' as $3;
import 'game_model.pb.dart' as $0;
import 'game_service.pb.dart' as $1;

export 'game_service.pb.dart';

@$pb.GrpcServiceName('game.proto.v1.GameService')
class GameServiceClient extends $grpc.Client {
  static final _$create = $grpc.ClientMethod<$0.GameModel, $0.GameModel>(
      '/game.proto.v1.GameService/Create',
      ($0.GameModel value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GameModel.fromBuffer(value));
  static final _$getById = $grpc.ClientMethod<$1.GetByIdRequest, $0.GameModel>(
      '/game.proto.v1.GameService/GetById',
      ($1.GetByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GameModel.fromBuffer(value));
  static final _$getAll = $grpc.ClientMethod<$2.Empty, $1.GetAllResponse>(
      '/game.proto.v1.GameService/GetAll',
      ($2.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.GetAllResponse.fromBuffer(value));
  static final _$findByName = $grpc.ClientMethod<$1.FindByNameRequest, $1.FindByNameResponse>(
      '/game.proto.v1.GameService/FindByName',
      ($1.FindByNameRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.FindByNameResponse.fromBuffer(value));
  static final _$update = $grpc.ClientMethod<$0.GameModel, $0.GameModel>(
      '/game.proto.v1.GameService/Update',
      ($0.GameModel value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GameModel.fromBuffer(value));
  static final _$delete = $grpc.ClientMethod<$1.GetByIdRequest, $2.Empty>(
      '/game.proto.v1.GameService/Delete',
      ($1.GetByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));
  static final _$getImages = $grpc.ClientMethod<$1.GetImagesRequest, $3.GameImagesModel>(
      '/game.proto.v1.GameService/GetImages',
      ($1.GetImagesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.GameImagesModel.fromBuffer(value));

  GameServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.GameModel> create($0.GameModel request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$0.GameModel> getById($1.GetByIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getById, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetAllResponse> getAll($2.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAll, request, options: options);
  }

  $grpc.ResponseFuture<$1.FindByNameResponse> findByName($1.FindByNameRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$findByName, request, options: options);
  }

  $grpc.ResponseFuture<$0.GameModel> update($0.GameModel request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$update, request, options: options);
  }

  $grpc.ResponseFuture<$2.Empty> delete($1.GetByIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$delete, request, options: options);
  }

  $grpc.ResponseFuture<$3.GameImagesModel> getImages($1.GetImagesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getImages, request, options: options);
  }
}

@$pb.GrpcServiceName('game.proto.v1.GameService')
abstract class GameServiceBase extends $grpc.Service {
  $core.String get $name => 'game.proto.v1.GameService';

  GameServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GameModel, $0.GameModel>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GameModel.fromBuffer(value),
        ($0.GameModel value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetByIdRequest, $0.GameModel>(
        'GetById',
        getById_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetByIdRequest.fromBuffer(value),
        ($0.GameModel value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.Empty, $1.GetAllResponse>(
        'GetAll',
        getAll_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.Empty.fromBuffer(value),
        ($1.GetAllResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.FindByNameRequest, $1.FindByNameResponse>(
        'FindByName',
        findByName_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.FindByNameRequest.fromBuffer(value),
        ($1.FindByNameResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GameModel, $0.GameModel>(
        'Update',
        update_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GameModel.fromBuffer(value),
        ($0.GameModel value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetByIdRequest, $2.Empty>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetByIdRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetImagesRequest, $3.GameImagesModel>(
        'GetImages',
        getImages_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetImagesRequest.fromBuffer(value),
        ($3.GameImagesModel value) => value.writeToBuffer()));
  }

  $async.Future<$0.GameModel> create_Pre($grpc.ServiceCall call, $async.Future<$0.GameModel> request) async {
    return create(call, await request);
  }

  $async.Future<$0.GameModel> getById_Pre($grpc.ServiceCall call, $async.Future<$1.GetByIdRequest> request) async {
    return getById(call, await request);
  }

  $async.Future<$1.GetAllResponse> getAll_Pre($grpc.ServiceCall call, $async.Future<$2.Empty> request) async {
    return getAll(call, await request);
  }

  $async.Future<$1.FindByNameResponse> findByName_Pre($grpc.ServiceCall call, $async.Future<$1.FindByNameRequest> request) async {
    return findByName(call, await request);
  }

  $async.Future<$0.GameModel> update_Pre($grpc.ServiceCall call, $async.Future<$0.GameModel> request) async {
    return update(call, await request);
  }

  $async.Future<$2.Empty> delete_Pre($grpc.ServiceCall call, $async.Future<$1.GetByIdRequest> request) async {
    return delete(call, await request);
  }

  $async.Future<$3.GameImagesModel> getImages_Pre($grpc.ServiceCall call, $async.Future<$1.GetImagesRequest> request) async {
    return getImages(call, await request);
  }

  $async.Future<$0.GameModel> create($grpc.ServiceCall call, $0.GameModel request);
  $async.Future<$0.GameModel> getById($grpc.ServiceCall call, $1.GetByIdRequest request);
  $async.Future<$1.GetAllResponse> getAll($grpc.ServiceCall call, $2.Empty request);
  $async.Future<$1.FindByNameResponse> findByName($grpc.ServiceCall call, $1.FindByNameRequest request);
  $async.Future<$0.GameModel> update($grpc.ServiceCall call, $0.GameModel request);
  $async.Future<$2.Empty> delete($grpc.ServiceCall call, $1.GetByIdRequest request);
  $async.Future<$3.GameImagesModel> getImages($grpc.ServiceCall call, $1.GetImagesRequest request);
}
