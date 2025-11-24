//
//  Generated code. Do not modify.
//  source: game/proto/v1/game_images_model.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class GameImagesModel extends $pb.GeneratedMessage {
  factory GameImagesModel({
    $core.String? heroUrl,
    $core.String? posterUrl,
    $core.String? logoUrl,
  }) {
    final $result = create();
    if (heroUrl != null) {
      $result.heroUrl = heroUrl;
    }
    if (posterUrl != null) {
      $result.posterUrl = posterUrl;
    }
    if (logoUrl != null) {
      $result.logoUrl = logoUrl;
    }
    return $result;
  }
  GameImagesModel._() : super();
  factory GameImagesModel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GameImagesModel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GameImagesModel', package: const $pb.PackageName(_omitMessageNames ? '' : 'game.proto.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'heroUrl')
    ..aOS(2, _omitFieldNames ? '' : 'posterUrl')
    ..aOS(3, _omitFieldNames ? '' : 'logoUrl')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GameImagesModel clone() => GameImagesModel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GameImagesModel copyWith(void Function(GameImagesModel) updates) => super.copyWith((message) => updates(message as GameImagesModel)) as GameImagesModel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GameImagesModel create() => GameImagesModel._();
  GameImagesModel createEmptyInstance() => create();
  static $pb.PbList<GameImagesModel> createRepeated() => $pb.PbList<GameImagesModel>();
  @$core.pragma('dart2js:noInline')
  static GameImagesModel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GameImagesModel>(create);
  static GameImagesModel? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get heroUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set heroUrl($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHeroUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearHeroUrl() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get posterUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set posterUrl($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPosterUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearPosterUrl() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get logoUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set logoUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLogoUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearLogoUrl() => clearField(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
