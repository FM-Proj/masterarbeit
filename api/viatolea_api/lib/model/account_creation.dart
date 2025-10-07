//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AccountCreation {
  /// Returns a new [AccountCreation] instance.
  AccountCreation({
    this.operatingSystem,
    this.deviceName,
    this.authenticationUserId,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? operatingSystem;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? deviceName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? authenticationUserId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountCreation &&
          other.operatingSystem == operatingSystem &&
          other.deviceName == deviceName &&
          other.authenticationUserId == authenticationUserId;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (operatingSystem == null ? 0 : operatingSystem!.hashCode) +
      (deviceName == null ? 0 : deviceName!.hashCode) +
      (authenticationUserId == null ? 0 : authenticationUserId!.hashCode);

  @override
  String toString() =>
      'AccountCreation[operatingSystem=$operatingSystem, deviceName=$deviceName, authenticationUserId=$authenticationUserId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.operatingSystem != null) {
      json[r'operatingSystem'] = this.operatingSystem;
    } else {
      json[r'operatingSystem'] = null;
    }
    if (this.deviceName != null) {
      json[r'deviceName'] = this.deviceName;
    } else {
      json[r'deviceName'] = null;
    }
    if (this.authenticationUserId != null) {
      json[r'authenticationUserId'] = this.authenticationUserId;
    } else {
      json[r'authenticationUserId'] = null;
    }
    return json;
  }

  /// Returns a new [AccountCreation] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AccountCreation? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "AccountCreation[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "AccountCreation[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AccountCreation(
        operatingSystem: mapValueOfType<String>(json, r'operatingSystem'),
        deviceName: mapValueOfType<String>(json, r'deviceName'),
        authenticationUserId:
            mapValueOfType<String>(json, r'authenticationUserId'),
      );
    }
    return null;
  }

  static List<AccountCreation> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <AccountCreation>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountCreation.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AccountCreation> mapFromJson(dynamic json) {
    final map = <String, AccountCreation>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AccountCreation.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AccountCreation-objects as value to a dart map
  static Map<String, List<AccountCreation>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<AccountCreation>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AccountCreation.listFromJson(
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
