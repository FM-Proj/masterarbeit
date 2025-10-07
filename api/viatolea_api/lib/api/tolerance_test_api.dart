//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ToleranceTestApi {
  ToleranceTestApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// List all tolerance tests (config and attempts) of the current user
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> listToleranceTestsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/tolerance-test';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// List all tolerance tests (config and attempts) of the current user
  Future<ToleranceTests?> listToleranceTests() async {
    final response = await listToleranceTestsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'ToleranceTests',
      ) as ToleranceTests;
    }
    return null;
  }

  /// Start a new tolerance test
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ToleranceTestStartRequest] toleranceTestStartRequest:
  Future<Response> startToleranceTestWithHttpInfo({
    ToleranceTestStartRequest? toleranceTestStartRequest,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/tolerance-test';

    // ignore: prefer_final_locals
    Object? postBody = toleranceTestStartRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Start a new tolerance test
  ///
  /// Parameters:
  ///
  /// * [ToleranceTestStartRequest] toleranceTestStartRequest:
  Future<void> startToleranceTest({
    ToleranceTestStartRequest? toleranceTestStartRequest,
  }) async {
    final response = await startToleranceTestWithHttpInfo(
      toleranceTestStartRequest: toleranceTestStartRequest,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Stop a new tolerance test
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] toleranceTestId (required):
  ///   The id of the tolerance test to alter
  ///
  /// * [ToleranceTestStopOrCancelRequest] toleranceTestStopOrCancelRequest:
  Future<Response> stopOrCancelToleranceTestWithHttpInfo(
    int toleranceTestId, {
    ToleranceTestStopOrCancelRequest? toleranceTestStopOrCancelRequest,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/tolerance-test/{toleranceTestId}'
        .replaceAll('{toleranceTestId}', toleranceTestId.toString());

    // ignore: prefer_final_locals
    Object? postBody = toleranceTestStopOrCancelRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Stop a new tolerance test
  ///
  /// Parameters:
  ///
  /// * [int] toleranceTestId (required):
  ///   The id of the tolerance test to alter
  ///
  /// * [ToleranceTestStopOrCancelRequest] toleranceTestStopOrCancelRequest:
  Future<void> stopOrCancelToleranceTest(
    int toleranceTestId, {
    ToleranceTestStopOrCancelRequest? toleranceTestStopOrCancelRequest,
  }) async {
    final response = await stopOrCancelToleranceTestWithHttpInfo(
      toleranceTestId,
      toleranceTestStopOrCancelRequest: toleranceTestStopOrCancelRequest,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
