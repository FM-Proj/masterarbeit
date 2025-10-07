//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Meal {
  /// Returns a new [Meal] instance.
  Meal({
    this.id,
    required this.dateTime,
    this.mealComponents = const [],
    this.note,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? id;

  DateTime dateTime;

  List<MealComponent> mealComponents;

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
      other is Meal &&
          other.id == id &&
          other.dateTime == dateTime &&
          _deepEquality.equals(other.mealComponents, mealComponents) &&
          other.note == note;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (id == null ? 0 : id!.hashCode) +
      (dateTime.hashCode) +
      (mealComponents.hashCode) +
      (note == null ? 0 : note!.hashCode);

  @override
  String toString() =>
      'Meal[id=$id, dateTime=$dateTime, mealComponents=$mealComponents, note=$note]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    json[r'dateTime'] = this.dateTime.toUtc().toIso8601String();
    json[r'mealComponents'] = this.mealComponents;
    if (this.note != null) {
      json[r'note'] = this.note;
    } else {
      json[r'note'] = null;
    }
    return json;
  }

  /// Returns a new [Meal] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Meal? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "Meal[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "Meal[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Meal(
        id: mapValueOfType<int>(json, r'id'),
        dateTime: mapDateTime(json, r'dateTime', r'')!,
        mealComponents: MealComponent.listFromJson(json[r'mealComponents']),
        note: mapValueOfType<String>(json, r'note'),
      );
    }
    return null;
  }

  static List<Meal> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <Meal>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Meal.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Meal> mapFromJson(dynamic json) {
    final map = <String, Meal>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Meal.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Meal-objects as value to a dart map
  static Map<String, List<Meal>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<Meal>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Meal.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'dateTime',
  };
}
