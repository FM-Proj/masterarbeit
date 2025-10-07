//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SymptomReportsApi {
  SymptomReportsApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Add new Symptom Report for the current user
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SymptomReport] symptomReport:
  Future<Response> addSymptomReportWithHttpInfo({
    SymptomReport? symptomReport,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/symptom-reports';

    // ignore: prefer_final_locals
    Object? postBody = symptomReport;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[
      'application/vnd.besseresser.symptomreport.post.v2+json'
    ];

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

  /// Add new Symptom Report for the current user
  ///
  /// Parameters:
  ///
  /// * [SymptomReport] symptomReport:
  Future<SymptomReport?> addSymptomReport({
    SymptomReport? symptomReport,
  }) async {
    final response = await addSymptomReportWithHttpInfo(
      symptomReport: symptomReport,
    );
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
        'SymptomReport',
      ) as SymptomReport;
    }
    return null;
  }

  /// Alter an existing SymptomReport for the current user
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] symptomReportId (required):
  ///   The id of the SymptomReport to alter
  ///
  /// * [SymptomReport] symptomReport:
  Future<Response> alterSymptomReportWithHttpInfo(
    int symptomReportId, {
    SymptomReport? symptomReport,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/symptom-reports/{symptomReportId}'
        .replaceAll('{symptomReportId}', symptomReportId.toString());

    // ignore: prefer_final_locals
    Object? postBody = symptomReport;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[
      'application/vnd.besseresser.symptomreport.put.v1+json'
    ];

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

  /// Alter an existing SymptomReport for the current user
  ///
  /// Parameters:
  ///
  /// * [int] symptomReportId (required):
  ///   The id of the SymptomReport to alter
  ///
  /// * [SymptomReport] symptomReport:
  Future<SymptomReport?> alterSymptomReport(
    int symptomReportId, {
    SymptomReport? symptomReport,
  }) async {
    final response = await alterSymptomReportWithHttpInfo(
      symptomReportId,
      symptomReport: symptomReport,
    );
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
        'SymptomReport',
      ) as SymptomReport;
    }
    return null;
  }

  /// Deletes the Symptom Report with the provided symptomReportId
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] symptomReportId (required):
  ///   The id of the Symptom Report to delete
  Future<Response> deleteSymptomReportWithHttpInfo(
    int symptomReportId,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/symptom-reports/{symptomReportId}'
        .replaceAll('{symptomReportId}', symptomReportId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Deletes the Symptom Report with the provided symptomReportId
  ///
  /// Parameters:
  ///
  /// * [int] symptomReportId (required):
  ///   The id of the Symptom Report to delete
  Future<void> deleteSymptomReport(
    int symptomReportId,
  ) async {
    final response = await deleteSymptomReportWithHttpInfo(
      symptomReportId,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// List all Symptom Reports of the current user
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> listSymptomReportsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/symptom-reports';

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

  /// List all Symptom Reports of the current user
  Future<List<SymptomReport>?> listSymptomReports() async {
    final response = await listSymptomReportsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(
              responseBody, 'List<SymptomReport>') as List)
          .cast<SymptomReport>()
          .toList(growable: false);
    }
    return null;
  }
}
