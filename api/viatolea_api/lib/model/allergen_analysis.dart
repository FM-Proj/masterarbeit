//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AllergenAnalysis {
  /// Returns a new [AllergenAnalysis] instance.
  AllergenAnalysis({
    this.probability,
    required this.sufficientData,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? probability;

  bool sufficientData;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllergenAnalysis &&
          other.probability == probability &&
          other.sufficientData == sufficientData;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (probability == null ? 0 : probability!.hashCode) +
      (sufficientData.hashCode);

  @override
  String toString() =>
      'AllergenAnalysis[probability=$probability, sufficientData=$sufficientData]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.probability != null) {
      json[r'probability'] = this.probability;
    } else {
      json[r'probability'] = null;
    }
    json[r'sufficientData'] = this.sufficientData;
    return json;
  }

  /// Returns a new [AllergenAnalysis] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AllergenAnalysis? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "AllergenAnalysis[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "AllergenAnalysis[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AllergenAnalysis(
        probability: num.parse('${json[r'probability']}'),
        sufficientData: mapValueOfType<bool>(json, r'sufficientData')!,
      );
    }
    return null;
  }

  static List<AllergenAnalysis> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <AllergenAnalysis>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AllergenAnalysis.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AllergenAnalysis> mapFromJson(dynamic json) {
    final map = <String, AllergenAnalysis>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AllergenAnalysis.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AllergenAnalysis-objects as value to a dart map
  static Map<String, List<AllergenAnalysis>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<AllergenAnalysis>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AllergenAnalysis.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'sufficientData',
  };
}
