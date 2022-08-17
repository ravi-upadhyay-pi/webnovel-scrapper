///
//  Generated code. Do not modify.
//  source: webnovel_reader.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use chapterIdDescriptor instead')
const ChapterId$json = const {
  '1': 'ChapterId',
  '2': const [
    const {'1': 'book_id', '3': 1, '4': 2, '5': 9, '10': 'bookId'},
    const {'1': 'chapter_id', '3': 2, '4': 2, '5': 9, '10': 'chapterId'},
  ],
};

/// Descriptor for `ChapterId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chapterIdDescriptor = $convert.base64Decode('CglDaGFwdGVySWQSFwoHYm9va19pZBgBIAIoCVIGYm9va0lkEh0KCmNoYXB0ZXJfaWQYAiACKAlSCWNoYXB0ZXJJZA==');
@$core.Deprecated('Use chapterDescriptor instead')
const Chapter$json = const {
  '1': 'Chapter',
  '2': const [
    const {'1': 'book_title', '3': 2, '4': 2, '5': 9, '10': 'bookTitle'},
    const {'1': 'chapter_title', '3': 3, '4': 2, '5': 9, '10': 'chapterTitle'},
    const {'1': 'html_content', '3': 4, '4': 2, '5': 9, '10': 'htmlContent'},
    const {'1': 'previous_chapter_id', '3': 5, '4': 2, '5': 11, '6': '.webnovel_reader.ChapterId', '10': 'previousChapterId'},
    const {'1': 'next_chapter_id', '3': 6, '4': 2, '5': 11, '6': '.webnovel_reader.ChapterId', '10': 'nextChapterId'},
  ],
};

/// Descriptor for `Chapter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chapterDescriptor = $convert.base64Decode('CgdDaGFwdGVyEh0KCmJvb2tfdGl0bGUYAiACKAlSCWJvb2tUaXRsZRIjCg1jaGFwdGVyX3RpdGxlGAMgAigJUgxjaGFwdGVyVGl0bGUSIQoMaHRtbF9jb250ZW50GAQgAigJUgtodG1sQ29udGVudBJKChNwcmV2aW91c19jaGFwdGVyX2lkGAUgAigLMhoud2Vibm92ZWxfcmVhZGVyLkNoYXB0ZXJJZFIRcHJldmlvdXNDaGFwdGVySWQSQgoPbmV4dF9jaGFwdGVyX2lkGAYgAigLMhoud2Vibm92ZWxfcmVhZGVyLkNoYXB0ZXJJZFINbmV4dENoYXB0ZXJJZA==');
@$core.Deprecated('Use getChapterInputDescriptor instead')
const GetChapterInput$json = const {
  '1': 'GetChapterInput',
  '2': const [
    const {'1': 'chapter_id', '3': 1, '4': 2, '5': 11, '6': '.webnovel_reader.ChapterId', '10': 'chapterId'},
  ],
};

/// Descriptor for `GetChapterInput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getChapterInputDescriptor = $convert.base64Decode('Cg9HZXRDaGFwdGVySW5wdXQSOQoKY2hhcHRlcl9pZBgBIAIoCzIaLndlYm5vdmVsX3JlYWRlci5DaGFwdGVySWRSCWNoYXB0ZXJJZA==');
@$core.Deprecated('Use getChapterOutputDescriptor instead')
const GetChapterOutput$json = const {
  '1': 'GetChapterOutput',
  '2': const [
    const {'1': 'chapter', '3': 1, '4': 2, '5': 11, '6': '.webnovel_reader.Chapter', '10': 'chapter'},
  ],
};

/// Descriptor for `GetChapterOutput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getChapterOutputDescriptor = $convert.base64Decode('ChBHZXRDaGFwdGVyT3V0cHV0EjIKB2NoYXB0ZXIYASACKAsyGC53ZWJub3ZlbF9yZWFkZXIuQ2hhcHRlclIHY2hhcHRlcg==');
