//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DailyQuestionnaireApi {
  DailyQuestionnaireApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Create a daily questionnaire
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [DailyQuestionnaire] dailyQuestionnaire:
  Future<Response> addDailyQuestionnaireWithHttpInfo({
    DailyQuestionnaire? dailyQuestionnaire,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/daily_questionnaire';

    // ignore: prefer_final_locals
    Object? postBody = dailyQuestionnaire;

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

  /// Create a daily questionnaire
  ///
  /// Parameters:
  ///
  /// * [DailyQuestionnaire] dailyQuestionnaire:
  Future<void> addDailyQuestionnaire({
    DailyQuestionnaire? dailyQuestionnaire,
  }) async {
    final response = await addDailyQuestionnaireWithHttpInfo(
      dailyQuestionnaire: dailyQuestionnaire,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
