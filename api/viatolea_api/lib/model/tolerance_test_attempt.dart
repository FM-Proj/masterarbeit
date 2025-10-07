//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ToleranceTestAttempt {
  /// Returns a new [ToleranceTestAttempt] instance.
  ToleranceTestAttempt({
    required this.id,
    required this.ingredientId,
    required this.foodName,
    required this.level,
    required this.amount,
    this.passed,
    required this.startDateTime,
    this.endDateTime,
  });

  int id;

  int ingredientId;

  String foodName;

  int level;

  int amount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? passed;

  DateTime startDateTime;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? endDateTime;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToleranceTestAttempt &&
          other.id == id &&
          other.ingredientId == ingredientId &&
          other.foodName == foodName &&
          other.level == level &&
          other.amount == amount &&
          other.passed == passed &&
          other.startDateTime == startDateTime &&
          other.endDateTime == endDateTime;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (id.hashCode) +
      (ingredientId.hashCode) +
      (foodName.hashCode) +
      (level.hashCode) +
      (amount.hashCode) +
      (passed == null ? 0 : passed!.hashCode) +
      (startDateTime.hashCode) +
      (endDateTime == null ? 0 : endDateTime!.hashCode);

  @override
  String toString() =>
      'ToleranceTestAttempt[id=$id, ingredientId=$ingredientId, foodName=$foodName, level=$level, amount=$amount, passed=$passed, startDateTime=$startDateTime, endDateTime=$endDateTime]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'id'] = this.id;
    json[r'ingredientId'] = this.ingredientId;
    json[r'foodName'] = this.foodName;
    json[r'level'] = this.level;
    json[r'amount'] = this.amount;
    if (this.passed != null) {
      json[r'passed'] = this.passed;
    } else {
      json[r'passed'] = null;
    }
    json[r'startDateTime'] = this.startDateTime.toUtc().toIso8601String();
    if (this.endDateTime != null) {
      json[r'endDateTime'] = this.endDateTime!.toUtc().toIso8601String();
    } else {
      json[r'endDateTime'] = null;
    }
    return json;
  }

  /// Returns a new [ToleranceTestAttempt] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ToleranceTestAttempt? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ToleranceTestAttempt[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ToleranceTestAttempt[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ToleranceTestAttempt(
        id: mapValueOfType<int>(json, r'id')!,
        ingredientId: mapValueOfType<int>(json, r'ingredientId')!,
        foodName: mapValueOfType<String>(json, r'foodName')!,
        level: mapValueOfType<int>(json, r'level')!,
        amount: mapValueOfType<int>(json, r'amount')!,
        passed: mapValueOfType<bool>(json, r'passed'),
        startDateTime: mapDateTime(json, r'startDateTime', r'')!,
        endDateTime: mapDateTime(json, r'endDateTime', r''),
      );
    }
    return null;
  }

  static List<ToleranceTestAttempt> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ToleranceTestAttempt>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ToleranceTestAttempt.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ToleranceTestAttempt> mapFromJson(dynamic json) {
    final map = <String, ToleranceTestAttempt>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ToleranceTestAttempt.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ToleranceTestAttempt-objects as value to a dart map
  static Map<String, List<ToleranceTestAttempt>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ToleranceTestAttempt>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ToleranceTestAttempt.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'ingredientId',
    'foodName',
    'level',
    'amount',
    'startDateTime',
  };
}
