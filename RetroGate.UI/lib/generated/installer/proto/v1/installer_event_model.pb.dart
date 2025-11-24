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

import 'installer_event_model.pbenum.dart';

export 'installer_event_model.pbenum.dart';

class InstallerEventProgressChangedModel extends $pb.GeneratedMessage {
  factory InstallerEventProgressChangedModel({
    $core.String? gameId,
    InstallerProgressState? state,
    $core.int? percentage,
    $core.int? speedInKbPerSec,
  }) {
    final $result = create();
    if (gameId != null) {
      $result.gameId = gameId;
    }
    if (state != null) {
      $result.state = state;
    }
    if (percentage != null) {
      $result.percentage = percentage;
    }
    if (speedInKbPerSec != null) {
      $result.speedInKbPerSec = speedInKbPerSec;
    }
    return $result;
  }
  InstallerEventProgressChangedModel._() : super();
  factory InstallerEventProgressChangedModel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InstallerEventProgressChangedModel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InstallerEventProgressChangedModel', package: const $pb.PackageName(_omitMessageNames ? '' : 'installer.proto.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'gameId')
    ..e<InstallerProgressState>(2, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: InstallerProgressState.INSTALLER_PROGRESS_STATE_IDLE, valueOf: InstallerProgressState.valueOf, enumValues: InstallerProgressState.values)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'percentage', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'speedInKbPerSec', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InstallerEventProgressChangedModel clone() => InstallerEventProgressChangedModel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InstallerEventProgressChangedModel copyWith(void Function(InstallerEventProgressChangedModel) updates) => super.copyWith((message) => updates(message as InstallerEventProgressChangedModel)) as InstallerEventProgressChangedModel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstallerEventProgressChangedModel create() => InstallerEventProgressChangedModel._();
  InstallerEventProgressChangedModel createEmptyInstance() => create();
  static $pb.PbList<InstallerEventProgressChangedModel> createRepeated() => $pb.PbList<InstallerEventProgressChangedModel>();
  @$core.pragma('dart2js:noInline')
  static InstallerEventProgressChangedModel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InstallerEventProgressChangedModel>(create);
  static InstallerEventProgressChangedModel? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get gameId => $_getSZ(0);
  @$pb.TagNumber(1)
  set gameId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGameId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameId() => clearField(1);

  @$pb.TagNumber(2)
  InstallerProgressState get state => $_getN(1);
  @$pb.TagNumber(2)
  set state(InstallerProgressState v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get percentage => $_getIZ(2);
  @$pb.TagNumber(3)
  set percentage($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPercentage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPercentage() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get speedInKbPerSec => $_getIZ(3);
  @$pb.TagNumber(4)
  set speedInKbPerSec($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSpeedInKbPerSec() => $_has(3);
  @$pb.TagNumber(4)
  void clearSpeedInKbPerSec() => clearField(4);
}

enum InstallerEventModel_Event {
  progressChanged, 
  notSet
}

class InstallerEventModel extends $pb.GeneratedMessage {
  factory InstallerEventModel({
    InstallerEventProgressChangedModel? progressChanged,
  }) {
    final $result = create();
    if (progressChanged != null) {
      $result.progressChanged = progressChanged;
    }
    return $result;
  }
  InstallerEventModel._() : super();
  factory InstallerEventModel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InstallerEventModel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, InstallerEventModel_Event> _InstallerEventModel_EventByTag = {
    1 : InstallerEventModel_Event.progressChanged,
    0 : InstallerEventModel_Event.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InstallerEventModel', package: const $pb.PackageName(_omitMessageNames ? '' : 'installer.proto.v1'), createEmptyInstance: create)
    ..oo(0, [1])
    ..aOM<InstallerEventProgressChangedModel>(1, _omitFieldNames ? '' : 'progressChanged', subBuilder: InstallerEventProgressChangedModel.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InstallerEventModel clone() => InstallerEventModel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InstallerEventModel copyWith(void Function(InstallerEventModel) updates) => super.copyWith((message) => updates(message as InstallerEventModel)) as InstallerEventModel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstallerEventModel create() => InstallerEventModel._();
  InstallerEventModel createEmptyInstance() => create();
  static $pb.PbList<InstallerEventModel> createRepeated() => $pb.PbList<InstallerEventModel>();
  @$core.pragma('dart2js:noInline')
  static InstallerEventModel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InstallerEventModel>(create);
  static InstallerEventModel? _defaultInstance;

  InstallerEventModel_Event whichEvent() => _InstallerEventModel_EventByTag[$_whichOneof(0)]!;
  void clearEvent() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  InstallerEventProgressChangedModel get progressChanged => $_getN(0);
  @$pb.TagNumber(1)
  set progressChanged(InstallerEventProgressChangedModel v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasProgressChanged() => $_has(0);
  @$pb.TagNumber(1)
  void clearProgressChanged() => clearField(1);
  @$pb.TagNumber(1)
  InstallerEventProgressChangedModel ensureProgressChanged() => $_ensure(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
