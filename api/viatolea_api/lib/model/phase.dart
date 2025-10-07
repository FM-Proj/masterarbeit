//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Phase {
  /// Instantiate a new enum with the provided [value].
  const Phase._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const RECOGNITION = Phase._(r'RECOGNITION');
  static const ELIMINATION = Phase._(r'ELIMINATION');
  static const TEST = Phase._(r'TEST');
  static const LONG_TERM = Phase._(r'LONG_TERM');

  /// List of all possible values in this [enum][Phase].
  static const values = <Phase>[
    RECOGNITION,
    ELIMINATION,
    TEST,
    LONG_TERM,
  ];

  static Phase? fromJson(dynamic value) => PhaseTypeTransformer().decode(value);

  static List<Phase> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <Phase>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Phase.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [Phase] to String,
/// and [decode] dynamic data back to [Phase].
class PhaseTypeTransformer {
  factory PhaseTypeTransformer() =>
      _instance ??= const PhaseTypeTransformer._();

  const PhaseTypeTransformer._();

  String encode(Phase data) => data.value;

  /// Decodes a [dynamic value][data] to a Phase.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  Phase? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'RECOGNITION':
          return Phase.RECOGNITION;
        case r'ELIMINATION':
          return Phase.ELIMINATION;
        case r'TEST':
          return Phase.TEST;
        case r'LONG_TERM':
          return Phase.LONG_TERM;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [PhaseTypeTransformer] instance.
  static PhaseTypeTransformer? _instance;
}
