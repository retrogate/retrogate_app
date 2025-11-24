//
//  Generated code. Do not modify.
//  source: shortcut/proto/v1/shortcut_model.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ShortcutModel extends $pb.GeneratedMessage {
  factory ShortcutModel({
    $core.int? appId,
    $core.String? appName,
    $core.String? exe,
    $core.String? startDir,
    $core.String? icon,
    $core.String? shortcutPath,
    $core.String? launchOptions,
    $core.bool? isHidden,
    $core.bool? allowDesktopConfig,
    $core.bool? allowOverlay,
    $core.bool? openVr,
    $core.bool? devkit,
    $core.String? devkitGameId,
    $core.int? devkitOverrideAppId,
    $core.int? lastPlayTime,
    $core.String? flatpakAppId,
    $core.String? sortAs,
    $core.String? imageHeroUrl,
    $core.String? imagePosterUrl,
    $core.String? imageLogoUrl,
  }) {
    final $result = create();
    if (appId != null) {
      $result.appId = appId;
    }
    if (appName != null) {
      $result.appName = appName;
    }
    if (exe != null) {
      $result.exe = exe;
    }
    if (startDir != null) {
      $result.startDir = startDir;
    }
    if (icon != null) {
      $result.icon = icon;
    }
    if (shortcutPath != null) {
      $result.shortcutPath = shortcutPath;
    }
    if (launchOptions != null) {
      $result.launchOptions = launchOptions;
    }
    if (isHidden != null) {
      $result.isHidden = isHidden;
    }
    if (allowDesktopConfig != null) {
      $result.allowDesktopConfig = allowDesktopConfig;
    }
    if (allowOverlay != null) {
      $result.allowOverlay = allowOverlay;
    }
    if (openVr != null) {
      $result.openVr = openVr;
    }
    if (devkit != null) {
      $result.devkit = devkit;
    }
    if (devkitGameId != null) {
      $result.devkitGameId = devkitGameId;
    }
    if (devkitOverrideAppId != null) {
      $result.devkitOverrideAppId = devkitOverrideAppId;
    }
    if (lastPlayTime != null) {
      $result.lastPlayTime = lastPlayTime;
    }
    if (flatpakAppId != null) {
      $result.flatpakAppId = flatpakAppId;
    }
    if (sortAs != null) {
      $result.sortAs = sortAs;
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
    return $result;
  }
  ShortcutModel._() : super();
  factory ShortcutModel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ShortcutModel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ShortcutModel', package: const $pb.PackageName(_omitMessageNames ? '' : 'shortcut.proto.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'appId', $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'appName')
    ..aOS(3, _omitFieldNames ? '' : 'exe')
    ..aOS(4, _omitFieldNames ? '' : 'startDir')
    ..aOS(5, _omitFieldNames ? '' : 'icon')
    ..aOS(6, _omitFieldNames ? '' : 'shortcutPath')
    ..aOS(7, _omitFieldNames ? '' : 'launchOptions')
    ..aOB(8, _omitFieldNames ? '' : 'isHidden')
    ..aOB(9, _omitFieldNames ? '' : 'allowDesktopConfig')
    ..aOB(10, _omitFieldNames ? '' : 'allowOverlay')
    ..aOB(11, _omitFieldNames ? '' : 'openVr')
    ..aOB(12, _omitFieldNames ? '' : 'devkit')
    ..aOS(13, _omitFieldNames ? '' : 'devkitGameId')
    ..a<$core.int>(14, _omitFieldNames ? '' : 'devkitOverrideAppId', $pb.PbFieldType.OU3)
    ..a<$core.int>(15, _omitFieldNames ? '' : 'lastPlayTime', $pb.PbFieldType.OU3)
    ..aOS(16, _omitFieldNames ? '' : 'flatpakAppId')
    ..aOS(17, _omitFieldNames ? '' : 'sortAs')
    ..aOS(18, _omitFieldNames ? '' : 'imageHeroUrl')
    ..aOS(19, _omitFieldNames ? '' : 'imagePosterUrl')
    ..aOS(20, _omitFieldNames ? '' : 'imageLogoUrl')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ShortcutModel clone() => ShortcutModel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ShortcutModel copyWith(void Function(ShortcutModel) updates) => super.copyWith((message) => updates(message as ShortcutModel)) as ShortcutModel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ShortcutModel create() => ShortcutModel._();
  ShortcutModel createEmptyInstance() => create();
  static $pb.PbList<ShortcutModel> createRepeated() => $pb.PbList<ShortcutModel>();
  @$core.pragma('dart2js:noInline')
  static ShortcutModel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ShortcutModel>(create);
  static ShortcutModel? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get appId => $_getIZ(0);
  @$pb.TagNumber(1)
  set appId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAppId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAppId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get appName => $_getSZ(1);
  @$pb.TagNumber(2)
  set appName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAppName() => $_has(1);
  @$pb.TagNumber(2)
  void clearAppName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get exe => $_getSZ(2);
  @$pb.TagNumber(3)
  set exe($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExe() => $_has(2);
  @$pb.TagNumber(3)
  void clearExe() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get startDir => $_getSZ(3);
  @$pb.TagNumber(4)
  set startDir($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStartDir() => $_has(3);
  @$pb.TagNumber(4)
  void clearStartDir() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get icon => $_getSZ(4);
  @$pb.TagNumber(5)
  set icon($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIcon() => $_has(4);
  @$pb.TagNumber(5)
  void clearIcon() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get shortcutPath => $_getSZ(5);
  @$pb.TagNumber(6)
  set shortcutPath($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasShortcutPath() => $_has(5);
  @$pb.TagNumber(6)
  void clearShortcutPath() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get launchOptions => $_getSZ(6);
  @$pb.TagNumber(7)
  set launchOptions($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLaunchOptions() => $_has(6);
  @$pb.TagNumber(7)
  void clearLaunchOptions() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get isHidden => $_getBF(7);
  @$pb.TagNumber(8)
  set isHidden($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasIsHidden() => $_has(7);
  @$pb.TagNumber(8)
  void clearIsHidden() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get allowDesktopConfig => $_getBF(8);
  @$pb.TagNumber(9)
  set allowDesktopConfig($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasAllowDesktopConfig() => $_has(8);
  @$pb.TagNumber(9)
  void clearAllowDesktopConfig() => clearField(9);

  @$pb.TagNumber(10)
  $core.bool get allowOverlay => $_getBF(9);
  @$pb.TagNumber(10)
  set allowOverlay($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasAllowOverlay() => $_has(9);
  @$pb.TagNumber(10)
  void clearAllowOverlay() => clearField(10);

  @$pb.TagNumber(11)
  $core.bool get openVr => $_getBF(10);
  @$pb.TagNumber(11)
  set openVr($core.bool v) { $_setBool(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasOpenVr() => $_has(10);
  @$pb.TagNumber(11)
  void clearOpenVr() => clearField(11);

  @$pb.TagNumber(12)
  $core.bool get devkit => $_getBF(11);
  @$pb.TagNumber(12)
  set devkit($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasDevkit() => $_has(11);
  @$pb.TagNumber(12)
  void clearDevkit() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get devkitGameId => $_getSZ(12);
  @$pb.TagNumber(13)
  set devkitGameId($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasDevkitGameId() => $_has(12);
  @$pb.TagNumber(13)
  void clearDevkitGameId() => clearField(13);

  @$pb.TagNumber(14)
  $core.int get devkitOverrideAppId => $_getIZ(13);
  @$pb.TagNumber(14)
  set devkitOverrideAppId($core.int v) { $_setUnsignedInt32(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasDevkitOverrideAppId() => $_has(13);
  @$pb.TagNumber(14)
  void clearDevkitOverrideAppId() => clearField(14);

  @$pb.TagNumber(15)
  $core.int get lastPlayTime => $_getIZ(14);
  @$pb.TagNumber(15)
  set lastPlayTime($core.int v) { $_setUnsignedInt32(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasLastPlayTime() => $_has(14);
  @$pb.TagNumber(15)
  void clearLastPlayTime() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get flatpakAppId => $_getSZ(15);
  @$pb.TagNumber(16)
  set flatpakAppId($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasFlatpakAppId() => $_has(15);
  @$pb.TagNumber(16)
  void clearFlatpakAppId() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get sortAs => $_getSZ(16);
  @$pb.TagNumber(17)
  set sortAs($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasSortAs() => $_has(16);
  @$pb.TagNumber(17)
  void clearSortAs() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get imageHeroUrl => $_getSZ(17);
  @$pb.TagNumber(18)
  set imageHeroUrl($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasImageHeroUrl() => $_has(17);
  @$pb.TagNumber(18)
  void clearImageHeroUrl() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get imagePosterUrl => $_getSZ(18);
  @$pb.TagNumber(19)
  set imagePosterUrl($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasImagePosterUrl() => $_has(18);
  @$pb.TagNumber(19)
  void clearImagePosterUrl() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get imageLogoUrl => $_getSZ(19);
  @$pb.TagNumber(20)
  set imageLogoUrl($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasImageLogoUrl() => $_has(19);
  @$pb.TagNumber(20)
  void clearImageLogoUrl() => clearField(20);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
