//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MealComponentForDietitian {
  /// Returns a new [MealComponentForDietitian] instance.
  MealComponentForDietitian({
    required this.displayName,
    this.ingredientId,
    required this.amountGram,
    required this.amountPortion,
    required this.inputUnit,
    this.fructoseAmount,
    this.lactoseAmount,
    this.sorbitAmount,
    this.containsGluten,
  });

  String displayName;

  int? ingredientId;

  num amountGram;

  num amountPortion;

  MealComponentForDietitianInputUnitEnum inputUnit;

  /// The fructose content per 100g of the ingredient
  num? fructoseAmount;

  /// The lactose content per 100g of the ingredient
  num? lactoseAmount;

  /// The sorbitol content per 100g of the ingredient
  num? sorbitAmount;

  GlutenAmount? containsGluten;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealComponentForDietitian &&
          other.displayName == displayName &&
          other.ingredientId == ingredientId &&
          other.amountGram == amountGram &&
          other.amountPortion == amountPortion &&
          other.inputUnit == inputUnit &&
          other.fructoseAmount == fructoseAmount &&
          other.lactoseAmount == lactoseAmount &&
          other.sorbitAmount == sorbitAmount &&
          other.containsGluten == containsGluten;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (displayName.hashCode) +
      (ingredientId == null ? 0 : ingredientId!.hashCode) +
      (amountGram.hashCode) +
      (amountPortion.hashCode) +
      (inputUnit.hashCode) +
      (fructoseAmount == null ? 0 : fructoseAmount!.hashCode) +
      (lactoseAmount == null ? 0 : lactoseAmount!.hashCode) +
      (sorbitAmount == null ? 0 : sorbitAmount!.hashCode) +
      (containsGluten == null ? 0 : containsGluten!.hashCode);

  @override
  String toString() =>
      'MealComponentForDietitian[displayName=$displayName, ingredientId=$ingredientId, amountGram=$amountGram, amountPortion=$amountPortion, inputUnit=$inputUnit, fructoseAmount=$fructoseAmount, lactoseAmount=$lactoseAmount, sorbitAmount=$sorbitAmount, containsGluten=$containsGluten]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'displayName'] = this.displayName;
    if (this.ingredientId != null) {
      json[r'ingredientId'] = this.ingredientId;
    } else {
      json[r'ingredientId'] = null;
    }
    json[r'amountGram'] = this.amountGram;
    json[r'amountPortion'] = this.amountPortion;
    json[r'inputUnit'] = this.inputUnit;
    if (this.fructoseAmount != null) {
      json[r'fructoseAmount'] = this.fructoseAmount;
    } else {
      json[r'fructoseAmount'] = null;
    }
    if (this.lactoseAmount != null) {
      json[r'lactoseAmount'] = this.lactoseAmount;
    } else {
      json[r'lactoseAmount'] = null;
    }
    if (this.sorbitAmount != null) {
      json[r'sorbitAmount'] = this.sorbitAmount;
    } else {
      json[r'sorbitAmount'] = null;
    }
    if (this.containsGluten != null) {
      json[r'containsGluten'] = this.containsGluten;
    } else {
      json[r'containsGluten'] = null;
    }
    return json;
  }

  /// Returns a new [MealComponentForDietitian] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MealComponentForDietitian? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "MealComponentForDietitian[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "MealComponentForDietitian[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MealComponentForDietitian(
        displayName: mapValueOfType<String>(json, r'displayName')!,
        ingredientId: mapValueOfType<int>(json, r'ingredientId'),
        amountGram: num.parse('${json[r'amountGram']}'),
        amountPortion: num.parse('${json[r'amountPortion']}'),
        inputUnit: MealComponentForDietitianInputUnitEnum.fromJson(
            json[r'inputUnit'])!,
        fructoseAmount: json[r'fructoseAmount'] == null
            ? null
            : num.parse('${json[r'fructoseAmount']}'),
        lactoseAmount: json[r'lactoseAmount'] == null
            ? null
            : num.parse('${json[r'lactoseAmount']}'),
        sorbitAmount: json[r'sorbitAmount'] == null
            ? null
            : num.parse('${json[r'sorbitAmount']}'),
        containsGluten: GlutenAmount.fromJson(json[r'containsGluten']),
      );
    }
    return null;
  }

  static List<MealComponentForDietitian> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <MealComponentForDietitian>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MealComponentForDietitian.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MealComponentForDietitian> mapFromJson(dynamic json) {
    final map = <String, MealComponentForDietitian>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MealComponentForDietitian.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MealComponentForDietitian-objects as value to a dart map
  static Map<String, List<MealComponentForDietitian>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<MealComponentForDietitian>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MealComponentForDietitian.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'displayName',
    'amountGram',
    'amountPortion',
    'inputUnit',
  };
}

class MealComponentForDietitianInputUnitEnum {
  /// Instantiate a new enum with the provided [value].
  const MealComponentForDietitianInputUnitEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const GRAM = MealComponentForDietitianInputUnitEnum._(r'GRAM');
  static const PORTION = MealComponentForDietitianInputUnitEnum._(r'PORTION');

  /// List of all possible values in this [enum][MealComponentForDietitianInputUnitEnum].
  static const values = <MealComponentForDietitianInputUnitEnum>[
    GRAM,
    PORTION,
  ];

  static MealComponentForDietitianInputUnitEnum? fromJson(dynamic value) =>
      MealComponentForDietitianInputUnitEnumTypeTransformer().decode(value);

  static List<MealComponentForDietitianInputUnitEnum> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <MealComponentForDietitianInputUnitEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MealComponentForDietitianInputUnitEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [MealComponentForDietitianInputUnitEnum] to String,
/// and [decode] dynamic data back to [MealComponentForDietitianInputUnitEnum].
class MealComponentForDietitianInputUnitEnumTypeTransformer {
  factory MealComponentForDietitianInputUnitEnumTypeTransformer() =>
      _instance ??=
          const MealComponentForDietitianInputUnitEnumTypeTransformer._();

  const MealComponentForDietitianInputUnitEnumTypeTransformer._();

  String encode(MealComponentForDietitianInputUnitEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a MealComponentForDietitianInputUnitEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  MealComponentForDietitianInputUnitEnum? decode(dynamic data,
      {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'GRAM':
          return MealComponentForDietitianInputUnitEnum.GRAM;
        case r'PORTION':
          return MealComponentForDietitianInputUnitEnum.PORTION;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [MealComponentForDietitianInputUnitEnumTypeTransformer] instance.
  static MealComponentForDietitianInputUnitEnumTypeTransformer? _instance;
}
