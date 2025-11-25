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

class GameSource extends $pb.ProtobufEnum {
  static const GameSource GAME_SOURCE_AVAILABLE = GameSource._(0, _omitEnumNames ? '' : 'GAME_SOURCE_AVAILABLE');
  static const GameSource GAME_SOURCE_INSTALLED = GameSource._(1, _omitEnumNames ? '' : 'GAME_SOURCE_INSTALLED');

  static const $core.List<GameSource> values = <GameSource> [
    GAME_SOURCE_AVAILABLE,
    GAME_SOURCE_INSTALLED,
  ];

  static final $core.Map<$core.int, GameSource> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GameSource? valueOf($core.int value) => _byValue[value];

  const GameSource._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
