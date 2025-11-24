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

class GameInstallationMethod extends $pb.ProtobufEnum {
  static const GameInstallationMethod GAME_INSTALLATION_METHOD_EXTRACT = GameInstallationMethod._(0, _omitEnumNames ? '' : 'GAME_INSTALLATION_METHOD_EXTRACT');

  static const $core.List<GameInstallationMethod> values = <GameInstallationMethod> [
    GAME_INSTALLATION_METHOD_EXTRACT,
  ];

  static final $core.Map<$core.int, GameInstallationMethod> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GameInstallationMethod? valueOf($core.int value) => _byValue[value];

  const GameInstallationMethod._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
