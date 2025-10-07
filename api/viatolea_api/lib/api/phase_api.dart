//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PhaseApi {
  PhaseApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Change the current phase of the user
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PhaseChange] phaseChange:
  Future<Response> changePhaseWithHttpInfo({
    PhaseChange? phaseChange,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/phase-status/change';

    // ignore: prefer_final_locals
    Object? postBody = phaseChange;

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

  /// Change the current phase of the user
  ///
  /// Parameters:
  ///
  /// * [PhaseChange] phaseChange:
  Future<void> changePhase({
    PhaseChange? phaseChange,
  }) async {
    final response = await changePhaseWithHttpInfo(
      phaseChange: phaseChange,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get the current phase information of the user
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getCurrentPhaseWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/phase-status';

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

  /// Get the current phase information of the user
  Future<PhaseStatus?> getCurrentPhase() async {
    final response = await getCurrentPhaseWithHttpInfo();
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
        'PhaseStatus',
      ) as PhaseStatus;
    }
    return null;
  }
}
