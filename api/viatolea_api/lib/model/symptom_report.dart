//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SymptomReport {
  /// Returns a new [SymptomReport] instance.
  SymptomReport({
    this.id,
    required this.symptom,
    required this.dateTime,
    this.impairment,
    this.intoleranceCandidate,
    this.allergyCandidate,
    this.generalWarningCandidate,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? id;

  String symptom;

  DateTime dateTime;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? impairment;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? intoleranceCandidate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? allergyCandidate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? generalWarningCandidate;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SymptomReport &&
          other.id == id &&
          other.symptom == symptom &&
          other.dateTime == dateTime &&
          other.impairment == impairment &&
          other.intoleranceCandidate == intoleranceCandidate &&
          other.allergyCandidate == allergyCandidate &&
          other.generalWarningCandidate == generalWarningCandidate;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (id == null ? 0 : id!.hashCode) +
      (symptom.hashCode) +
      (dateTime.hashCode) +
      (impairment == null ? 0 : impairment!.hashCode) +
      (intoleranceCandidate == null ? 0 : intoleranceCandidate!.hashCode) +
      (allergyCandidate == null ? 0 : allergyCandidate!.hashCode) +
      (generalWarningCandidate == null ? 0 : generalWarningCandidate!.hashCode);

  @override
  String toString() =>
      'SymptomReport[id=$id, symptom=$symptom, dateTime=$dateTime, impairment=$impairment, intoleranceCandidate=$intoleranceCandidate, allergyCandidate=$allergyCandidate, generalWarningCandidate=$generalWarningCandidate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    json[r'symptom'] = this.symptom;
    json[r'dateTime'] = this.dateTime.toUtc().toIso8601String();
    if (this.impairment != null) {
      json[r'impairment'] = this.impairment;
    } else {
      json[r'impairment'] = null;
    }
    if (this.intoleranceCandidate != null) {
      json[r'intoleranceCandidate'] = this.intoleranceCandidate;
    } else {
      json[r'intoleranceCandidate'] = null;
    }
    if (this.allergyCandidate != null) {
      json[r'allergyCandidate'] = this.allergyCandidate;
    } else {
      json[r'allergyCandidate'] = null;
    }
    if (this.generalWarningCandidate != null) {
      json[r'generalWarningCandidate'] = this.generalWarningCandidate;
    } else {
      json[r'generalWarningCandidate'] = null;
    }
    return json;
  }

  /// Returns a new [SymptomReport] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SymptomReport? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "SymptomReport[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "SymptomReport[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SymptomReport(
        id: mapValueOfType<int>(json, r'id'),
        symptom: mapValueOfType<String>(json, r'symptom')!,
        dateTime: mapDateTime(json, r'dateTime', r'')!,
        impairment: mapValueOfType<int>(json, r'impairment'),
        intoleranceCandidate:
            mapValueOfType<bool>(json, r'intoleranceCandidate'),
        allergyCandidate: mapValueOfType<bool>(json, r'allergyCandidate'),
        generalWarningCandidate:
            mapValueOfType<bool>(json, r'generalWarningCandidate'),
      );
    }
    return null;
  }

  static List<SymptomReport> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <SymptomReport>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SymptomReport.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SymptomReport> mapFromJson(dynamic json) {
    final map = <String, SymptomReport>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SymptomReport.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SymptomReport-objects as value to a dart map
  static Map<String, List<SymptomReport>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<SymptomReport>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SymptomReport.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'symptom',
    'dateTime',
  };
}
