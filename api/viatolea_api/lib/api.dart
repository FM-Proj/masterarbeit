//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library openapi.api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'api_client.dart';
part 'api_helper.dart';
part 'api_exception.dart';
part 'auth/authentication.dart';
part 'auth/api_key_auth.dart';
part 'auth/oauth.dart';
part 'auth/http_basic_auth.dart';
part 'auth/http_bearer_auth.dart';

part 'api/account_api.dart';
part 'api/analysis_api.dart';
part 'api/analysis_review_api.dart';
part 'api/daily_questionnaire_api.dart';
part 'api/ingredient_information_api.dart';
part 'api/list_accounts_api.dart';
part 'api/meals_api.dart';
part 'api/phase_api.dart';
part 'api/questionnaire_api.dart';
part 'api/symptom_reports_api.dart';
part 'api/tolerance_test_api.dart';

part 'model/account.dart';
part 'model/account_creation.dart';
part 'model/account_readonly.dart';
part 'model/allergen_analysis.dart';
part 'model/analysis.dart';
part 'model/analysis_review.dart';
part 'model/daily_questionnaire.dart';
part 'model/gluten_amount.dart';
part 'model/ingredient_information.dart';
part 'model/ingredient_information_response.dart';
part 'model/ingredient_suggestion.dart';
part 'model/ingredient_tolerance_rating.dart';
part 'model/intolerance_treatment.dart';
part 'model/meal.dart';
part 'model/meal_component.dart';
part 'model/meal_component_for_dietitian.dart';
part 'model/meal_for_dietitian.dart';
part 'model/phase.dart';
part 'model/phase_change.dart';
part 'model/phase_status.dart';
part 'model/questionnaire_response.dart';
part 'model/questionnaire_response_answer.dart';
part 'model/symptom_report.dart';
part 'model/test_level.dart';
part 'model/tolerance_test_attempt.dart';
part 'model/tolerance_test_config.dart';
part 'model/tolerance_test_config_group.dart';
part 'model/tolerance_test_start_request.dart';
part 'model/tolerance_test_stop_or_cancel_request.dart';
part 'model/tolerance_tests.dart';

/// An [ApiClient] instance that uses the default values obtained from
/// the OpenAPI specification file.
var defaultApiClient = ApiClient();

const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
const _deepEquality = DeepCollectionEquality();
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

bool _isEpochMarker(String? pattern) =>
    pattern == _dateEpochMarker || pattern == '/$_dateEpochMarker/';
