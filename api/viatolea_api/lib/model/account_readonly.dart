//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AccountReadonly {
  /// Returns a new [AccountReadonly] instance.
  AccountReadonly({
    required this.id,
    this.authenticationUserId,
  });

  int id;

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
      other is AccountReadonly &&
          other.id == id &&
          other.authenticationUserId == authenticationUserId;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (id.hashCode) +
      (authenticationUserId == null ? 0 : authenticationUserId!.hashCode);

  @override
  String toString() =>
      'AccountReadonly[id=$id, authenticationUserId=$authenticationUserId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'id'] = this.id;
    if (this.authenticationUserId != null) {
      json[r'authenticationUserId'] = this.authenticationUserId;
    } else {
      json[r'authenticationUserId'] = null;
    }
    return json;
  }

  /// Returns a new [AccountReadonly] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AccountReadonly? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "AccountReadonly[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "AccountReadonly[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AccountReadonly(
        id: mapValueOfType<int>(json, r'id')!,
        authenticationUserId:
            mapValueOfType<String>(json, r'authenticationUserId'),
      );
    }
    return null;
  }

  static List<AccountReadonly> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <AccountReadonly>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountReadonly.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AccountReadonly> mapFromJson(dynamic json) {
    final map = <String, AccountReadonly>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AccountReadonly.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AccountReadonly-objects as value to a dart map
  static Map<String, List<AccountReadonly>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<AccountReadonly>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AccountReadonly.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
  };
}
