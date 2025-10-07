import 'package:dietitian_dashboard/login/login_repository.dart';
import 'package:dietitian_dashboard/meals/meal_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viatolea_api/api.dart';

part 'meal_state.dart';

class MealCubit extends Cubit<MealState> {
  final Stream<LoginRepositoryState> _loginStateStream;
  final MealRepository _mealRepository;

  MealCubit(this._loginStateStream, this._mealRepository)
    : super(MealInitial()) {
    _loginStateStream.listen((LoginRepositoryState state) {
      if (state is LoggedInAndUserSelected) {
        _mealRepository
            .getMeals()
            .then((meals) {
              emit(MealLoaded(meals: meals ?? []));
            })
            .catchError((error) {
              emit(MealLoadingError(errorMessage: error.toString()));
            });
      } else {
        emit(MealInitial());
      }
    });
  }
}
