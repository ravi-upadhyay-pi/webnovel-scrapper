///
//  Generated code. Do not modify.
//  source: webnovel_reader.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'webnovel_reader.pb.dart' as $1;
export 'webnovel_reader.pb.dart';

class WebnovelReaderClient extends $grpc.Client {
  static final _$getChapter =
      $grpc.ClientMethod<$1.GetChapterInput, $1.GetChapterOutput>(
          '/webnovel_reader.WebnovelReader/GetChapter',
          ($1.GetChapterInput value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.GetChapterOutput.fromBuffer(value));

  WebnovelReaderClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.GetChapterOutput> getChapter(
      $1.GetChapterInput request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getChapter, request, options: options);
  }
}

abstract class WebnovelReaderServiceBase extends $grpc.Service {
  $core.String get $name => 'webnovel_reader.WebnovelReader';

  WebnovelReaderServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.GetChapterInput, $1.GetChapterOutput>(
        'GetChapter',
        getChapter_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetChapterInput.fromBuffer(value),
        ($1.GetChapterOutput value) => value.writeToBuffer()));
  }

  $async.Future<$1.GetChapterOutput> getChapter_Pre(
      $grpc.ServiceCall call, $async.Future<$1.GetChapterInput> request) async {
    return getChapter(call, await request);
  }

  $async.Future<$1.GetChapterOutput> getChapter(
      $grpc.ServiceCall call, $1.GetChapterInput request);
}
