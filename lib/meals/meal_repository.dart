import 'package:dietitian_dashboard/misc.dart';
import 'package:flutter/services.dart';
import 'package:viatolea_api/api.dart';

class MealRepository {
  Future<List<MealForDietitian>?> getMeals() async {
    if (!mockData) {
      return MealsApi().listMealsForDietitian();
    } else {
      return (await MealsApi().apiClient.deserializeAsync(
                await mockResponse,
                'List<MealForDietitian>',
              )
              as List)
          .cast<MealForDietitian>()
          .toList(growable: false);
    }
  }

  static Future<String> get mockResponse async {
    return rootBundle.loadString('assets/mocks/mock_meals.json');
  }
}
