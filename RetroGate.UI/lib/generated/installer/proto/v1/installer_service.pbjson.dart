//
//  Generated code. Do not modify.
//  source: installer/proto/v1/installer_service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use installRequestDescriptor instead')
const InstallRequest$json = {
  '1': 'InstallRequest',
  '2': [
    {'1': 'game_id', '3': 1, '4': 1, '5': 9, '10': 'gameId'},
    {'1': 'replace', '3': 2, '4': 1, '5': 8, '10': 'replace'},
    {'1': 'restart_steam', '3': 3, '4': 1, '5': 8, '10': 'restartSteam'},
  ],
};

/// Descriptor for `InstallRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List installRequestDescriptor = $convert.base64Decode(
    'Cg5JbnN0YWxsUmVxdWVzdBIXCgdnYW1lX2lkGAEgASgJUgZnYW1lSWQSGAoHcmVwbGFjZRgCIA'
    'EoCFIHcmVwbGFjZRIjCg1yZXN0YXJ0X3N0ZWFtGAMgASgIUgxyZXN0YXJ0U3RlYW0=');

@$core.Deprecated('Use installResponseDescriptor instead')
const InstallResponse$json = {
  '1': 'InstallResponse',
  '2': [
    {'1': 'install_path', '3': 1, '4': 1, '5': 9, '10': 'installPath'},
  ],
};

/// Descriptor for `InstallResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List installResponseDescriptor = $convert.base64Decode(
    'Cg9JbnN0YWxsUmVzcG9uc2USIQoMaW5zdGFsbF9wYXRoGAEgASgJUgtpbnN0YWxsUGF0aA==');

@$core.Deprecated('Use deleteRequestDescriptor instead')
const DeleteRequest$json = {
  '1': 'DeleteRequest',
  '2': [
    {'1': 'paths', '3': 1, '4': 3, '5': 9, '10': 'paths'},
  ],
};

/// Descriptor for `DeleteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteRequestDescriptor = $convert.base64Decode(
    'Cg1EZWxldGVSZXF1ZXN0EhQKBXBhdGhzGAEgAygJUgVwYXRocw==');

@$core.Deprecated('Use cancelRequestDescriptor instead')
const CancelRequest$json = {
  '1': 'CancelRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `CancelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelRequestDescriptor = $convert.base64Decode(
    'Cg1DYW5jZWxSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');

@$core.Deprecated('Use subscribeProgressRequestDescriptor instead')
const SubscribeProgressRequest$json = {
  '1': 'SubscribeProgressRequest',
  '2': [
    {'1': 'game_id', '3': 1, '4': 1, '5': 9, '10': 'gameId'},
  ],
};

/// Descriptor for `SubscribeProgressRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscribeProgressRequestDescriptor = $convert.base64Decode(
    'ChhTdWJzY3JpYmVQcm9ncmVzc1JlcXVlc3QSFwoHZ2FtZV9pZBgBIAEoCVIGZ2FtZUlk');

