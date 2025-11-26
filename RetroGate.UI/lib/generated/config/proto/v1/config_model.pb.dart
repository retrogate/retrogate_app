//
//  Generated code. Do not modify.
//  source: config/proto/v1/config_model.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ConfigModel extends $pb.GeneratedMessage {
  factory ConfigModel({
    $core.String? steamPath,
    $core.String? steamUserId,
    $core.String? steamGridDbApiKey,
    $core.String? installedGamesPath,
  }) {
    final $result = create();
    if (steamPath != null) {
      $result.steamPath = steamPath;
    }
    if (steamUserId != null) {
      $result.steamUserId = steamUserId;
    }
    if (steamGridDbApiKey != null) {
      $result.steamGridDbApiKey = steamGridDbApiKey;
    }
    if (installedGamesPath != null) {
      $result.installedGamesPath = installedGamesPath;
    }
    return $result;
  }
  ConfigModel._() : super();
  factory ConfigModel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConfigModel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ConfigModel', package: const $pb.PackageName(_omitMessageNames ? '' : 'config.proto.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'steamPath')
    ..aOS(2, _omitFieldNames ? '' : 'steamUserId')
    ..aOS(3, _omitFieldNames ? '' : 'steamGridDbApiKey')
    ..aOS(4, _omitFieldNames ? '' : 'installedGamesPath')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConfigModel clone() => ConfigModel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConfigModel copyWith(void Function(ConfigModel) updates) => super.copyWith((message) => updates(message as ConfigModel)) as ConfigModel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConfigModel create() => ConfigModel._();
  ConfigModel createEmptyInstance() => create();
  static $pb.PbList<ConfigModel> createRepeated() => $pb.PbList<ConfigModel>();
  @$core.pragma('dart2js:noInline')
  static ConfigModel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConfigModel>(create);
  static ConfigModel? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get steamPath => $_getSZ(0);
  @$pb.TagNumber(1)
  set steamPath($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSteamPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearSteamPath() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get steamUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set steamUserId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSteamUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSteamUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get steamGridDbApiKey => $_getSZ(2);
  @$pb.TagNumber(3)
  set steamGridDbApiKey($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSteamGridDbApiKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearSteamGridDbApiKey() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get installedGamesPath => $_getSZ(3);
  @$pb.TagNumber(4)
  set installedGamesPath($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasInstalledGamesPath() => $_has(3);
  @$pb.TagNumber(4)
  void clearInstalledGamesPath() => clearField(4);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
