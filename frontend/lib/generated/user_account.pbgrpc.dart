///
//  Generated code. Do not modify.
//  source: user_account.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'user_account.pb.dart' as $0;
export 'user_account.pb.dart';

class UserAccountClient extends $grpc.Client {
  static final _$register =
      $grpc.ClientMethod<$0.UserCredential, $0.AuthenticationToken>(
          '/user_account.UserAccount/Register',
          ($0.UserCredential value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.AuthenticationToken.fromBuffer(value));
  static final _$login =
      $grpc.ClientMethod<$0.UserCredential, $0.AuthenticationToken>(
          '/user_account.UserAccount/Login',
          ($0.UserCredential value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.AuthenticationToken.fromBuffer(value));
  static final _$getUserDetails =
      $grpc.ClientMethod<$0.AuthenticationToken, $0.UserDetails>(
          '/user_account.UserAccount/GetUserDetails',
          ($0.AuthenticationToken value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.UserDetails.fromBuffer(value));
  static final _$logout = $grpc.ClientMethod<$0.AuthenticationToken, $0.Empty>(
      '/user_account.UserAccount/Logout',
      ($0.AuthenticationToken value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));

  UserAccountClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.AuthenticationToken> register(
      $0.UserCredential request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$register, request, options: options);
  }

  $grpc.ResponseFuture<$0.AuthenticationToken> login($0.UserCredential request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$login, request, options: options);
  }

  $grpc.ResponseFuture<$0.UserDetails> getUserDetails(
      $0.AuthenticationToken request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserDetails, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> logout($0.AuthenticationToken request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$logout, request, options: options);
  }
}

abstract class UserAccountServiceBase extends $grpc.Service {
  $core.String get $name => 'user_account.UserAccount';

  UserAccountServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.UserCredential, $0.AuthenticationToken>(
        'Register',
        register_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UserCredential.fromBuffer(value),
        ($0.AuthenticationToken value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UserCredential, $0.AuthenticationToken>(
        'Login',
        login_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UserCredential.fromBuffer(value),
        ($0.AuthenticationToken value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AuthenticationToken, $0.UserDetails>(
        'GetUserDetails',
        getUserDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AuthenticationToken.fromBuffer(value),
        ($0.UserDetails value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AuthenticationToken, $0.Empty>(
        'Logout',
        logout_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AuthenticationToken.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$0.AuthenticationToken> register_Pre(
      $grpc.ServiceCall call, $async.Future<$0.UserCredential> request) async {
    return register(call, await request);
  }

  $async.Future<$0.AuthenticationToken> login_Pre(
      $grpc.ServiceCall call, $async.Future<$0.UserCredential> request) async {
    return login(call, await request);
  }

  $async.Future<$0.UserDetails> getUserDetails_Pre($grpc.ServiceCall call,
      $async.Future<$0.AuthenticationToken> request) async {
    return getUserDetails(call, await request);
  }

  $async.Future<$0.Empty> logout_Pre($grpc.ServiceCall call,
      $async.Future<$0.AuthenticationToken> request) async {
    return logout(call, await request);
  }

  $async.Future<$0.AuthenticationToken> register(
      $grpc.ServiceCall call, $0.UserCredential request);
  $async.Future<$0.AuthenticationToken> login(
      $grpc.ServiceCall call, $0.UserCredential request);
  $async.Future<$0.UserDetails> getUserDetails(
      $grpc.ServiceCall call, $0.AuthenticationToken request);
  $async.Future<$0.Empty> logout(
      $grpc.ServiceCall call, $0.AuthenticationToken request);
}
