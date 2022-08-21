# openapi.api.DefaultApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createAuthenticationToken**](DefaultApi.md#createauthenticationtoken) | **POST** /user | Creates a authentication token for user
[**userDelete**](DefaultApi.md#userdelete) | **DELETE** /user | Invalidates authentication token
[**userGet**](DefaultApi.md#userget) | **GET** /user | Get user details using authentication token
[**userPut**](DefaultApi.md#userput) | **PUT** /user | Add a new user


# **createAuthenticationToken**
> User createAuthenticationToken(userCredential)

Creates a authentication token for user

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final userCredential = UserCredential(); // UserCredential | 

try {
    final result = api_instance.createAuthenticationToken(userCredential);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->createAuthenticationToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userCredential** | [**UserCredential**](UserCredential.md)|  | 

### Return type

[**User**](User.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userDelete**
> userDelete(getUserRequest)

Invalidates authentication token

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final getUserRequest = GetUserRequest(); // GetUserRequest | 

try {
    api_instance.userDelete(getUserRequest);
} catch (e) {
    print('Exception when calling DefaultApi->userDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **getUserRequest** | [**GetUserRequest**](GetUserRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userGet**
> User userGet(getUserRequest)

Get user details using authentication token

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final getUserRequest = GetUserRequest(); // GetUserRequest | 

try {
    final result = api_instance.userGet(getUserRequest);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->userGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **getUserRequest** | [**GetUserRequest**](GetUserRequest.md)|  | 

### Return type

[**User**](User.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userPut**
> User userPut(userCredential)

Add a new user

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final userCredential = UserCredential(); // UserCredential | 

try {
    final result = api_instance.userPut(userCredential);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->userPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userCredential** | [**UserCredential**](UserCredential.md)|  | 

### Return type

[**User**](User.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

