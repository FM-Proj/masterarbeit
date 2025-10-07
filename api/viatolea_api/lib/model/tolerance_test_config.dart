//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ToleranceTestConfig {
  /// Returns a new [ToleranceTestConfig] instance.
  ToleranceTestConfig({
    required this.foodName,
    required this.ingredientId,
    required this.level1,
    required this.level2,
    this.level3,
    this.note,
  });

  String foodName;

  int ingredientId;

  TestLevel level1;

  TestLevel level2;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  TestLevel? level3;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? note;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToleranceTestConfig &&
          other.foodName == foodName &&
          other.ingredientId == ingredientId &&
          other.level1 == level1 &&
          other.level2 == level2 &&
          other.level3 == level3 &&
          other.note == note;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (foodName.hashCode) +
      (ingredientId.hashCode) +
      (level1.hashCode) +
      (level2.hashCode) +
      (level3 == null ? 0 : level3!.hashCode) +
      (note == null ? 0 : note!.hashCode);

  @override
  String toString() =>
      'ToleranceTestConfig[foodName=$foodName, ingredientId=$ingredientId, level1=$level1, level2=$level2, level3=$level3, note=$note]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'foodName'] = this.foodName;
    json[r'ingredientId'] = this.ingredientId;
    json[r'level1'] = this.level1;
    json[r'level2'] = this.level2;
    if (this.level3 != null) {
      json[r'level3'] = this.level3;
    } else {
      json[r'level3'] = null;
    }
    if (this.note != null) {
      json[r'note'] = this.note;
    } else {
      json[r'note'] = null;
    }
    return json;
  }

  /// Returns a new [ToleranceTestConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ToleranceTestConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ToleranceTestConfig[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ToleranceTestConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ToleranceTestConfig(
        foodName: mapValueOfType<String>(json, r'foodName')!,
        ingredientId: mapValueOfType<int>(json, r'ingredientId')!,
        level1: TestLevel.fromJson(json[r'level1'])!,
        level2: TestLevel.fromJson(json[r'level2'])!,
        level3: TestLevel.fromJson(json[r'level3']),
        note: mapValueOfType<String>(json, r'note'),
      );
    }
    return null;
  }

  static List<ToleranceTestConfig> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ToleranceTestConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ToleranceTestConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ToleranceTestConfig> mapFromJson(dynamic json) {
    final map = <String, ToleranceTestConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ToleranceTestConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ToleranceTestConfig-objects as value to a dart map
  static Map<String, List<ToleranceTestConfig>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ToleranceTestConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ToleranceTestConfig.listFromJson(
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
    'level1',
    'level2',
  };
}
