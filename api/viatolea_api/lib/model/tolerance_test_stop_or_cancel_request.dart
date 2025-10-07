//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ToleranceTestStopOrCancelRequest {
  /// Returns a new [ToleranceTestStopOrCancelRequest] instance.
  ToleranceTestStopOrCancelRequest({
    required this.stopDateTime,
    this.passed,
    this.cancelled,
  });

  DateTime stopDateTime;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? passed;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? cancelled;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToleranceTestStopOrCancelRequest &&
          other.stopDateTime == stopDateTime &&
          other.passed == passed &&
          other.cancelled == cancelled;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (stopDateTime.hashCode) +
      (passed == null ? 0 : passed!.hashCode) +
      (cancelled == null ? 0 : cancelled!.hashCode);

  @override
  String toString() =>
      'ToleranceTestStopOrCancelRequest[stopDateTime=$stopDateTime, passed=$passed, cancelled=$cancelled]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'stopDateTime'] = this.stopDateTime.toUtc().toIso8601String();
    if (this.passed != null) {
      json[r'passed'] = this.passed;
    } else {
      json[r'passed'] = null;
    }
    if (this.cancelled != null) {
      json[r'cancelled'] = this.cancelled;
    } else {
      json[r'cancelled'] = null;
    }
    return json;
  }

  /// Returns a new [ToleranceTestStopOrCancelRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ToleranceTestStopOrCancelRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ToleranceTestStopOrCancelRequest[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ToleranceTestStopOrCancelRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ToleranceTestStopOrCancelRequest(
        stopDateTime: mapDateTime(json, r'stopDateTime', r'')!,
        passed: mapValueOfType<bool>(json, r'passed'),
        cancelled: mapValueOfType<bool>(json, r'cancelled'),
      );
    }
    return null;
  }

  static List<ToleranceTestStopOrCancelRequest> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ToleranceTestStopOrCancelRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ToleranceTestStopOrCancelRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ToleranceTestStopOrCancelRequest> mapFromJson(
      dynamic json) {
    final map = <String, ToleranceTestStopOrCancelRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ToleranceTestStopOrCancelRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ToleranceTestStopOrCancelRequest-objects as value to a dart map
  static Map<String, List<ToleranceTestStopOrCancelRequest>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ToleranceTestStopOrCancelRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ToleranceTestStopOrCancelRequest.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'stopDateTime',
  };
}
