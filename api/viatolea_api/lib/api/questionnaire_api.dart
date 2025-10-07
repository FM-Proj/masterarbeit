//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class QuestionnaireApi {
  QuestionnaireApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Create a new response to a questionnaire
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [QuestionnaireResponse] questionnaireResponse:
  Future<Response> createQuestionnaireResponseWithHttpInfo({
    QuestionnaireResponse? questionnaireResponse,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/questionnaire_responses';

    // ignore: prefer_final_locals
    Object? postBody = questionnaireResponse;

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

  /// Create a new response to a questionnaire
  ///
  /// Parameters:
  ///
  /// * [QuestionnaireResponse] questionnaireResponse:
  Future<void> createQuestionnaireResponse({
    QuestionnaireResponse? questionnaireResponse,
  }) async {
    final response = await createQuestionnaireResponseWithHttpInfo(
      questionnaireResponse: questionnaireResponse,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
