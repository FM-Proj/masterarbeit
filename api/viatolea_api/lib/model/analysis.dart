//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Analysis {
  /// Returns a new [Analysis] instance.
  Analysis({
    required this.fructoseAnalysis,
    required this.glutenAnalysis,
    required this.sorbitolAnalysis,
    required this.lactoseAnalysis,
    this.mealAmount = 0,
    this.symptomAmount = 0,
    this.suggestedIntoleranceTreatment,
    this.analysisMessageForPatient,
    this.analysisMessageActionUrl,
  });

  AllergenAnalysis fructoseAnalysis;

  AllergenAnalysis glutenAnalysis;

  AllergenAnalysis sorbitolAnalysis;

  AllergenAnalysis lactoseAnalysis;

  num mealAmount;

  num symptomAmount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  IntoleranceTreatment? suggestedIntoleranceTreatment;

  /// A custom message for the patient
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? analysisMessageForPatient;

  /// A custom action URL for the patient
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? analysisMessageActionUrl;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Analysis &&
          other.fructoseAnalysis == fructoseAnalysis &&
          other.glutenAnalysis == glutenAnalysis &&
          other.sorbitolAnalysis == sorbitolAnalysis &&
          other.lactoseAnalysis == lactoseAnalysis &&
          other.mealAmount == mealAmount &&
          other.symptomAmount == symptomAmount &&
          other.suggestedIntoleranceTreatment ==
              suggestedIntoleranceTreatment &&
          other.analysisMessageForPatient == analysisMessageForPatient &&
          other.analysisMessageActionUrl == analysisMessageActionUrl;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (fructoseAnalysis.hashCode) +
      (glutenAnalysis.hashCode) +
      (sorbitolAnalysis.hashCode) +
      (lactoseAnalysis.hashCode) +
      (mealAmount.hashCode) +
      (symptomAmount.hashCode) +
      (suggestedIntoleranceTreatment == null
          ? 0
          : suggestedIntoleranceTreatment!.hashCode) +
      (analysisMessageForPatient == null
          ? 0
          : analysisMessageForPatient!.hashCode) +
      (analysisMessageActionUrl == null
          ? 0
          : analysisMessageActionUrl!.hashCode);

  @override
  String toString() =>
      'Analysis[fructoseAnalysis=$fructoseAnalysis, glutenAnalysis=$glutenAnalysis, sorbitolAnalysis=$sorbitolAnalysis, lactoseAnalysis=$lactoseAnalysis, mealAmount=$mealAmount, symptomAmount=$symptomAmount, suggestedIntoleranceTreatment=$suggestedIntoleranceTreatment, analysisMessageForPatient=$analysisMessageForPatient, analysisMessageActionUrl=$analysisMessageActionUrl]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'fructoseAnalysis'] = this.fructoseAnalysis;
    json[r'glutenAnalysis'] = this.glutenAnalysis;
    json[r'sorbitolAnalysis'] = this.sorbitolAnalysis;
    json[r'lactoseAnalysis'] = this.lactoseAnalysis;
    json[r'mealAmount'] = this.mealAmount;
    json[r'symptomAmount'] = this.symptomAmount;
    if (this.suggestedIntoleranceTreatment != null) {
      json[r'suggestedIntoleranceTreatment'] =
          this.suggestedIntoleranceTreatment;
    } else {
      json[r'suggestedIntoleranceTreatment'] = null;
    }
    if (this.analysisMessageForPatient != null) {
      json[r'analysisMessageForPatient'] = this.analysisMessageForPatient;
    } else {
      json[r'analysisMessageForPatient'] = null;
    }
    if (this.analysisMessageActionUrl != null) {
      json[r'analysisMessageActionUrl'] = this.analysisMessageActionUrl;
    } else {
      json[r'analysisMessageActionUrl'] = null;
    }
    return json;
  }

  /// Returns a new [Analysis] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Analysis? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "Analysis[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "Analysis[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Analysis(
        fructoseAnalysis: AllergenAnalysis.fromJson(json[r'fructoseAnalysis'])!,
        glutenAnalysis: AllergenAnalysis.fromJson(json[r'glutenAnalysis'])!,
        sorbitolAnalysis: AllergenAnalysis.fromJson(json[r'sorbitolAnalysis'])!,
        lactoseAnalysis: AllergenAnalysis.fromJson(json[r'lactoseAnalysis'])!,
        mealAmount: num.parse('${json[r'mealAmount']}'),
        symptomAmount: num.parse('${json[r'symptomAmount']}'),
        suggestedIntoleranceTreatment: IntoleranceTreatment.fromJson(
            json[r'suggestedIntoleranceTreatment']),
        analysisMessageForPatient:
            mapValueOfType<String>(json, r'analysisMessageForPatient'),
        analysisMessageActionUrl:
            mapValueOfType<String>(json, r'analysisMessageActionUrl'),
      );
    }
    return null;
  }

  static List<Analysis> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <Analysis>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Analysis.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Analysis> mapFromJson(dynamic json) {
    final map = <String, Analysis>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Analysis.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Analysis-objects as value to a dart map
  static Map<String, List<Analysis>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<Analysis>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Analysis.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'fructoseAnalysis',
    'glutenAnalysis',
    'sorbitolAnalysis',
    'lactoseAnalysis',
    'mealAmount',
    'symptomAmount',
  };
}
