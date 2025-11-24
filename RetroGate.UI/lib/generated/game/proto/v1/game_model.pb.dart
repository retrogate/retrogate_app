//
//  Generated code. Do not modify.
//  source: game/proto/v1/game_model.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'game_model.pbenum.dart';

export 'game_model.pbenum.dart';

class GameModel extends $pb.GeneratedMessage {
  factory GameModel({
    $core.String? id,
    $core.String? name,
    $core.String? downloadUrl,
    $core.String? executablePath,
    $core.String? imageHeroUrl,
    $core.String? imagePosterUrl,
    $core.String? imageLogoUrl,
    GameInstallationMethod? installationMethod,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (downloadUrl != null) {
      $result.downloadUrl = downloadUrl;
    }
    if (executablePath != null) {
      $result.executablePath = executablePath;
    }
    if (imageHeroUrl != null) {
      $result.imageHeroUrl = imageHeroUrl;
    }
    if (imagePosterUrl != null) {
      $result.imagePosterUrl = imagePosterUrl;
    }
    if (imageLogoUrl != null) {
      $result.imageLogoUrl = imageLogoUrl;
    }
    if (installationMethod != null) {
      $result.installationMethod = installationMethod;
    }
    return $result;
  }
  GameModel._() : super();
  factory GameModel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GameModel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GameModel', package: const $pb.PackageName(_omitMessageNames ? '' : 'game.proto.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'downloadUrl')
    ..aOS(4, _omitFieldNames ? '' : 'executablePath')
    ..aOS(5, _omitFieldNames ? '' : 'imageHeroUrl')
    ..aOS(6, _omitFieldNames ? '' : 'imagePosterUrl')
    ..aOS(7, _omitFieldNames ? '' : 'imageLogoUrl')
    ..e<GameInstallationMethod>(8, _omitFieldNames ? '' : 'installationMethod', $pb.PbFieldType.OE, defaultOrMaker: GameInstallationMethod.GAME_INSTALLATION_METHOD_EXTRACT, valueOf: GameInstallationMethod.valueOf, enumValues: GameInstallationMethod.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GameModel clone() => GameModel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GameModel copyWith(void Function(GameModel) updates) => super.copyWith((message) => updates(message as GameModel)) as GameModel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GameModel create() => GameModel._();
  GameModel createEmptyInstance() => create();
  static $pb.PbList<GameModel> createRepeated() => $pb.PbList<GameModel>();
  @$core.pragma('dart2js:noInline')
  static GameModel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GameModel>(create);
  static GameModel? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get downloadUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set downloadUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDownloadUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearDownloadUrl() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get executablePath => $_getSZ(3);
  @$pb.TagNumber(4)
  set executablePath($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasExecutablePath() => $_has(3);
  @$pb.TagNumber(4)
  void clearExecutablePath() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get imageHeroUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set imageHeroUrl($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasImageHeroUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearImageHeroUrl() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get imagePosterUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set imagePosterUrl($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasImagePosterUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearImagePosterUrl() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get imageLogoUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set imageLogoUrl($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasImageLogoUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearImageLogoUrl() => clearField(7);

  @$pb.TagNumber(8)
  GameInstallationMethod get installationMethod => $_getN(7);
  @$pb.TagNumber(8)
  set installationMethod(GameInstallationMethod v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasInstallationMethod() => $_has(7);
  @$pb.TagNumber(8)
  void clearInstallationMethod() => clearField(8);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
