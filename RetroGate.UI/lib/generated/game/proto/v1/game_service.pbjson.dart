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

@$core.Deprecated('Use getByIdRequestDescriptor instead')
const GetByIdRequest$json = {
  '1': 'GetByIdRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getByIdRequestDescriptor = $convert.base64Decode(
    'Cg5HZXRCeUlkUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');

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
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `FindByNameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List findByNameRequestDescriptor = $convert.base64Decode(
    'ChFGaW5kQnlOYW1lUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1l');

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

