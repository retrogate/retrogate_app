//
//  Generated code. Do not modify.
//  source: game/proto/v1/game_service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'game_model.pb.dart' as $0;

class GetByIdRequest extends $pb.GeneratedMessage {
  factory GetByIdRequest({
    $core.String? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  GetByIdRequest._() : super();
  factory GetByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetByIdRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'game.proto.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetByIdRequest clone() => GetByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetByIdRequest copyWith(void Function(GetByIdRequest) updates) => super.copyWith((message) => updates(message as GetByIdRequest)) as GetByIdRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetByIdRequest create() => GetByIdRequest._();
  GetByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetByIdRequest> createRepeated() => $pb.PbList<GetByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetByIdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetByIdRequest>(create);
  static GetByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class GetAllResponse extends $pb.GeneratedMessage {
  factory GetAllResponse({
    $core.Iterable<$0.GameModel>? games,
  }) {
    final $result = create();
    if (games != null) {
      $result.games.addAll(games);
    }
    return $result;
  }
  GetAllResponse._() : super();
  factory GetAllResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAllResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAllResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'game.proto.v1'), createEmptyInstance: create)
    ..pc<$0.GameModel>(1, _omitFieldNames ? '' : 'games', $pb.PbFieldType.PM, subBuilder: $0.GameModel.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAllResponse clone() => GetAllResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAllResponse copyWith(void Function(GetAllResponse) updates) => super.copyWith((message) => updates(message as GetAllResponse)) as GetAllResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAllResponse create() => GetAllResponse._();
  GetAllResponse createEmptyInstance() => create();
  static $pb.PbList<GetAllResponse> createRepeated() => $pb.PbList<GetAllResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAllResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAllResponse>(create);
  static GetAllResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$0.GameModel> get games => $_getList(0);
}

class FindByNameRequest extends $pb.GeneratedMessage {
  factory FindByNameRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  FindByNameRequest._() : super();
  factory FindByNameRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FindByNameRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FindByNameRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'game.proto.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FindByNameRequest clone() => FindByNameRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FindByNameRequest copyWith(void Function(FindByNameRequest) updates) => super.copyWith((message) => updates(message as FindByNameRequest)) as FindByNameRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FindByNameRequest create() => FindByNameRequest._();
  FindByNameRequest createEmptyInstance() => create();
  static $pb.PbList<FindByNameRequest> createRepeated() => $pb.PbList<FindByNameRequest>();
  @$core.pragma('dart2js:noInline')
  static FindByNameRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FindByNameRequest>(create);
  static FindByNameRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);
}

class FindByNameResponse extends $pb.GeneratedMessage {
  factory FindByNameResponse({
    $core.Iterable<$0.GameModel>? games,
  }) {
    final $result = create();
    if (games != null) {
      $result.games.addAll(games);
    }
    return $result;
  }
  FindByNameResponse._() : super();
  factory FindByNameResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FindByNameResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FindByNameResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'game.proto.v1'), createEmptyInstance: create)
    ..pc<$0.GameModel>(1, _omitFieldNames ? '' : 'games', $pb.PbFieldType.PM, subBuilder: $0.GameModel.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FindByNameResponse clone() => FindByNameResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FindByNameResponse copyWith(void Function(FindByNameResponse) updates) => super.copyWith((message) => updates(message as FindByNameResponse)) as FindByNameResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FindByNameResponse create() => FindByNameResponse._();
  FindByNameResponse createEmptyInstance() => create();
  static $pb.PbList<FindByNameResponse> createRepeated() => $pb.PbList<FindByNameResponse>();
  @$core.pragma('dart2js:noInline')
  static FindByNameResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FindByNameResponse>(create);
  static FindByNameResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$0.GameModel> get games => $_getList(0);
}

class GetImagesRequest extends $pb.GeneratedMessage {
  factory GetImagesRequest({
    $core.String? gameName,
  }) {
    final $result = create();
    if (gameName != null) {
      $result.gameName = gameName;
    }
    return $result;
  }
  GetImagesRequest._() : super();
  factory GetImagesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetImagesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetImagesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'game.proto.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'gameName')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetImagesRequest clone() => GetImagesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetImagesRequest copyWith(void Function(GetImagesRequest) updates) => super.copyWith((message) => updates(message as GetImagesRequest)) as GetImagesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetImagesRequest create() => GetImagesRequest._();
  GetImagesRequest createEmptyInstance() => create();
  static $pb.PbList<GetImagesRequest> createRepeated() => $pb.PbList<GetImagesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetImagesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetImagesRequest>(create);
  static GetImagesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get gameName => $_getSZ(0);
  @$pb.TagNumber(1)
  set gameName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGameName() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameName() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
