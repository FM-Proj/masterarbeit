//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class IntoleranceTreatment {
  /// Instantiate a new enum with the provided [value].
  const IntoleranceTreatment._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const NONE = IntoleranceTreatment._(r'NONE');
  static const FRUCTOSE = IntoleranceTreatment._(r'FRUCTOSE');
  static const GLUTEN = IntoleranceTreatment._(r'GLUTEN');
  static const SORBIT = IntoleranceTreatment._(r'SORBIT');
  static const LACTOSE = IntoleranceTreatment._(r'LACTOSE');

  /// List of all possible values in this [enum][IntoleranceTreatment].
  static const values = <IntoleranceTreatment>[
    NONE,
    FRUCTOSE,
    GLUTEN,
    SORBIT,
    LACTOSE,
  ];

  static IntoleranceTreatment? fromJson(dynamic value) =>
      IntoleranceTreatmentTypeTransformer().decode(value);

  static List<IntoleranceTreatment> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <IntoleranceTreatment>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = IntoleranceTreatment.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [IntoleranceTreatment] to String,
/// and [decode] dynamic data back to [IntoleranceTreatment].
class IntoleranceTreatmentTypeTransformer {
  factory IntoleranceTreatmentTypeTransformer() =>
      _instance ??= const IntoleranceTreatmentTypeTransformer._();

  const IntoleranceTreatmentTypeTransformer._();

  String encode(IntoleranceTreatment data) => data.value;

  /// Decodes a [dynamic value][data] to a IntoleranceTreatment.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  IntoleranceTreatment? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'NONE':
          return IntoleranceTreatment.NONE;
        case r'FRUCTOSE':
          return IntoleranceTreatment.FRUCTOSE;
        case r'GLUTEN':
          return IntoleranceTreatment.GLUTEN;
        case r'SORBIT':
          return IntoleranceTreatment.SORBIT;
        case r'LACTOSE':
          return IntoleranceTreatment.LACTOSE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [IntoleranceTreatmentTypeTransformer] instance.
  static IntoleranceTreatmentTypeTransformer? _instance;
}
