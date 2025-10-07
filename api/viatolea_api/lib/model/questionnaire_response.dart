//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class QuestionnaireResponse {
  /// Returns a new [QuestionnaireResponse] instance.
  QuestionnaireResponse({
    required this.questionnaireName,
    required this.questionnaireVersion,
    required this.triggerEvent,
    this.answers = const [],
  });

  String questionnaireName;

  String questionnaireVersion;

  String triggerEvent;

  List<QuestionnaireResponseAnswer> answers;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionnaireResponse &&
          other.questionnaireName == questionnaireName &&
          other.questionnaireVersion == questionnaireVersion &&
          other.triggerEvent == triggerEvent &&
          _deepEquality.equals(other.answers, answers);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (questionnaireName.hashCode) +
      (questionnaireVersion.hashCode) +
      (triggerEvent.hashCode) +
      (answers.hashCode);

  @override
  String toString() =>
      'QuestionnaireResponse[questionnaireName=$questionnaireName, questionnaireVersion=$questionnaireVersion, triggerEvent=$triggerEvent, answers=$answers]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'questionnaireName'] = this.questionnaireName;
    json[r'questionnaireVersion'] = this.questionnaireVersion;
    json[r'triggerEvent'] = this.triggerEvent;
    json[r'answers'] = this.answers;
    return json;
  }

  /// Returns a new [QuestionnaireResponse] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static QuestionnaireResponse? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "QuestionnaireResponse[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "QuestionnaireResponse[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return QuestionnaireResponse(
        questionnaireName: mapValueOfType<String>(json, r'questionnaireName')!,
        questionnaireVersion:
            mapValueOfType<String>(json, r'questionnaireVersion')!,
        triggerEvent: mapValueOfType<String>(json, r'triggerEvent')!,
        answers: QuestionnaireResponseAnswer.listFromJson(json[r'answers']),
      );
    }
    return null;
  }

  static List<QuestionnaireResponse> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <QuestionnaireResponse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = QuestionnaireResponse.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, QuestionnaireResponse> mapFromJson(dynamic json) {
    final map = <String, QuestionnaireResponse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = QuestionnaireResponse.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of QuestionnaireResponse-objects as value to a dart map
  static Map<String, List<QuestionnaireResponse>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<QuestionnaireResponse>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = QuestionnaireResponse.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'questionnaireName',
    'questionnaireVersion',
    'triggerEvent',
    'answers',
  };
}
