//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PhaseStatus {
  /// Returns a new [PhaseStatus] instance.
  PhaseStatus({
    this.currentPhase,
    this.intoleranceTreatment,
    this.startRecognitionPhaseDate,
    this.startEliminationPhaseDate,
    this.startTestPhaseDate,
    this.startLongTermPhaseDate,
    this.readyForNextPhase,
    this.currentPhaseLengthInDays,
    this.customMessage,
    this.customMessageActionUrl,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Phase? currentPhase;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  IntoleranceTreatment? intoleranceTreatment;

  /// The date when the user started the recognition phase
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? startRecognitionPhaseDate;

  /// The date when the user started the elimination phase
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? startEliminationPhaseDate;

  /// The date when the user started the test phase
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? startTestPhaseDate;

  /// The date when the user started the long term phase
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? startLongTermPhaseDate;

  /// Indicates if the user is ready for the next phase
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? readyForNextPhase;

  /// The length of the current phase in days
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? currentPhaseLengthInDays;

  /// A custom text for the user
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? customMessage;

  /// A custom action URL for the user
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? customMessageActionUrl;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhaseStatus &&
          other.currentPhase == currentPhase &&
          other.intoleranceTreatment == intoleranceTreatment &&
          other.startRecognitionPhaseDate == startRecognitionPhaseDate &&
          other.startEliminationPhaseDate == startEliminationPhaseDate &&
          other.startTestPhaseDate == startTestPhaseDate &&
          other.startLongTermPhaseDate == startLongTermPhaseDate &&
          other.readyForNextPhase == readyForNextPhase &&
          other.currentPhaseLengthInDays == currentPhaseLengthInDays &&
          other.customMessage == customMessage &&
          other.customMessageActionUrl == customMessageActionUrl;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (currentPhase == null ? 0 : currentPhase!.hashCode) +
      (intoleranceTreatment == null ? 0 : intoleranceTreatment!.hashCode) +
      (startRecognitionPhaseDate == null
          ? 0
          : startRecognitionPhaseDate!.hashCode) +
      (startEliminationPhaseDate == null
          ? 0
          : startEliminationPhaseDate!.hashCode) +
      (startTestPhaseDate == null ? 0 : startTestPhaseDate!.hashCode) +
      (startLongTermPhaseDate == null ? 0 : startLongTermPhaseDate!.hashCode) +
      (readyForNextPhase == null ? 0 : readyForNextPhase!.hashCode) +
      (currentPhaseLengthInDays == null
          ? 0
          : currentPhaseLengthInDays!.hashCode) +
      (customMessage == null ? 0 : customMessage!.hashCode) +
      (customMessageActionUrl == null ? 0 : customMessageActionUrl!.hashCode);

  @override
  String toString() =>
      'PhaseStatus[currentPhase=$currentPhase, intoleranceTreatment=$intoleranceTreatment, startRecognitionPhaseDate=$startRecognitionPhaseDate, startEliminationPhaseDate=$startEliminationPhaseDate, startTestPhaseDate=$startTestPhaseDate, startLongTermPhaseDate=$startLongTermPhaseDate, readyForNextPhase=$readyForNextPhase, currentPhaseLengthInDays=$currentPhaseLengthInDays, customMessage=$customMessage, customMessageActionUrl=$customMessageActionUrl]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.currentPhase != null) {
      json[r'currentPhase'] = this.currentPhase;
    } else {
      json[r'currentPhase'] = null;
    }
    if (this.intoleranceTreatment != null) {
      json[r'intoleranceTreatment'] = this.intoleranceTreatment;
    } else {
      json[r'intoleranceTreatment'] = null;
    }
    if (this.startRecognitionPhaseDate != null) {
      json[r'startRecognitionPhaseDate'] =
          _dateFormatter.format(this.startRecognitionPhaseDate!.toUtc());
    } else {
      json[r'startRecognitionPhaseDate'] = null;
    }
    if (this.startEliminationPhaseDate != null) {
      json[r'startEliminationPhaseDate'] =
          _dateFormatter.format(this.startEliminationPhaseDate!.toUtc());
    } else {
      json[r'startEliminationPhaseDate'] = null;
    }
    if (this.startTestPhaseDate != null) {
      json[r'startTestPhaseDate'] =
          _dateFormatter.format(this.startTestPhaseDate!.toUtc());
    } else {
      json[r'startTestPhaseDate'] = null;
    }
    if (this.startLongTermPhaseDate != null) {
      json[r'startLongTermPhaseDate'] =
          _dateFormatter.format(this.startLongTermPhaseDate!.toUtc());
    } else {
      json[r'startLongTermPhaseDate'] = null;
    }
    if (this.readyForNextPhase != null) {
      json[r'readyForNextPhase'] = this.readyForNextPhase;
    } else {
      json[r'readyForNextPhase'] = null;
    }
    if (this.currentPhaseLengthInDays != null) {
      json[r'currentPhaseLengthInDays'] = this.currentPhaseLengthInDays;
    } else {
      json[r'currentPhaseLengthInDays'] = null;
    }
    if (this.customMessage != null) {
      json[r'customMessage'] = this.customMessage;
    } else {
      json[r'customMessage'] = null;
    }
    if (this.customMessageActionUrl != null) {
      json[r'customMessageActionUrl'] = this.customMessageActionUrl;
    } else {
      json[r'customMessageActionUrl'] = null;
    }
    return json;
  }

  /// Returns a new [PhaseStatus] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PhaseStatus? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "PhaseStatus[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "PhaseStatus[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PhaseStatus(
        currentPhase: Phase.fromJson(json[r'currentPhase']),
        intoleranceTreatment:
            IntoleranceTreatment.fromJson(json[r'intoleranceTreatment']),
        startRecognitionPhaseDate:
            mapDateTime(json, r'startRecognitionPhaseDate', r''),
        startEliminationPhaseDate:
            mapDateTime(json, r'startEliminationPhaseDate', r''),
        startTestPhaseDate: mapDateTime(json, r'startTestPhaseDate', r''),
        startLongTermPhaseDate:
            mapDateTime(json, r'startLongTermPhaseDate', r''),
        readyForNextPhase: mapValueOfType<bool>(json, r'readyForNextPhase'),
        currentPhaseLengthInDays:
            mapValueOfType<int>(json, r'currentPhaseLengthInDays'),
        customMessage: mapValueOfType<String>(json, r'customMessage'),
        customMessageActionUrl:
            mapValueOfType<String>(json, r'customMessageActionUrl'),
      );
    }
    return null;
  }

  static List<PhaseStatus> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <PhaseStatus>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PhaseStatus.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PhaseStatus> mapFromJson(dynamic json) {
    final map = <String, PhaseStatus>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PhaseStatus.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PhaseStatus-objects as value to a dart map
  static Map<String, List<PhaseStatus>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<PhaseStatus>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PhaseStatus.listFromJson(
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
