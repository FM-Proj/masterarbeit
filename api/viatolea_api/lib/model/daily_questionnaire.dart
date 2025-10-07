//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DailyQuestionnaire {
  /// Returns a new [DailyQuestionnaire] instance.
  DailyQuestionnaire({
    this.id,
    required this.date,
    this.generalWellBeing,
    this.generalGastrointestinalSymptoms,
    this.extraintestinalSymptoms,
    this.numberOfStools,
    this.noDigestionAbnormality,
    this.diarrhea,
    this.constipation,
    this.variableDigestion,
    this.medication,
    this.stressLevel,
    this.sportType,
    this.sportDurationInMinutes,
    this.mindfulnessActivity,
    this.mindfulnessDurationInMinutes,
    this.sleepInHours,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? id;

  DateTime date;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? generalWellBeing;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? generalGastrointestinalSymptoms;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? extraintestinalSymptoms;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? numberOfStools;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? noDigestionAbnormality;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? diarrhea;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? constipation;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? variableDigestion;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? medication;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? stressLevel;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? sportType;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? sportDurationInMinutes;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? mindfulnessActivity;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? mindfulnessDurationInMinutes;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? sleepInHours;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyQuestionnaire &&
          other.id == id &&
          other.date == date &&
          other.generalWellBeing == generalWellBeing &&
          other.generalGastrointestinalSymptoms ==
              generalGastrointestinalSymptoms &&
          other.extraintestinalSymptoms == extraintestinalSymptoms &&
          other.numberOfStools == numberOfStools &&
          other.noDigestionAbnormality == noDigestionAbnormality &&
          other.diarrhea == diarrhea &&
          other.constipation == constipation &&
          other.variableDigestion == variableDigestion &&
          other.medication == medication &&
          other.stressLevel == stressLevel &&
          other.sportType == sportType &&
          other.sportDurationInMinutes == sportDurationInMinutes &&
          other.mindfulnessActivity == mindfulnessActivity &&
          other.mindfulnessDurationInMinutes == mindfulnessDurationInMinutes &&
          other.sleepInHours == sleepInHours;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (id == null ? 0 : id!.hashCode) +
      (date.hashCode) +
      (generalWellBeing == null ? 0 : generalWellBeing!.hashCode) +
      (generalGastrointestinalSymptoms == null
          ? 0
          : generalGastrointestinalSymptoms!.hashCode) +
      (extraintestinalSymptoms == null
          ? 0
          : extraintestinalSymptoms!.hashCode) +
      (numberOfStools == null ? 0 : numberOfStools!.hashCode) +
      (noDigestionAbnormality == null ? 0 : noDigestionAbnormality!.hashCode) +
      (diarrhea == null ? 0 : diarrhea!.hashCode) +
      (constipation == null ? 0 : constipation!.hashCode) +
      (variableDigestion == null ? 0 : variableDigestion!.hashCode) +
      (medication == null ? 0 : medication!.hashCode) +
      (stressLevel == null ? 0 : stressLevel!.hashCode) +
      (sportType == null ? 0 : sportType!.hashCode) +
      (sportDurationInMinutes == null ? 0 : sportDurationInMinutes!.hashCode) +
      (mindfulnessActivity == null ? 0 : mindfulnessActivity!.hashCode) +
      (mindfulnessDurationInMinutes == null
          ? 0
          : mindfulnessDurationInMinutes!.hashCode) +
      (sleepInHours == null ? 0 : sleepInHours!.hashCode);

  @override
  String toString() =>
      'DailyQuestionnaire[id=$id, date=$date, generalWellBeing=$generalWellBeing, generalGastrointestinalSymptoms=$generalGastrointestinalSymptoms, extraintestinalSymptoms=$extraintestinalSymptoms, numberOfStools=$numberOfStools, noDigestionAbnormality=$noDigestionAbnormality, diarrhea=$diarrhea, constipation=$constipation, variableDigestion=$variableDigestion, medication=$medication, stressLevel=$stressLevel, sportType=$sportType, sportDurationInMinutes=$sportDurationInMinutes, mindfulnessActivity=$mindfulnessActivity, mindfulnessDurationInMinutes=$mindfulnessDurationInMinutes, sleepInHours=$sleepInHours]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    json[r'date'] = _dateFormatter.format(this.date.toUtc());
    if (this.generalWellBeing != null) {
      json[r'generalWellBeing'] = this.generalWellBeing;
    } else {
      json[r'generalWellBeing'] = null;
    }
    if (this.generalGastrointestinalSymptoms != null) {
      json[r'generalGastrointestinalSymptoms'] =
          this.generalGastrointestinalSymptoms;
    } else {
      json[r'generalGastrointestinalSymptoms'] = null;
    }
    if (this.extraintestinalSymptoms != null) {
      json[r'extraintestinalSymptoms'] = this.extraintestinalSymptoms;
    } else {
      json[r'extraintestinalSymptoms'] = null;
    }
    if (this.numberOfStools != null) {
      json[r'numberOfStools'] = this.numberOfStools;
    } else {
      json[r'numberOfStools'] = null;
    }
    if (this.noDigestionAbnormality != null) {
      json[r'noDigestionAbnormality'] = this.noDigestionAbnormality;
    } else {
      json[r'noDigestionAbnormality'] = null;
    }
    if (this.diarrhea != null) {
      json[r'diarrhea'] = this.diarrhea;
    } else {
      json[r'diarrhea'] = null;
    }
    if (this.constipation != null) {
      json[r'constipation'] = this.constipation;
    } else {
      json[r'constipation'] = null;
    }
    if (this.variableDigestion != null) {
      json[r'variableDigestion'] = this.variableDigestion;
    } else {
      json[r'variableDigestion'] = null;
    }
    if (this.medication != null) {
      json[r'medication'] = this.medication;
    } else {
      json[r'medication'] = null;
    }
    if (this.stressLevel != null) {
      json[r'stressLevel'] = this.stressLevel;
    } else {
      json[r'stressLevel'] = null;
    }
    if (this.sportType != null) {
      json[r'sportType'] = this.sportType;
    } else {
      json[r'sportType'] = null;
    }
    if (this.sportDurationInMinutes != null) {
      json[r'sportDurationInMinutes'] = this.sportDurationInMinutes;
    } else {
      json[r'sportDurationInMinutes'] = null;
    }
    if (this.mindfulnessActivity != null) {
      json[r'mindfulnessActivity'] = this.mindfulnessActivity;
    } else {
      json[r'mindfulnessActivity'] = null;
    }
    if (this.mindfulnessDurationInMinutes != null) {
      json[r'mindfulnessDurationInMinutes'] = this.mindfulnessDurationInMinutes;
    } else {
      json[r'mindfulnessDurationInMinutes'] = null;
    }
    if (this.sleepInHours != null) {
      json[r'sleepInHours'] = this.sleepInHours;
    } else {
      json[r'sleepInHours'] = null;
    }
    return json;
  }

  /// Returns a new [DailyQuestionnaire] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DailyQuestionnaire? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "DailyQuestionnaire[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "DailyQuestionnaire[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DailyQuestionnaire(
        id: mapValueOfType<int>(json, r'id'),
        date: mapDateTime(json, r'date', r'')!,
        generalWellBeing: mapValueOfType<int>(json, r'generalWellBeing'),
        generalGastrointestinalSymptoms:
            mapValueOfType<int>(json, r'generalGastrointestinalSymptoms'),
        extraintestinalSymptoms:
            mapValueOfType<String>(json, r'extraintestinalSymptoms'),
        numberOfStools: mapValueOfType<int>(json, r'numberOfStools'),
        noDigestionAbnormality:
            mapValueOfType<bool>(json, r'noDigestionAbnormality'),
        diarrhea: mapValueOfType<bool>(json, r'diarrhea'),
        constipation: mapValueOfType<bool>(json, r'constipation'),
        variableDigestion: mapValueOfType<bool>(json, r'variableDigestion'),
        medication: mapValueOfType<String>(json, r'medication'),
        stressLevel: num.parse('${json[r'stressLevel']}'),
        sportType: mapValueOfType<String>(json, r'sportType'),
        sportDurationInMinutes:
            mapValueOfType<int>(json, r'sportDurationInMinutes'),
        mindfulnessActivity:
            mapValueOfType<String>(json, r'mindfulnessActivity'),
        mindfulnessDurationInMinutes:
            mapValueOfType<int>(json, r'mindfulnessDurationInMinutes'),
        sleepInHours: num.parse('${json[r'sleepInHours']}'),
      );
    }
    return null;
  }

  static List<DailyQuestionnaire> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <DailyQuestionnaire>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DailyQuestionnaire.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DailyQuestionnaire> mapFromJson(dynamic json) {
    final map = <String, DailyQuestionnaire>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DailyQuestionnaire.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DailyQuestionnaire-objects as value to a dart map
  static Map<String, List<DailyQuestionnaire>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<DailyQuestionnaire>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DailyQuestionnaire.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'date',
  };
}
