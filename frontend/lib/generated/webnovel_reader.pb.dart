///
//  Generated code. Do not modify.
//  source: webnovel_reader.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ChapterId extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ChapterId', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'webnovel_reader'), createEmptyInstance: create)
    ..aQS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bookId')
    ..aQS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'chapterId')
  ;

  ChapterId._() : super();
  factory ChapterId({
    $core.String? bookId,
    $core.String? chapterId,
  }) {
    final _result = create();
    if (bookId != null) {
      _result.bookId = bookId;
    }
    if (chapterId != null) {
      _result.chapterId = chapterId;
    }
    return _result;
  }
  factory ChapterId.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChapterId.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChapterId clone() => ChapterId()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChapterId copyWith(void Function(ChapterId) updates) => super.copyWith((message) => updates(message as ChapterId)) as ChapterId; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ChapterId create() => ChapterId._();
  ChapterId createEmptyInstance() => create();
  static $pb.PbList<ChapterId> createRepeated() => $pb.PbList<ChapterId>();
  @$core.pragma('dart2js:noInline')
  static ChapterId getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChapterId>(create);
  static ChapterId? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get bookId => $_getSZ(0);
  @$pb.TagNumber(1)
  set bookId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBookId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBookId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get chapterId => $_getSZ(1);
  @$pb.TagNumber(2)
  set chapterId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChapterId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChapterId() => clearField(2);
}

class Chapter extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Chapter', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'webnovel_reader'), createEmptyInstance: create)
    ..aQS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bookTitle')
    ..aQS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'chapterTitle')
    ..aQS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'htmlContent')
    ..aQM<ChapterId>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'previousChapterId', subBuilder: ChapterId.create)
    ..aQM<ChapterId>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextChapterId', subBuilder: ChapterId.create)
  ;

  Chapter._() : super();
  factory Chapter({
    $core.String? bookTitle,
    $core.String? chapterTitle,
    $core.String? htmlContent,
    ChapterId? previousChapterId,
    ChapterId? nextChapterId,
  }) {
    final _result = create();
    if (bookTitle != null) {
      _result.bookTitle = bookTitle;
    }
    if (chapterTitle != null) {
      _result.chapterTitle = chapterTitle;
    }
    if (htmlContent != null) {
      _result.htmlContent = htmlContent;
    }
    if (previousChapterId != null) {
      _result.previousChapterId = previousChapterId;
    }
    if (nextChapterId != null) {
      _result.nextChapterId = nextChapterId;
    }
    return _result;
  }
  factory Chapter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Chapter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Chapter clone() => Chapter()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Chapter copyWith(void Function(Chapter) updates) => super.copyWith((message) => updates(message as Chapter)) as Chapter; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Chapter create() => Chapter._();
  Chapter createEmptyInstance() => create();
  static $pb.PbList<Chapter> createRepeated() => $pb.PbList<Chapter>();
  @$core.pragma('dart2js:noInline')
  static Chapter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Chapter>(create);
  static Chapter? _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get bookTitle => $_getSZ(0);
  @$pb.TagNumber(2)
  set bookTitle($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(2)
  $core.bool hasBookTitle() => $_has(0);
  @$pb.TagNumber(2)
  void clearBookTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get chapterTitle => $_getSZ(1);
  @$pb.TagNumber(3)
  set chapterTitle($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasChapterTitle() => $_has(1);
  @$pb.TagNumber(3)
  void clearChapterTitle() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get htmlContent => $_getSZ(2);
  @$pb.TagNumber(4)
  set htmlContent($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasHtmlContent() => $_has(2);
  @$pb.TagNumber(4)
  void clearHtmlContent() => clearField(4);

  @$pb.TagNumber(5)
  ChapterId get previousChapterId => $_getN(3);
  @$pb.TagNumber(5)
  set previousChapterId(ChapterId v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasPreviousChapterId() => $_has(3);
  @$pb.TagNumber(5)
  void clearPreviousChapterId() => clearField(5);
  @$pb.TagNumber(5)
  ChapterId ensurePreviousChapterId() => $_ensure(3);

  @$pb.TagNumber(6)
  ChapterId get nextChapterId => $_getN(4);
  @$pb.TagNumber(6)
  set nextChapterId(ChapterId v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasNextChapterId() => $_has(4);
  @$pb.TagNumber(6)
  void clearNextChapterId() => clearField(6);
  @$pb.TagNumber(6)
  ChapterId ensureNextChapterId() => $_ensure(4);
}

class GetChapterInput extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetChapterInput', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'webnovel_reader'), createEmptyInstance: create)
    ..aQM<ChapterId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'chapterId', subBuilder: ChapterId.create)
  ;

  GetChapterInput._() : super();
  factory GetChapterInput({
    ChapterId? chapterId,
  }) {
    final _result = create();
    if (chapterId != null) {
      _result.chapterId = chapterId;
    }
    return _result;
  }
  factory GetChapterInput.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetChapterInput.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetChapterInput clone() => GetChapterInput()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetChapterInput copyWith(void Function(GetChapterInput) updates) => super.copyWith((message) => updates(message as GetChapterInput)) as GetChapterInput; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetChapterInput create() => GetChapterInput._();
  GetChapterInput createEmptyInstance() => create();
  static $pb.PbList<GetChapterInput> createRepeated() => $pb.PbList<GetChapterInput>();
  @$core.pragma('dart2js:noInline')
  static GetChapterInput getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetChapterInput>(create);
  static GetChapterInput? _defaultInstance;

  @$pb.TagNumber(1)
  ChapterId get chapterId => $_getN(0);
  @$pb.TagNumber(1)
  set chapterId(ChapterId v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasChapterId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChapterId() => clearField(1);
  @$pb.TagNumber(1)
  ChapterId ensureChapterId() => $_ensure(0);
}

class GetChapterOutput extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetChapterOutput', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'webnovel_reader'), createEmptyInstance: create)
    ..aQM<Chapter>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'chapter', subBuilder: Chapter.create)
  ;

  GetChapterOutput._() : super();
  factory GetChapterOutput({
    Chapter? chapter,
  }) {
    final _result = create();
    if (chapter != null) {
      _result.chapter = chapter;
    }
    return _result;
  }
  factory GetChapterOutput.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetChapterOutput.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetChapterOutput clone() => GetChapterOutput()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetChapterOutput copyWith(void Function(GetChapterOutput) updates) => super.copyWith((message) => updates(message as GetChapterOutput)) as GetChapterOutput; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetChapterOutput create() => GetChapterOutput._();
  GetChapterOutput createEmptyInstance() => create();
  static $pb.PbList<GetChapterOutput> createRepeated() => $pb.PbList<GetChapterOutput>();
  @$core.pragma('dart2js:noInline')
  static GetChapterOutput getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetChapterOutput>(create);
  static GetChapterOutput? _defaultInstance;

  @$pb.TagNumber(1)
  Chapter get chapter => $_getN(0);
  @$pb.TagNumber(1)
  set chapter(Chapter v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasChapter() => $_has(0);
  @$pb.TagNumber(1)
  void clearChapter() => clearField(1);
  @$pb.TagNumber(1)
  Chapter ensureChapter() => $_ensure(0);
}

