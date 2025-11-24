//
//  Generated code. Do not modify.
//  source: game/proto/v1/game_model.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use gameInstallationMethodDescriptor instead')
const GameInstallationMethod$json = {
  '1': 'GameInstallationMethod',
  '2': [
    {'1': 'GAME_INSTALLATION_METHOD_EXTRACT', '2': 0},
  ],
};

/// Descriptor for `GameInstallationMethod`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List gameInstallationMethodDescriptor = $convert.base64Decode(
    'ChZHYW1lSW5zdGFsbGF0aW9uTWV0aG9kEiQKIEdBTUVfSU5TVEFMTEFUSU9OX01FVEhPRF9FWF'
    'RSQUNUEAA=');

@$core.Deprecated('Use gameModelDescriptor instead')
const GameModel$json = {
  '1': 'GameModel',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'download_url', '3': 3, '4': 1, '5': 9, '10': 'downloadUrl'},
    {'1': 'executable_path', '3': 4, '4': 1, '5': 9, '10': 'executablePath'},
    {'1': 'image_hero_url', '3': 5, '4': 1, '5': 9, '10': 'imageHeroUrl'},
    {'1': 'image_poster_url', '3': 6, '4': 1, '5': 9, '10': 'imagePosterUrl'},
    {'1': 'image_logo_url', '3': 7, '4': 1, '5': 9, '10': 'imageLogoUrl'},
    {'1': 'installation_method', '3': 8, '4': 1, '5': 14, '6': '.game.proto.v1.GameInstallationMethod', '10': 'installationMethod'},
    {'1': 'settings_file', '3': 9, '4': 1, '5': 9, '9': 0, '10': 'settingsFile', '17': true},
  ],
  '8': [
    {'1': '_settings_file'},
  ],
};

/// Descriptor for `GameModel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gameModelDescriptor = $convert.base64Decode(
    'CglHYW1lTW9kZWwSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSIQoMZG93bm'
    'xvYWRfdXJsGAMgASgJUgtkb3dubG9hZFVybBInCg9leGVjdXRhYmxlX3BhdGgYBCABKAlSDmV4'
    'ZWN1dGFibGVQYXRoEiQKDmltYWdlX2hlcm9fdXJsGAUgASgJUgxpbWFnZUhlcm9VcmwSKAoQaW'
    '1hZ2VfcG9zdGVyX3VybBgGIAEoCVIOaW1hZ2VQb3N0ZXJVcmwSJAoOaW1hZ2VfbG9nb191cmwY'
    'ByABKAlSDGltYWdlTG9nb1VybBJWChNpbnN0YWxsYXRpb25fbWV0aG9kGAggASgOMiUuZ2FtZS'
    '5wcm90by52MS5HYW1lSW5zdGFsbGF0aW9uTWV0aG9kUhJpbnN0YWxsYXRpb25NZXRob2QSKAoN'
    'c2V0dGluZ3NfZmlsZRgJIAEoCUgAUgxzZXR0aW5nc0ZpbGWIAQFCEAoOX3NldHRpbmdzX2ZpbG'
    'U=');

