import 'dart:convert';
import 'package:viatolea_api/api.dart';
import 'package:web/web.dart' as web;

//extensions to correctly convert GlutenAmount to/from Json
extension GlutenAmountToJson on GlutenAmount {
  String toJsonGlutenAmount() => switch (this) {
    GlutenAmount.GLUTEN_FREE => 'GLUTEN_FREE',
    GlutenAmount.CONTAINS_TRACES => 'CONTAINS_TRACES',
    GlutenAmount.CONTAINS_GLUTEN => 'CONTAINS_GLUTEN',
    _ => ""  // default case, should not happen
  };
}

extension GlutenAmountFromJson on String {
  GlutenAmount fromJsonGlutenAmount() => switch (this) {
    'GLUTEN_FREE' => GlutenAmount.GLUTEN_FREE,
    'CONTAINS_TRACES' => GlutenAmount.CONTAINS_TRACES,
    'CONTAINS_GLUTEN' => GlutenAmount.CONTAINS_GLUTEN,
    _ => GlutenAmount.GLUTEN_FREE // default case, should not happen
  };
}

//extension for correctly convert inputUnit to/from Json
extension InputUnitToJson on MealComponentForDietitianInputUnitEnum {
  String toJsonInputUnit() => switch (this) {
    MealComponentForDietitianInputUnitEnum.GRAM => 'GRAM',
    MealComponentForDietitianInputUnitEnum.PORTION => 'PORTION',
    _ => ""  // default case, should not happen
  };
}

extension InputUnitFromJson on String {
  MealComponentForDietitianInputUnitEnum fromJsonInputUnit() => switch (this) {
    'GRAM' => MealComponentForDietitianInputUnitEnum.GRAM,
    'PORTION' => MealComponentForDietitianInputUnitEnum.PORTION,
    _ => MealComponentForDietitianInputUnitEnum.GRAM // default case, should not happen
  };
}

// to match the mealComponent, create a class with all values of MealComponentForDietitian & the matching mealID
class SaveMealComponentsInBrowser{
  final int mealID;
  final String displayName;
  final int? ingredientId;
  final num amountGram;
  final num amountPortion;
  final MealComponentForDietitianInputUnitEnum inputUnit;
  final double fructoseAmount;
  final double lactoseAmount;
  final double sorbitAmount;
  final GlutenAmount containsGluten;

  const SaveMealComponentsInBrowser({
    required this.mealID,
    required this.displayName,
    required this.ingredientId,
    required this.amountGram,
    required this.amountPortion,
    required this.inputUnit,
    required this.fructoseAmount,
    required this.lactoseAmount,
    required this.sorbitAmount,
    required this.containsGluten
  });

  Map<String, dynamic> toJson() => {
    'mealID': mealID,
    'displayName': displayName,
    'ingredientId': ingredientId,
    'amountGram': amountGram,
    'amountPortion': amountPortion,
    'inputUnit': inputUnit.toJsonInputUnit(),
    'fructoseAmount': fructoseAmount,
    'lactoseAmount': lactoseAmount,
    'sorbitAmount': sorbitAmount,
    'containsGluten': containsGluten.toJsonGlutenAmount()
  };

  factory SaveMealComponentsInBrowser.fromJson(Map<String, dynamic> json) => SaveMealComponentsInBrowser(
    mealID: json['mealID'] as int,
    displayName: json['displayName'] as String,
    ingredientId: json['ingredientId'] as int?,
    amountGram: json['amountGram'] as int,
    amountPortion: json['amountPortion'] as int,
    inputUnit: (json['inputUnit'] as String).fromJsonInputUnit(),
    fructoseAmount: json['fructoseAmount'] as double,
    lactoseAmount: json['lactoseAmount'] as double,
    sorbitAmount: json['sorbitAmount'] as double,
    containsGluten: (json['containsGluten'] as String).fromJsonGlutenAmount()
  );
}



// save in browser
void saveUpdatedTableInBrowser(List<SaveMealComponentsInBrowser> data) {
  final storage = web.window.localStorage;
  final encoded = jsonEncode(data.map((e) => e.toJson()).toList());
  storage.setItem('updatedMealComponents', encoded);
}

// load from browser
List<SaveMealComponentsInBrowser> loadTableFromBrowser() {
  final storage = web.window.localStorage;
  final encoded = storage.getItem('updatedMealComponents');

  if (encoded == null) {
    return [];
  }

  final List<SaveMealComponentsInBrowser> decoded = (jsonDecode(encoded) as List).map((e) {
    final m = (e as Map<String, dynamic>);
    return SaveMealComponentsInBrowser.fromJson(m);
  }).toList();
  
  return decoded;
}