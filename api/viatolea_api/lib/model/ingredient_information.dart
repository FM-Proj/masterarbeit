//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class IngredientInformation {
  /// Returns a new [IngredientInformation] instance.
  IngredientInformation({
    this.name,
    this.ingredientId,
    this.fructoseRating,
    this.lactoseRating,
    this.sorbitRating,
    this.glutenRating,
    this.fructoseGlucoseRatioRating,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? ingredientId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  IngredientToleranceRating? fructoseRating;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  IngredientToleranceRating? lactoseRating;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  IngredientToleranceRating? sorbitRating;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  IngredientToleranceRating? glutenRating;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  IngredientToleranceRating? fructoseGlucoseRatioRating;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientInformation &&
          other.name == name &&
          other.ingredientId == ingredientId &&
          other.fructoseRating == fructoseRating &&
          other.lactoseRating == lactoseRating &&
          other.sorbitRating == sorbitRating &&
          other.glutenRating == glutenRating &&
          other.fructoseGlucoseRatioRating == fructoseGlucoseRatioRating;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (name == null ? 0 : name!.hashCode) +
      (ingredientId == null ? 0 : ingredientId!.hashCode) +
      (fructoseRating == null ? 0 : fructoseRating!.hashCode) +
      (lactoseRating == null ? 0 : lactoseRating!.hashCode) +
      (sorbitRating == null ? 0 : sorbitRating!.hashCode) +
      (glutenRating == null ? 0 : glutenRating!.hashCode) +
      (fructoseGlucoseRatioRating == null
          ? 0
          : fructoseGlucoseRatioRating!.hashCode);

  @override
  String toString() =>
      'IngredientInformation[name=$name, ingredientId=$ingredientId, fructoseRating=$fructoseRating, lactoseRating=$lactoseRating, sorbitRating=$sorbitRating, glutenRating=$glutenRating, fructoseGlucoseRatioRating=$fructoseGlucoseRatioRating]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.ingredientId != null) {
      json[r'ingredientId'] = this.ingredientId;
    } else {
      json[r'ingredientId'] = null;
    }
    if (this.fructoseRating != null) {
      json[r'fructoseRating'] = this.fructoseRating;
    } else {
      json[r'fructoseRating'] = null;
    }
    if (this.lactoseRating != null) {
      json[r'lactoseRating'] = this.lactoseRating;
    } else {
      json[r'lactoseRating'] = null;
    }
    if (this.sorbitRating != null) {
      json[r'sorbitRating'] = this.sorbitRating;
    } else {
      json[r'sorbitRating'] = null;
    }
    if (this.glutenRating != null) {
      json[r'glutenRating'] = this.glutenRating;
    } else {
      json[r'glutenRating'] = null;
    }
    if (this.fructoseGlucoseRatioRating != null) {
      json[r'fructoseGlucoseRatioRating'] = this.fructoseGlucoseRatioRating;
    } else {
      json[r'fructoseGlucoseRatioRating'] = null;
    }
    return json;
  }

  /// Returns a new [IngredientInformation] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static IngredientInformation? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "IngredientInformation[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "IngredientInformation[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return IngredientInformation(
        name: mapValueOfType<String>(json, r'name'),
        ingredientId: mapValueOfType<int>(json, r'ingredientId'),
        fructoseRating:
            IngredientToleranceRating.fromJson(json[r'fructoseRating']),
        lactoseRating:
            IngredientToleranceRating.fromJson(json[r'lactoseRating']),
        sorbitRating: IngredientToleranceRating.fromJson(json[r'sorbitRating']),
        glutenRating: IngredientToleranceRating.fromJson(json[r'glutenRating']),
        fructoseGlucoseRatioRating: IngredientToleranceRating.fromJson(
            json[r'fructoseGlucoseRatioRating']),
      );
    }
    return null;
  }

  static List<IngredientInformation> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <IngredientInformation>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = IngredientInformation.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, IngredientInformation> mapFromJson(dynamic json) {
    final map = <String, IngredientInformation>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = IngredientInformation.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of IngredientInformation-objects as value to a dart map
  static Map<String, List<IngredientInformation>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<IngredientInformation>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = IngredientInformation.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{};
}
