///
//  Generated code. Do not modify.
//  source: user_account.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use userCredentialDescriptor instead')
const UserCredential$json = const {
  '1': 'UserCredential',
  '2': const [
    const {'1': 'username', '3': 1, '4': 2, '5': 9, '10': 'username'},
    const {'1': 'password', '3': 2, '4': 2, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `UserCredential`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userCredentialDescriptor = $convert.base64Decode('Cg5Vc2VyQ3JlZGVudGlhbBIaCgh1c2VybmFtZRgBIAIoCVIIdXNlcm5hbWUSGgoIcGFzc3dvcmQYAiACKAlSCHBhc3N3b3Jk');
@$core.Deprecated('Use authenticationTokenDescriptor instead')
const AuthenticationToken$json = const {
  '1': 'AuthenticationToken',
  '2': const [
    const {'1': 'token', '3': 1, '4': 2, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `AuthenticationToken`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authenticationTokenDescriptor = $convert.base64Decode('ChNBdXRoZW50aWNhdGlvblRva2VuEhQKBXRva2VuGAEgAigJUgV0b2tlbg==');
@$core.Deprecated('Use userDetailsDescriptor instead')
const UserDetails$json = const {
  '1': 'UserDetails',
  '2': const [
    const {'1': 'username', '3': 1, '4': 2, '5': 9, '10': 'username'},
    const {'1': 'user_id', '3': 2, '4': 2, '5': 3, '10': 'userId'},
  ],
};

/// Descriptor for `UserDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDetailsDescriptor = $convert.base64Decode('CgtVc2VyRGV0YWlscxIaCgh1c2VybmFtZRgBIAIoCVIIdXNlcm5hbWUSFwoHdXNlcl9pZBgCIAIoA1IGdXNlcklk');
@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = const {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor = $convert.base64Decode('CgVFbXB0eQ==');
