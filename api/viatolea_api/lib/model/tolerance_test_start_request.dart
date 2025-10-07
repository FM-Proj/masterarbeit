//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ToleranceTestStartRequest {
  /// Returns a new [ToleranceTestStartRequest] instance.
  ToleranceTestStartRequest({
    required this.foodName,
    required this.ingredientId,
    required this.level,
    required this.amount,
    required this.startDateTime,
  });

  String foodName;

  int ingredientId;

  int level;

  int amount;

  DateTime startDateTime;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToleranceTestStartRequest &&
          other.foodName == foodName &&
          other.ingredientId == ingredientId &&
          other.level == level &&
          other.amount == amount &&
          other.startDateTime == startDateTime;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (foodName.hashCode) +
      (ingredientId.hashCode) +
      (level.hashCode) +
      (amount.hashCode) +
      (startDateTime.hashCode);

  @override
  String toString() =>
      'ToleranceTestStartRequest[foodName=$foodName, ingredientId=$ingredientId, level=$level, amount=$amount, startDateTime=$startDateTime]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'foodName'] = this.foodName;
    json[r'ingredientId'] = this.ingredientId;
    json[r'level'] = this.level;
    json[r'amount'] = this.amount;
    json[r'startDateTime'] = this.startDateTime.toUtc().toIso8601String();
    return json;
  }

  /// Returns a new [ToleranceTestStartRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ToleranceTestStartRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ToleranceTestStartRequest[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ToleranceTestStartRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ToleranceTestStartRequest(
        foodName: mapValueOfType<String>(json, r'foodName')!,
        ingredientId: mapValueOfType<int>(json, r'ingredientId')!,
        level: mapValueOfType<int>(json, r'level')!,
        amount: mapValueOfType<int>(json, r'amount')!,
        startDateTime: mapDateTime(json, r'startDateTime', r'')!,
      );
    }
    return null;
  }

  static List<ToleranceTestStartRequest> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ToleranceTestStartRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ToleranceTestStartRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ToleranceTestStartRequest> mapFromJson(dynamic json) {
    final map = <String, ToleranceTestStartRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ToleranceTestStartRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ToleranceTestStartRequest-objects as value to a dart map
  static Map<String, List<ToleranceTestStartRequest>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ToleranceTestStartRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ToleranceTestStartRequest.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'foodName',
    'ingredientId',
    'level',
    'amount',
    'startDateTime',
  };
}
