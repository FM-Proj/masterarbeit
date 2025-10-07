import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viatolea_api/api.dart';
import 'package:dietitian_dashboard/analysis/analysis_repository.dart';
import 'package:dietitian_dashboard/login/login_repository.dart';

part 'analysis_state.dart';

class AnalysisCubit extends Cubit<AnalysisState> {
  final Stream<LoginRepositoryState> _loginStateStream;
  final AnalysisRepository _analysisRepository;

  AnalysisCubit(this._loginStateStream, this._analysisRepository)
    : super(AnalysisInitial()) {
    _loginStateStream.listen((LoginRepositoryState state) {
      if (state is LoggedIn) {
        _analysisRepository
            .getAnalysis(state.accessToken)
            .then((analysisData) {
              emit(AnalysisLoaded(analysisData: analysisData));
            })
            .catchError((error) {
              emit(AnalysisError(error: error.toString()));
            });
      } else {
        emit(AnalysisInitial());
      }
    });
  }
}
