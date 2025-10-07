//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MealsApi {
  MealsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Add new Meal for the current user
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [Meal] meal:
  Future<Response> addMealWithHttpInfo({
    Meal? meal,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/meals';

    // ignore: prefer_final_locals
    Object? postBody = meal;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[
      'application/vnd.besseresser.meals.post.v3+json'
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

  /// Add new Meal for the current user
  ///
  /// Parameters:
  ///
  /// * [Meal] meal:
  Future<void> addMeal({
    Meal? meal,
  }) async {
    final response = await addMealWithHttpInfo(
      meal: meal,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Alter an existing Meal for the current user
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] mealId (required):
  ///   The id of the Meal to alter
  ///
  /// * [Meal] meal:
  Future<Response> alterMealWithHttpInfo(
    int mealId, {
    Meal? meal,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/meals/{mealId}'.replaceAll('{mealId}', mealId.toString());

    // ignore: prefer_final_locals
    Object? postBody = meal;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[
      'application/vnd.besseresser.meals.put.v1+json'
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

  /// Alter an existing Meal for the current user
  ///
  /// Parameters:
  ///
  /// * [int] mealId (required):
  ///   The id of the Meal to alter
  ///
  /// * [Meal] meal:
  Future<void> alterMeal(
    int mealId, {
    Meal? meal,
  }) async {
    final response = await alterMealWithHttpInfo(
      mealId,
      meal: meal,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Deletes the Meal with the provided mealId
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] mealId (required):
  ///   The id of the Meal to delete
  Future<Response> deleteMealWithHttpInfo(
    int mealId,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/meals/{mealId}'.replaceAll('{mealId}', mealId.toString());

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

  /// Deletes the Meal with the provided mealId
  ///
  /// Parameters:
  ///
  /// * [int] mealId (required):
  ///   The id of the Meal to delete
  Future<void> deleteMeal(
    int mealId,
  ) async {
    final response = await deleteMealWithHttpInfo(
      mealId,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get a list of suggested ingredients
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] q:
  ///   A search text for available suggestions
  Future<Response> getSuggestedIngredientsWithHttpInfo({
    String? q,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/suggested-ingredients';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (q != null) {
      queryParams.addAll(_queryParams('', 'q', q));
    }

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

  /// Get a list of suggested ingredients
  ///
  /// Parameters:
  ///
  /// * [String] q:
  ///   A search text for available suggestions
  Future<List<IngredientSuggestion>?> getSuggestedIngredients({
    String? q,
  }) async {
    final response = await getSuggestedIngredientsWithHttpInfo(
      q: q,
    );
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
              responseBody, 'List<IngredientSuggestion>') as List)
          .cast<IngredientSuggestion>()
          .toList(growable: false);
    }
    return null;
  }

  /// List all Meals of the current user
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> listMealsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/meals';

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

  /// List all Meals of the current user
  Future<List<Meal>?> listMeals() async {
    final response = await listMealsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<Meal>')
              as List)
          .cast<Meal>()
          .toList(growable: false);
    }
    return null;
  }

  /// List all Meals of the current user for a dietitian
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> listMealsForDietitianWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/meals/forDietitians';

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

  /// List all Meals of the current user for a dietitian
  Future<List<MealForDietitian>?> listMealsForDietitian() async {
    final response = await listMealsForDietitianWithHttpInfo();
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
              responseBody, 'List<MealForDietitian>') as List)
          .cast<MealForDietitian>()
          .toList(growable: false);
    }
    return null;
  }
}
