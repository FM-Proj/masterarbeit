part of 'account_cubit.dart';

@immutable
sealed class AccountsState {}

final class AccountInitial extends AccountsState {}

final class AccountLoaded extends AccountsState {
  final List<AccountReadonly> accounts;

  AccountLoaded({required this.accounts});
}

final class AccountError extends AccountsState {
  final String error;

  AccountError({required this.error});
}
