part of 'symptom_reports_cubit.dart';

sealed class SymptomReportsState {}

final class SymptomReportsInitial extends SymptomReportsState {}

final class SymptomReportsLoaded extends SymptomReportsState {
  final List<SymptomReport> symptomReports;

  SymptomReportsLoaded({required this.symptomReports});
}

final class SymptomReportsLoadingError extends SymptomReportsState {
  final String errorMessage;

  SymptomReportsLoadingError({required this.errorMessage});
}
