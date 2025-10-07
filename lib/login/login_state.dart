part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoggedIn extends LoginState {
  LoggedIn();
}

final class LoggedInAndUserSelected extends LoggedIn {
  final String actAs;

  LoggedInAndUserSelected({required this.actAs});
}
