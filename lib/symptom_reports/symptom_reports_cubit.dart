import 'package:dietitian_dashboard/login/login_repository.dart';
import 'package:dietitian_dashboard/symptom_reports/symptom_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viatolea_api/api.dart';

part 'symptom_reports_state.dart';

class SymptomReportsCubit extends Cubit<SymptomReportsState> {
  final Stream<LoginRepositoryState> _loginStateStream;
  final SymptomReportsRepository _symptomReportsRepository;

  SymptomReportsCubit(this._loginStateStream, this._symptomReportsRepository)
    : super(SymptomReportsInitial()) {
    _loginStateStream.listen((LoginRepositoryState state) {
      if (state is LoggedInAndUserSelected) {
        _symptomReportsRepository
            .getSymptomReports()
            .then((symptomReports) {
              emit(SymptomReportsLoaded(symptomReports: symptomReports ?? []));
            })
            .catchError((error) {
              emit(SymptomReportsLoadingError(errorMessage: error.toString()));
            });
      } else {
        emit(SymptomReportsInitial());
      }
    });
  }
}
