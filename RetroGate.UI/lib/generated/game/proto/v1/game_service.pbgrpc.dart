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
import 'game_model.pb.dart' as $1;
import 'game_service.pb.dart' as $0;

export 'game_service.pb.dart';

@$pb.GrpcServiceName('game.proto.v1.GameService')
class GameServiceClient extends $grpc.Client {
  static final _$create = $grpc.ClientMethod<$0.CreateGameRequest, $1.GameModel>(
      '/game.proto.v1.GameService/Create',
      ($0.CreateGameRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.GameModel.fromBuffer(value));
  static final _$getById = $grpc.ClientMethod<$0.GetByIdRequest, $1.GameModel>(
      '/game.proto.v1.GameService/GetById',
      ($0.GetByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.GameModel.fromBuffer(value));
  static final _$getAll = $grpc.ClientMethod<$0.GetAllRequest, $0.GetAllResponse>(
      '/game.proto.v1.GameService/GetAll',
      ($0.GetAllRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetAllResponse.fromBuffer(value));
  static final _$findByName = $grpc.ClientMethod<$0.FindByNameRequest, $0.FindByNameResponse>(
      '/game.proto.v1.GameService/FindByName',
      ($0.FindByNameRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.FindByNameResponse.fromBuffer(value));
  static final _$update = $grpc.ClientMethod<$0.UpdateGameRequest, $1.GameModel>(
      '/game.proto.v1.GameService/Update',
      ($0.UpdateGameRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.GameModel.fromBuffer(value));
  static final _$delete = $grpc.ClientMethod<$0.GetByIdRequest, $2.Empty>(
      '/game.proto.v1.GameService/Delete',
      ($0.GetByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));
  static final _$getImages = $grpc.ClientMethod<$0.GetImagesRequest, $3.GameImagesModel>(
      '/game.proto.v1.GameService/GetImages',
      ($0.GetImagesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.GameImagesModel.fromBuffer(value));
  static final _$findInstalledGames = $grpc.ClientMethod<$2.Empty, $0.GetAllResponse>(
      '/game.proto.v1.GameService/FindInstalledGames',
      ($2.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetAllResponse.fromBuffer(value));
  static final _$launchGame = $grpc.ClientMethod<$0.LaunchGameRequest, $2.Empty>(
      '/game.proto.v1.GameService/LaunchGame',
      ($0.LaunchGameRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));

  GameServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$1.GameModel> create($0.CreateGameRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$1.GameModel> getById($0.GetByIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getById, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAllResponse> getAll($0.GetAllRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAll, request, options: options);
  }

  $grpc.ResponseFuture<$0.FindByNameResponse> findByName($0.FindByNameRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$findByName, request, options: options);
  }

  $grpc.ResponseFuture<$1.GameModel> update($0.UpdateGameRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$update, request, options: options);
  }

  $grpc.ResponseFuture<$2.Empty> delete($0.GetByIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$delete, request, options: options);
  }

  $grpc.ResponseFuture<$3.GameImagesModel> getImages($0.GetImagesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getImages, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAllResponse> findInstalledGames($2.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$findInstalledGames, request, options: options);
  }

  $grpc.ResponseFuture<$2.Empty> launchGame($0.LaunchGameRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$launchGame, request, options: options);
  }
}

@$pb.GrpcServiceName('game.proto.v1.GameService')
abstract class GameServiceBase extends $grpc.Service {
  $core.String get $name => 'game.proto.v1.GameService';

  GameServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateGameRequest, $1.GameModel>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateGameRequest.fromBuffer(value),
        ($1.GameModel value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetByIdRequest, $1.GameModel>(
        'GetById',
        getById_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetByIdRequest.fromBuffer(value),
        ($1.GameModel value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAllRequest, $0.GetAllResponse>(
        'GetAll',
        getAll_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetAllRequest.fromBuffer(value),
        ($0.GetAllResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.FindByNameRequest, $0.FindByNameResponse>(
        'FindByName',
        findByName_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.FindByNameRequest.fromBuffer(value),
        ($0.FindByNameResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateGameRequest, $1.GameModel>(
        'Update',
        update_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateGameRequest.fromBuffer(value),
        ($1.GameModel value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetByIdRequest, $2.Empty>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetByIdRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetImagesRequest, $3.GameImagesModel>(
        'GetImages',
        getImages_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetImagesRequest.fromBuffer(value),
        ($3.GameImagesModel value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.Empty, $0.GetAllResponse>(
        'FindInstalledGames',
        findInstalledGames_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.Empty.fromBuffer(value),
        ($0.GetAllResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LaunchGameRequest, $2.Empty>(
        'LaunchGame',
        launchGame_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LaunchGameRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$1.GameModel> create_Pre($grpc.ServiceCall call, $async.Future<$0.CreateGameRequest> request) async {
    return create(call, await request);
  }

  $async.Future<$1.GameModel> getById_Pre($grpc.ServiceCall call, $async.Future<$0.GetByIdRequest> request) async {
    return getById(call, await request);
  }

  $async.Future<$0.GetAllResponse> getAll_Pre($grpc.ServiceCall call, $async.Future<$0.GetAllRequest> request) async {
    return getAll(call, await request);
  }

  $async.Future<$0.FindByNameResponse> findByName_Pre($grpc.ServiceCall call, $async.Future<$0.FindByNameRequest> request) async {
    return findByName(call, await request);
  }

  $async.Future<$1.GameModel> update_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateGameRequest> request) async {
    return update(call, await request);
  }

  $async.Future<$2.Empty> delete_Pre($grpc.ServiceCall call, $async.Future<$0.GetByIdRequest> request) async {
    return delete(call, await request);
  }

  $async.Future<$3.GameImagesModel> getImages_Pre($grpc.ServiceCall call, $async.Future<$0.GetImagesRequest> request) async {
    return getImages(call, await request);
  }

  $async.Future<$0.GetAllResponse> findInstalledGames_Pre($grpc.ServiceCall call, $async.Future<$2.Empty> request) async {
    return findInstalledGames(call, await request);
  }

  $async.Future<$2.Empty> launchGame_Pre($grpc.ServiceCall call, $async.Future<$0.LaunchGameRequest> request) async {
    return launchGame(call, await request);
  }

  $async.Future<$1.GameModel> create($grpc.ServiceCall call, $0.CreateGameRequest request);
  $async.Future<$1.GameModel> getById($grpc.ServiceCall call, $0.GetByIdRequest request);
  $async.Future<$0.GetAllResponse> getAll($grpc.ServiceCall call, $0.GetAllRequest request);
  $async.Future<$0.FindByNameResponse> findByName($grpc.ServiceCall call, $0.FindByNameRequest request);
  $async.Future<$1.GameModel> update($grpc.ServiceCall call, $0.UpdateGameRequest request);
  $async.Future<$2.Empty> delete($grpc.ServiceCall call, $0.GetByIdRequest request);
  $async.Future<$3.GameImagesModel> getImages($grpc.ServiceCall call, $0.GetImagesRequest request);
  $async.Future<$0.GetAllResponse> findInstalledGames($grpc.ServiceCall call, $2.Empty request);
  $async.Future<$2.Empty> launchGame($grpc.ServiceCall call, $0.LaunchGameRequest request);
}
