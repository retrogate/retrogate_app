//
//  Generated code. Do not modify.
//  source: installer/proto/v1/installer_event_model.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class InstallerProgressState extends $pb.ProtobufEnum {
  static const InstallerProgressState INSTALLER_PROGRESS_STATE_IDLE = InstallerProgressState._(0, _omitEnumNames ? '' : 'INSTALLER_PROGRESS_STATE_IDLE');
  static const InstallerProgressState INSTALLER_PROGRESS_STATE_DOWNLOADING = InstallerProgressState._(1, _omitEnumNames ? '' : 'INSTALLER_PROGRESS_STATE_DOWNLOADING');
  static const InstallerProgressState INSTALLER_PROGRESS_STATE_PENDING = InstallerProgressState._(2, _omitEnumNames ? '' : 'INSTALLER_PROGRESS_STATE_PENDING');
  static const InstallerProgressState INSTALLER_PROGRESS_STATE_EXTRACTING = InstallerProgressState._(3, _omitEnumNames ? '' : 'INSTALLER_PROGRESS_STATE_EXTRACTING');
  static const InstallerProgressState INSTALLER_PROGRESS_STATE_CREATING_SHORTCUT = InstallerProgressState._(4, _omitEnumNames ? '' : 'INSTALLER_PROGRESS_STATE_CREATING_SHORTCUT');
  static const InstallerProgressState INSTALLER_PROGRESS_STATE_PAUSED = InstallerProgressState._(5, _omitEnumNames ? '' : 'INSTALLER_PROGRESS_STATE_PAUSED');
  static const InstallerProgressState INSTALLER_PROGRESS_STATE_COMPLETED = InstallerProgressState._(6, _omitEnumNames ? '' : 'INSTALLER_PROGRESS_STATE_COMPLETED');
  static const InstallerProgressState INSTALLER_PROGRESS_STATE_FAILED = InstallerProgressState._(7, _omitEnumNames ? '' : 'INSTALLER_PROGRESS_STATE_FAILED');
  static const InstallerProgressState INSTALLER_PROGRESS_STATE_CANCELLED = InstallerProgressState._(8, _omitEnumNames ? '' : 'INSTALLER_PROGRESS_STATE_CANCELLED');
  static const InstallerProgressState INSTALLER_PROGRESS_STATE_UNINSTALLED = InstallerProgressState._(9, _omitEnumNames ? '' : 'INSTALLER_PROGRESS_STATE_UNINSTALLED');

  static const $core.List<InstallerProgressState> values = <InstallerProgressState> [
    INSTALLER_PROGRESS_STATE_IDLE,
    INSTALLER_PROGRESS_STATE_DOWNLOADING,
    INSTALLER_PROGRESS_STATE_PENDING,
    INSTALLER_PROGRESS_STATE_EXTRACTING,
    INSTALLER_PROGRESS_STATE_CREATING_SHORTCUT,
    INSTALLER_PROGRESS_STATE_PAUSED,
    INSTALLER_PROGRESS_STATE_COMPLETED,
    INSTALLER_PROGRESS_STATE_FAILED,
    INSTALLER_PROGRESS_STATE_CANCELLED,
    INSTALLER_PROGRESS_STATE_UNINSTALLED,
  ];

  static final $core.Map<$core.int, InstallerProgressState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static InstallerProgressState? valueOf($core.int value) => _byValue[value];

  const InstallerProgressState._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
