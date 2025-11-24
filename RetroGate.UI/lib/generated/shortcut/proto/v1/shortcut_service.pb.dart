//
//  Generated code. Do not modify.
//  source: shortcut/proto/v1/shortcut_service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'shortcut_model.pb.dart' as $2;

class GetAllShortcutsResponse extends $pb.GeneratedMessage {
  factory GetAllShortcutsResponse({
    $core.Iterable<$2.ShortcutModel>? shortcuts,
  }) {
    final $result = create();
    if (shortcuts != null) {
      $result.shortcuts.addAll(shortcuts);
    }
    return $result;
  }
  GetAllShortcutsResponse._() : super();
  factory GetAllShortcutsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAllShortcutsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAllShortcutsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'shortcut.proto.v1'), createEmptyInstance: create)
    ..pc<$2.ShortcutModel>(1, _omitFieldNames ? '' : 'shortcuts', $pb.PbFieldType.PM, subBuilder: $2.ShortcutModel.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAllShortcutsResponse clone() => GetAllShortcutsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAllShortcutsResponse copyWith(void Function(GetAllShortcutsResponse) updates) => super.copyWith((message) => updates(message as GetAllShortcutsResponse)) as GetAllShortcutsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAllShortcutsResponse create() => GetAllShortcutsResponse._();
  GetAllShortcutsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAllShortcutsResponse> createRepeated() => $pb.PbList<GetAllShortcutsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAllShortcutsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAllShortcutsResponse>(create);
  static GetAllShortcutsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$2.ShortcutModel> get shortcuts => $_getList(0);
}

class CreateRequest extends $pb.GeneratedMessage {
  factory CreateRequest({
    $2.ShortcutModel? shortcut,
  }) {
    final $result = create();
    if (shortcut != null) {
      $result.shortcut = shortcut;
    }
    return $result;
  }
  CreateRequest._() : super();
  factory CreateRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'shortcut.proto.v1'), createEmptyInstance: create)
    ..aOM<$2.ShortcutModel>(1, _omitFieldNames ? '' : 'shortcut', subBuilder: $2.ShortcutModel.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateRequest clone() => CreateRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateRequest copyWith(void Function(CreateRequest) updates) => super.copyWith((message) => updates(message as CreateRequest)) as CreateRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateRequest create() => CreateRequest._();
  CreateRequest createEmptyInstance() => create();
  static $pb.PbList<CreateRequest> createRepeated() => $pb.PbList<CreateRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateRequest>(create);
  static CreateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $2.ShortcutModel get shortcut => $_getN(0);
  @$pb.TagNumber(1)
  set shortcut($2.ShortcutModel v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasShortcut() => $_has(0);
  @$pb.TagNumber(1)
  void clearShortcut() => clearField(1);
  @$pb.TagNumber(1)
  $2.ShortcutModel ensureShortcut() => $_ensure(0);
}

class CreateResponse extends $pb.GeneratedMessage {
  factory CreateResponse({
    $2.ShortcutModel? shortcut,
  }) {
    final $result = create();
    if (shortcut != null) {
      $result.shortcut = shortcut;
    }
    return $result;
  }
  CreateResponse._() : super();
  factory CreateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'shortcut.proto.v1'), createEmptyInstance: create)
    ..aOM<$2.ShortcutModel>(1, _omitFieldNames ? '' : 'shortcut', subBuilder: $2.ShortcutModel.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateResponse clone() => CreateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateResponse copyWith(void Function(CreateResponse) updates) => super.copyWith((message) => updates(message as CreateResponse)) as CreateResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateResponse create() => CreateResponse._();
  CreateResponse createEmptyInstance() => create();
  static $pb.PbList<CreateResponse> createRepeated() => $pb.PbList<CreateResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateResponse>(create);
  static CreateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $2.ShortcutModel get shortcut => $_getN(0);
  @$pb.TagNumber(1)
  set shortcut($2.ShortcutModel v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasShortcut() => $_has(0);
  @$pb.TagNumber(1)
  void clearShortcut() => clearField(1);
  @$pb.TagNumber(1)
  $2.ShortcutModel ensureShortcut() => $_ensure(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
