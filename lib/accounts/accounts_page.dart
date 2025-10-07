import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dietitian_dashboard/accounts/account_cubit.dart';

import '../login/login_cubit.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsCubit, AccountsState>(
      builder: (context, state) => switch (state) {
        AccountInitial() => Center(child: CircularProgressIndicator()),
        AccountLoaded() => buildAccountList(context, state),
        AccountError() => Center(child: Text(state.error)),
      },
    );
  }

  Widget buildAccountList(BuildContext context, AccountLoaded state) => Center(
    child: SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.5,
      child: ListView.builder(
        itemCount: state.accounts.length,
        itemBuilder: (context, index) {
          final account = state.accounts[index];
          return GestureDetector(
            onTap: () => actAs(account.authenticationUserId, context),
            child: Row(
              children: [
                Text(
                  account.authenticationUserId ?? 'No User ID',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                IconButton(
                  onPressed: () => actAs(account.authenticationUserId, context),
                  icon: Icon(Icons.arrow_circle_right),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );

  void actAs(String? authenticationUserId, BuildContext context) {
    if (authenticationUserId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No User ID available for this account.')),
      );
    } else {
      context.read<LoginCubit>().actAs(authenticationUserId);
    }
  }
}
