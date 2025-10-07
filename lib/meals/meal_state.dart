part of 'meal_cubit.dart';

sealed class MealState {}

final class MealInitial extends MealState {}

final class MealLoaded extends MealState {
  final List<MealForDietitian> meals;

  MealLoaded({required this.meals});
}

final class MealLoadingError extends MealState {
  final String errorMessage;

  MealLoadingError({required this.errorMessage});
}
