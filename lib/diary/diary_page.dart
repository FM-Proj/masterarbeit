import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dietitian_dashboard/diary/diary_display.dart';
import 'package:dietitian_dashboard/meals/meal_cubit.dart';
import 'package:dietitian_dashboard/symptom_reports/symptom_reports_cubit.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override 
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealCubit, MealState>(
      builder: (context, mealState) {
        return BlocBuilder<SymptomReportsCubit, SymptomReportsState>(
          builder: (context, symptomState) {
            if (mealState is MealLoaded &&
                symptomState is SymptomReportsLoaded) {
              return buildWhenLoaded(context, mealState, symptomState);
            } else if (mealState is MealLoadingError) {
              return Center(
                child: Text(
                  "Fehler beim Laden der Mahlzeiten: ${mealState.errorMessage}",
                ),
              );
            } else if (symptomState is SymptomReportsLoadingError) {
              return Center(
                child: Text(
                  "Fehler beim Laden der Symptome: ${symptomState.errorMessage}",
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }

  Widget buildWhenLoaded(
    BuildContext context,
    MealLoaded loadedMeals,
    SymptomReportsLoaded loadedSymptomReports,
  ) {
    return DiaryDisplay(
      mealState: loadedMeals,
      symptomReportsState: loadedSymptomReports,
    );
  }
}
