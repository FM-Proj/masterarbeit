import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:viatolea_api/api.dart';
import 'package:dietitian_dashboard/misc.dart';

class AccountRepository {
  final _accountsSubject = BehaviorSubject<AccountsState>.seeded(
    AccountsInitial(),
  );

  Stream<AccountsState> get $accounts => _accountsSubject.stream;

  AccountRepository();

  Future<void> getAccounts(String bearerToken) async {
    List<AccountReadonly>? accounts;
    if (mockData) {
      accounts =
          (await ListAccountsApi().apiClient.deserializeAsync(
                    await mockResponse,
                    'List<AccountReadonly>',
                  )
                  as List)
              .cast<AccountReadonly>()
              .toList(growable: false);
    } else {
      try {
        accounts = await ListAccountsApi().getAccounts();
      } catch (e) {
        _accountsSubject.add(
          AccountsLoadingError(errorMessage: 'Netzwerkfehler: $e'),
        );
      }
    }
    _accountsSubject.add(AccountsLoaded(accounts: accounts ?? []));
  }

  static Future<String> get mockResponse async {
    return rootBundle.loadString('assets/mocks/mock_accounts.json');
  }
}

@immutable
sealed class AccountsState {}

final class AccountsInitial extends AccountsState {}

final class AccountsLoading extends AccountsState {}

final class AccountsLoaded extends AccountsState {
  final List<AccountReadonly> accounts;

  AccountsLoaded({required this.accounts});
}

final class AccountsLoadingError extends AccountsState {
  final String errorMessage;

  AccountsLoadingError({required this.errorMessage});
}
