part of 'analysis_cubit.dart';

@immutable
sealed class AnalysisState {}

final class AnalysisInitial extends AnalysisState {}

final class AnalysisLoaded extends AnalysisState {
  final Analysis analysisData;

  AnalysisLoaded({required this.analysisData});
}

final class AnalysisError extends AnalysisState {
  final String error;

  AnalysisError({required this.error});
}
