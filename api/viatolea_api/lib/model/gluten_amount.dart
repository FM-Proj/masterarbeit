//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GlutenAmount {
  /// Instantiate a new enum with the provided [value].
  const GlutenAmount._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const CONTAINS_GLUTEN = GlutenAmount._(r'CONTAINS_GLUTEN');
  static const GLUTEN_FREE = GlutenAmount._(r'GLUTEN_FREE');
  static const CONTAINS_TRACES = GlutenAmount._(r'CONTAINS_TRACES');

  /// List of all possible values in this [enum][GlutenAmount].
  static const values = <GlutenAmount>[
    CONTAINS_GLUTEN,
    GLUTEN_FREE,
    CONTAINS_TRACES,
  ];

  static GlutenAmount? fromJson(dynamic value) =>
      GlutenAmountTypeTransformer().decode(value);

  static List<GlutenAmount> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <GlutenAmount>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GlutenAmount.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [GlutenAmount] to String,
/// and [decode] dynamic data back to [GlutenAmount].
class GlutenAmountTypeTransformer {
  factory GlutenAmountTypeTransformer() =>
      _instance ??= const GlutenAmountTypeTransformer._();

  const GlutenAmountTypeTransformer._();

  String encode(GlutenAmount data) => data.value;

  /// Decodes a [dynamic value][data] to a GlutenAmount.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  GlutenAmount? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'CONTAINS_GLUTEN':
          return GlutenAmount.CONTAINS_GLUTEN;
        case r'GLUTEN_FREE':
          return GlutenAmount.GLUTEN_FREE;
        case r'CONTAINS_TRACES':
          return GlutenAmount.CONTAINS_TRACES;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [GlutenAmountTypeTransformer] instance.
  static GlutenAmountTypeTransformer? _instance;
}
