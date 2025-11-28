//
//  Generated code. Do not modify.
//  source: installer/proto/v1/installer_event_model.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use installerProgressStateDescriptor instead')
const InstallerProgressState$json = {
  '1': 'InstallerProgressState',
  '2': [
    {'1': 'INSTALLER_PROGRESS_STATE_IDLE', '2': 0},
    {'1': 'INSTALLER_PROGRESS_STATE_DOWNLOADING', '2': 1},
    {'1': 'INSTALLER_PROGRESS_STATE_PENDING', '2': 2},
    {'1': 'INSTALLER_PROGRESS_STATE_EXTRACTING', '2': 3},
    {'1': 'INSTALLER_PROGRESS_STATE_CREATING_SHORTCUT', '2': 4},
    {'1': 'INSTALLER_PROGRESS_STATE_PAUSED', '2': 5},
    {'1': 'INSTALLER_PROGRESS_STATE_COMPLETED', '2': 6},
    {'1': 'INSTALLER_PROGRESS_STATE_FAILED', '2': 7},
    {'1': 'INSTALLER_PROGRESS_STATE_CANCELLED', '2': 8},
    {'1': 'INSTALLER_PROGRESS_STATE_UNINSTALLED', '2': 9},
  ],
};

/// Descriptor for `InstallerProgressState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List installerProgressStateDescriptor = $convert.base64Decode(
    'ChZJbnN0YWxsZXJQcm9ncmVzc1N0YXRlEiEKHUlOU1RBTExFUl9QUk9HUkVTU19TVEFURV9JRE'
    'xFEAASKAokSU5TVEFMTEVSX1BST0dSRVNTX1NUQVRFX0RPV05MT0FESU5HEAESJAogSU5TVEFM'
    'TEVSX1BST0dSRVNTX1NUQVRFX1BFTkRJTkcQAhInCiNJTlNUQUxMRVJfUFJPR1JFU1NfU1RBVE'
    'VfRVhUUkFDVElORxADEi4KKklOU1RBTExFUl9QUk9HUkVTU19TVEFURV9DUkVBVElOR19TSE9S'
    'VENVVBAEEiMKH0lOU1RBTExFUl9QUk9HUkVTU19TVEFURV9QQVVTRUQQBRImCiJJTlNUQUxMRV'
    'JfUFJPR1JFU1NfU1RBVEVfQ09NUExFVEVEEAYSIwofSU5TVEFMTEVSX1BST0dSRVNTX1NUQVRF'
    'X0ZBSUxFRBAHEiYKIklOU1RBTExFUl9QUk9HUkVTU19TVEFURV9DQU5DRUxMRUQQCBIoCiRJTl'
    'NUQUxMRVJfUFJPR1JFU1NfU1RBVEVfVU5JTlNUQUxMRUQQCQ==');

@$core.Deprecated('Use installerEventProgressChangedModelDescriptor instead')
const InstallerEventProgressChangedModel$json = {
  '1': 'InstallerEventProgressChangedModel',
  '2': [
    {'1': 'game_id', '3': 1, '4': 1, '5': 9, '10': 'gameId'},
    {'1': 'state', '3': 2, '4': 1, '5': 14, '6': '.installer.proto.v1.InstallerProgressState', '10': 'state'},
    {'1': 'percentage', '3': 3, '4': 1, '5': 5, '10': 'percentage'},
    {'1': 'speed_in_kb_per_sec', '3': 4, '4': 1, '5': 5, '10': 'speedInKbPerSec'},
  ],
};

/// Descriptor for `InstallerEventProgressChangedModel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List installerEventProgressChangedModelDescriptor = $convert.base64Decode(
    'CiJJbnN0YWxsZXJFdmVudFByb2dyZXNzQ2hhbmdlZE1vZGVsEhcKB2dhbWVfaWQYASABKAlSBm'
    'dhbWVJZBJACgVzdGF0ZRgCIAEoDjIqLmluc3RhbGxlci5wcm90by52MS5JbnN0YWxsZXJQcm9n'
    'cmVzc1N0YXRlUgVzdGF0ZRIeCgpwZXJjZW50YWdlGAMgASgFUgpwZXJjZW50YWdlEiwKE3NwZW'
    'VkX2luX2tiX3Blcl9zZWMYBCABKAVSD3NwZWVkSW5LYlBlclNlYw==');

@$core.Deprecated('Use installerEventModelDescriptor instead')
const InstallerEventModel$json = {
  '1': 'InstallerEventModel',
  '2': [
    {'1': 'progress_changed', '3': 1, '4': 1, '5': 11, '6': '.installer.proto.v1.InstallerEventProgressChangedModel', '9': 0, '10': 'progressChanged'},
  ],
  '8': [
    {'1': 'event'},
  ],
};

/// Descriptor for `InstallerEventModel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List installerEventModelDescriptor = $convert.base64Decode(
    'ChNJbnN0YWxsZXJFdmVudE1vZGVsEmMKEHByb2dyZXNzX2NoYW5nZWQYASABKAsyNi5pbnN0YW'
    'xsZXIucHJvdG8udjEuSW5zdGFsbGVyRXZlbnRQcm9ncmVzc0NoYW5nZWRNb2RlbEgAUg9wcm9n'
    'cmVzc0NoYW5nZWRCBwoFZXZlbnQ=');

