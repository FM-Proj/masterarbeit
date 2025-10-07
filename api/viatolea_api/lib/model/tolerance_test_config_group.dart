//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ToleranceTestConfigGroup {
  /// Returns a new [ToleranceTestConfigGroup] instance.
  ToleranceTestConfigGroup({
    required this.title,
    this.testConfigs = const [],
  });

  String title;

  List<ToleranceTestConfig> testConfigs;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToleranceTestConfigGroup &&
          other.title == title &&
          _deepEquality.equals(other.testConfigs, testConfigs);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (title.hashCode) + (testConfigs.hashCode);

  @override
  String toString() =>
      'ToleranceTestConfigGroup[title=$title, testConfigs=$testConfigs]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'title'] = this.title;
    json[r'testConfigs'] = this.testConfigs;
    return json;
  }

  /// Returns a new [ToleranceTestConfigGroup] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ToleranceTestConfigGroup? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ToleranceTestConfigGroup[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ToleranceTestConfigGroup[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ToleranceTestConfigGroup(
        title: mapValueOfType<String>(json, r'title')!,
        testConfigs: ToleranceTestConfig.listFromJson(json[r'testConfigs']),
      );
    }
    return null;
  }

  static List<ToleranceTestConfigGroup> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ToleranceTestConfigGroup>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ToleranceTestConfigGroup.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ToleranceTestConfigGroup> mapFromJson(dynamic json) {
    final map = <String, ToleranceTestConfigGroup>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ToleranceTestConfigGroup.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ToleranceTestConfigGroup-objects as value to a dart map
  static Map<String, List<ToleranceTestConfigGroup>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ToleranceTestConfigGroup>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ToleranceTestConfigGroup.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'title',
    'testConfigs',
  };
}
