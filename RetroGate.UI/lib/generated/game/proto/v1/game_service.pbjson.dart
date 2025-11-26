//
//  Generated code. Do not modify.
//  source: game/proto/v1/game_service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use gameSourceDescriptor instead')
const GameSource$json = {
  '1': 'GameSource',
  '2': [
    {'1': 'GAME_SOURCE_AVAILABLE', '2': 0},
    {'1': 'GAME_SOURCE_INSTALLED', '2': 1},
  ],
};

/// Descriptor for `GameSource`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List gameSourceDescriptor = $convert.base64Decode(
    'CgpHYW1lU291cmNlEhkKFUdBTUVfU09VUkNFX0FWQUlMQUJMRRAAEhkKFUdBTUVfU09VUkNFX0'
    'lOU1RBTExFRBAB');

@$core.Deprecated('Use createGameRequestDescriptor instead')
const CreateGameRequest$json = {
  '1': 'CreateGameRequest',
  '2': [
    {'1': 'source', '3': 1, '4': 1, '5': 14, '6': '.game.proto.v1.GameSource', '10': 'source'},
    {'1': 'game', '3': 2, '4': 1, '5': 11, '6': '.game.proto.v1.GameModel', '10': 'game'},
  ],
};

/// Descriptor for `CreateGameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createGameRequestDescriptor = $convert.base64Decode(
    'ChFDcmVhdGVHYW1lUmVxdWVzdBIxCgZzb3VyY2UYASABKA4yGS5nYW1lLnByb3RvLnYxLkdhbW'
    'VTb3VyY2VSBnNvdXJjZRIsCgRnYW1lGAIgASgLMhguZ2FtZS5wcm90by52MS5HYW1lTW9kZWxS'
    'BGdhbWU=');

@$core.Deprecated('Use getByIdRequestDescriptor instead')
const GetByIdRequest$json = {
  '1': 'GetByIdRequest',
  '2': [
    {'1': 'source', '3': 1, '4': 1, '5': 14, '6': '.game.proto.v1.GameSource', '10': 'source'},
    {'1': 'id', '3': 2, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getByIdRequestDescriptor = $convert.base64Decode(
    'Cg5HZXRCeUlkUmVxdWVzdBIxCgZzb3VyY2UYASABKA4yGS5nYW1lLnByb3RvLnYxLkdhbWVTb3'
    'VyY2VSBnNvdXJjZRIOCgJpZBgCIAEoCVICaWQ=');

@$core.Deprecated('Use getAllRequestDescriptor instead')
const GetAllRequest$json = {
  '1': 'GetAllRequest',
  '2': [
    {'1': 'source', '3': 1, '4': 1, '5': 14, '6': '.game.proto.v1.GameSource', '10': 'source'},
  ],
};

/// Descriptor for `GetAllRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAllRequestDescriptor = $convert.base64Decode(
    'Cg1HZXRBbGxSZXF1ZXN0EjEKBnNvdXJjZRgBIAEoDjIZLmdhbWUucHJvdG8udjEuR2FtZVNvdX'
    'JjZVIGc291cmNl');

@$core.Deprecated('Use getAllResponseDescriptor instead')
const GetAllResponse$json = {
  '1': 'GetAllResponse',
  '2': [
    {'1': 'games', '3': 1, '4': 3, '5': 11, '6': '.game.proto.v1.GameModel', '10': 'games'},
  ],
};

/// Descriptor for `GetAllResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAllResponseDescriptor = $convert.base64Decode(
    'Cg5HZXRBbGxSZXNwb25zZRIuCgVnYW1lcxgBIAMoCzIYLmdhbWUucHJvdG8udjEuR2FtZU1vZG'
    'VsUgVnYW1lcw==');

@$core.Deprecated('Use findByNameRequestDescriptor instead')
const FindByNameRequest$json = {
  '1': 'FindByNameRequest',
  '2': [
    {'1': 'source', '3': 1, '4': 1, '5': 14, '6': '.game.proto.v1.GameSource', '10': 'source'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `FindByNameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List findByNameRequestDescriptor = $convert.base64Decode(
    'ChFGaW5kQnlOYW1lUmVxdWVzdBIxCgZzb3VyY2UYASABKA4yGS5nYW1lLnByb3RvLnYxLkdhbW'
    'VTb3VyY2VSBnNvdXJjZRISCgRuYW1lGAIgASgJUgRuYW1l');

@$core.Deprecated('Use findByNameResponseDescriptor instead')
const FindByNameResponse$json = {
  '1': 'FindByNameResponse',
  '2': [
    {'1': 'games', '3': 1, '4': 3, '5': 11, '6': '.game.proto.v1.GameModel', '10': 'games'},
  ],
};

/// Descriptor for `FindByNameResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List findByNameResponseDescriptor = $convert.base64Decode(
    'ChJGaW5kQnlOYW1lUmVzcG9uc2USLgoFZ2FtZXMYASADKAsyGC5nYW1lLnByb3RvLnYxLkdhbW'
    'VNb2RlbFIFZ2FtZXM=');

@$core.Deprecated('Use updateGameRequestDescriptor instead')
const UpdateGameRequest$json = {
  '1': 'UpdateGameRequest',
  '2': [
    {'1': 'source', '3': 1, '4': 1, '5': 14, '6': '.game.proto.v1.GameSource', '10': 'source'},
    {'1': 'game', '3': 2, '4': 1, '5': 11, '6': '.game.proto.v1.GameModel', '10': 'game'},
  ],
};

/// Descriptor for `UpdateGameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateGameRequestDescriptor = $convert.base64Decode(
    'ChFVcGRhdGVHYW1lUmVxdWVzdBIxCgZzb3VyY2UYASABKA4yGS5nYW1lLnByb3RvLnYxLkdhbW'
    'VTb3VyY2VSBnNvdXJjZRIsCgRnYW1lGAIgASgLMhguZ2FtZS5wcm90by52MS5HYW1lTW9kZWxS'
    'BGdhbWU=');

@$core.Deprecated('Use getImagesRequestDescriptor instead')
const GetImagesRequest$json = {
  '1': 'GetImagesRequest',
  '2': [
    {'1': 'game_name', '3': 1, '4': 1, '5': 9, '10': 'gameName'},
  ],
};

/// Descriptor for `GetImagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getImagesRequestDescriptor = $convert.base64Decode(
    'ChBHZXRJbWFnZXNSZXF1ZXN0EhsKCWdhbWVfbmFtZRgBIAEoCVIIZ2FtZU5hbWU=');

@$core.Deprecated('Use launchGameRequestDescriptor instead')
const LaunchGameRequest$json = {
  '1': 'LaunchGameRequest',
  '2': [
    {'1': 'game_id', '3': 1, '4': 1, '5': 9, '10': 'gameId'},
  ],
};

/// Descriptor for `LaunchGameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List launchGameRequestDescriptor = $convert.base64Decode(
    'ChFMYXVuY2hHYW1lUmVxdWVzdBIXCgdnYW1lX2lkGAEgASgJUgZnYW1lSWQ=');

