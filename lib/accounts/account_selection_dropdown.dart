import 'package:dietitian_dashboard/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'account_cubit.dart';

class AccountSelectionDropdown extends StatelessWidget {
  const AccountSelectionDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.2,
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, loginState) {
          switch (loginState) {
            case LoginInitial():
              return Text('Please log in to see accounts');
            case LoggedIn():
              return BlocBuilder<AccountsCubit, AccountsState>(
                builder: (context, state) => switch (state) {
                  AccountInitial() => Text('Loading accounts...'),
                  AccountLoaded() => buildAutocomplete(
                    loginState,
                    state,
                    context,
                  ),
                  AccountError() => Text(
                    'Error loading accounts: ${state.error}',
                  ),
                },
              );
          }
        },
      ),
    );
  }

  Widget buildAutocomplete(
    LoggedIn loginState,
    AccountLoaded state,
    BuildContext context,
  ) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        return state.accounts
            .map((a) => a.authenticationUserId)
            .where(
              (String? option) => textEditingValue.text.isEmpty
                  ? true
                  : option?.contains(textEditingValue.text.toLowerCase()) ??
                        false,
            )
            .nonNulls;
      },
      onSelected: (String selection) {
        context.read<LoginCubit>().actAs(selection);
      },
      fieldViewBuilder:
          (
            BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return TextField(
              controller: textEditingController,
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: loginState is LoggedInAndUserSelected
                    ? loginState.actAs
                    : 'Nutzer auswählen',
              ),
              onSubmitted: (_) => onFieldSubmitted(),
            );
          },
    );
  }

  DropdownButton<String> buildDropdownButton(
    LoggedIn loginState,
    AccountLoaded state,
    BuildContext context,
  ) {
    return DropdownButton(
      value: loginState is LoggedInAndUserSelected ? loginState.actAs : null,
      items: state.accounts
          .map(
            (a) => DropdownMenuItem(
              value: a.authenticationUserId,
              child: Text(a.authenticationUserId ?? 'Unknown User'),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) return;
        context.read<LoginCubit>().actAs(value);
      },
    );
  }
}
