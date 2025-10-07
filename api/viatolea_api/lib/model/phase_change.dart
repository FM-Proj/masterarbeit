//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PhaseChange {
  /// Returns a new [PhaseChange] instance.
  PhaseChange({
    required this.newPhase,
  });

  Phase newPhase;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhaseChange && other.newPhase == newPhase;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (newPhase.hashCode);

  @override
  String toString() => 'PhaseChange[newPhase=$newPhase]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'newPhase'] = this.newPhase;
    return json;
  }

  /// Returns a new [PhaseChange] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PhaseChange? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "PhaseChange[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "PhaseChange[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PhaseChange(
        newPhase: Phase.fromJson(json[r'newPhase'])!,
      );
    }
    return null;
  }

  static List<PhaseChange> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <PhaseChange>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PhaseChange.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PhaseChange> mapFromJson(dynamic json) {
    final map = <String, PhaseChange>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PhaseChange.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PhaseChange-objects as value to a dart map
  static Map<String, List<PhaseChange>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<PhaseChange>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PhaseChange.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'newPhase',
  };
}
