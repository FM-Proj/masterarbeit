import 'package:dietitian_dashboard/login/login_repository.dart' as repo;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final repo.LoginRepository _loginRepository;
  LoginCubit(this._loginRepository) : super(LoginInitial()) {
    _loginRepository.$login.listen((final repo.LoginRepositoryState state) {
      if (state is repo.LoggedInAndUserSelected) {
        emit(LoggedInAndUserSelected(actAs: state.actAs));
      } else if (state is repo.LoggedIn) {
        emit(LoggedIn());
      } else {
        emit(LoginInitial());
      }
    });
  }
  void actAs(String actAs) {
    _loginRepository.actAs(actAs);
  }

  void logout() {
    _loginRepository.logout();
    emit(LoginInitial());
  }
}
