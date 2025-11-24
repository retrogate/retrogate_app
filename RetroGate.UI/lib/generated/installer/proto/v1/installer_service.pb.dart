//
//  Generated code. Do not modify.
//  source: installer/proto/v1/installer_service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class InstallRequest extends $pb.GeneratedMessage {
  factory InstallRequest({
    $core.String? gameId,
    $core.bool? replace,
    $core.bool? restartSteam,
  }) {
    final $result = create();
    if (gameId != null) {
      $result.gameId = gameId;
    }
    if (replace != null) {
      $result.replace = replace;
    }
    if (restartSteam != null) {
      $result.restartSteam = restartSteam;
    }
    return $result;
  }
  InstallRequest._() : super();
  factory InstallRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InstallRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InstallRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'installer.proto.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'gameId')
    ..aOB(2, _omitFieldNames ? '' : 'replace')
    ..aOB(3, _omitFieldNames ? '' : 'restartSteam')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InstallRequest clone() => InstallRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InstallRequest copyWith(void Function(InstallRequest) updates) => super.copyWith((message) => updates(message as InstallRequest)) as InstallRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstallRequest create() => InstallRequest._();
  InstallRequest createEmptyInstance() => create();
  static $pb.PbList<InstallRequest> createRepeated() => $pb.PbList<InstallRequest>();
  @$core.pragma('dart2js:noInline')
  static InstallRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InstallRequest>(create);
  static InstallRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get gameId => $_getSZ(0);
  @$pb.TagNumber(1)
  set gameId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGameId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameId() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get replace => $_getBF(1);
  @$pb.TagNumber(2)
  set replace($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReplace() => $_has(1);
  @$pb.TagNumber(2)
  void clearReplace() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get restartSteam => $_getBF(2);
  @$pb.TagNumber(3)
  set restartSteam($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRestartSteam() => $_has(2);
  @$pb.TagNumber(3)
  void clearRestartSteam() => clearField(3);
}

class InstallResponse extends $pb.GeneratedMessage {
  factory InstallResponse({
    $core.String? installPath,
  }) {
    final $result = create();
    if (installPath != null) {
      $result.installPath = installPath;
    }
    return $result;
  }
  InstallResponse._() : super();
  factory InstallResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InstallResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InstallResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'installer.proto.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'installPath')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InstallResponse clone() => InstallResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InstallResponse copyWith(void Function(InstallResponse) updates) => super.copyWith((message) => updates(message as InstallResponse)) as InstallResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstallResponse create() => InstallResponse._();
  InstallResponse createEmptyInstance() => create();
  static $pb.PbList<InstallResponse> createRepeated() => $pb.PbList<InstallResponse>();
  @$core.pragma('dart2js:noInline')
  static InstallResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InstallResponse>(create);
  static InstallResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get installPath => $_getSZ(0);
  @$pb.TagNumber(1)
  set installPath($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInstallPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearInstallPath() => clearField(1);
}

class DeleteRequest extends $pb.GeneratedMessage {
  factory DeleteRequest({
    $core.Iterable<$core.String>? paths,
  }) {
    final $result = create();
    if (paths != null) {
      $result.paths.addAll(paths);
    }
    return $result;
  }
  DeleteRequest._() : super();
  factory DeleteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'installer.proto.v1'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'paths')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteRequest clone() => DeleteRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteRequest copyWith(void Function(DeleteRequest) updates) => super.copyWith((message) => updates(message as DeleteRequest)) as DeleteRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteRequest create() => DeleteRequest._();
  DeleteRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteRequest> createRepeated() => $pb.PbList<DeleteRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteRequest>(create);
  static DeleteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get paths => $_getList(0);
}

class CancelRequest extends $pb.GeneratedMessage {
  factory CancelRequest({
    $core.String? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  CancelRequest._() : super();
  factory CancelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CancelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'installer.proto.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelRequest clone() => CancelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelRequest copyWith(void Function(CancelRequest) updates) => super.copyWith((message) => updates(message as CancelRequest)) as CancelRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelRequest create() => CancelRequest._();
  CancelRequest createEmptyInstance() => create();
  static $pb.PbList<CancelRequest> createRepeated() => $pb.PbList<CancelRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelRequest>(create);
  static CancelRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class SubscribeProgressRequest extends $pb.GeneratedMessage {
  factory SubscribeProgressRequest({
    $core.String? gameId,
  }) {
    final $result = create();
    if (gameId != null) {
      $result.gameId = gameId;
    }
    return $result;
  }
  SubscribeProgressRequest._() : super();
  factory SubscribeProgressRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubscribeProgressRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SubscribeProgressRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'installer.proto.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'gameId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubscribeProgressRequest clone() => SubscribeProgressRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubscribeProgressRequest copyWith(void Function(SubscribeProgressRequest) updates) => super.copyWith((message) => updates(message as SubscribeProgressRequest)) as SubscribeProgressRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscribeProgressRequest create() => SubscribeProgressRequest._();
  SubscribeProgressRequest createEmptyInstance() => create();
  static $pb.PbList<SubscribeProgressRequest> createRepeated() => $pb.PbList<SubscribeProgressRequest>();
  @$core.pragma('dart2js:noInline')
  static SubscribeProgressRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscribeProgressRequest>(create);
  static SubscribeProgressRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get gameId => $_getSZ(0);
  @$pb.TagNumber(1)
  set gameId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGameId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameId() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
