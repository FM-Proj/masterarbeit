import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viatolea_api/api.dart';
import 'package:dietitian_dashboard/login/login_repository.dart';

import 'account_repository.dart' as repo;

part 'account_state.dart';

class AccountsCubit extends Cubit<AccountsState> {
  final repo.AccountRepository _accountRepository;
  final LoginRepository _loginRepository;
  AccountsCubit(this._accountRepository, this._loginRepository)
    : super(AccountInitial()) {
    _loginRepository.$login.listen((final LoginRepositoryState state) {
      if (state is LoggedIn) {
        _accountRepository.getAccounts(state.accessToken);
      } else {
        emit(AccountInitial());
      }
    });
    _accountRepository.$accounts.listen((final repo.AccountsState state) {
      if (state is repo.AccountsLoaded) {
        emit(AccountLoaded(accounts: state.accounts));
      } else if (state is repo.AccountsLoadingError) {
        emit(AccountError(error: state.errorMessage));
      } else {
        emit(AccountInitial());
      }
    });
  }
}
