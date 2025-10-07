import 'dart:math';

import 'package:dietitian_dashboard/api_client_configurer.dart';
import 'package:dietitian_dashboard/diary/diary_page.dart';
import 'package:dietitian_dashboard/meals/meal_repository.dart';
import 'package:dietitian_dashboard/symptom_reports/symptom_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'accounts/account_cubit.dart';
import 'accounts/account_repository.dart' hide AccountsState;
import 'accounts/account_selection_dropdown.dart';
import 'accounts/accounts_page.dart';
import 'analysis/analysis_cubit.dart';
import 'analysis/analysis_page.dart';
import 'analysis/analysis_repository.dart';
import 'login/login_cubit.dart';
import 'login/login_repository.dart'
    hide LoginInitial, LoggedIn, LoggedInAndUserSelected;
import 'meals/meal_cubit.dart';
import 'misc.dart';
import 'symptom_reports/symptom_reports_cubit.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiClientConfigurer.setUpApiClient();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => LoginRepository()),
        RepositoryProvider(create: (context) => AccountRepository()),
        RepositoryProvider(create: (context) => AnalysisRepository()),
        RepositoryProvider(create: (context) => MealRepository()),
        RepositoryProvider(create: (context) => SymptomReportsRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (context) => LoginCubit(context.read<LoginRepository>()),
          ),
          BlocProvider(
            create: (context) => AccountsCubit(
              context.read<AccountRepository>(),
              context.read<LoginRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => AnalysisCubit(
              context.read<LoginRepository>().$login,
              context.read<AnalysisRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => MealCubit(
              context.read<LoginRepository>().$login,
              context.read<MealRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SymptomReportsCubit(
              context.read<LoginRepository>().$login,
              context.read<SymptomReportsRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ViatoleaTheme.getTheme(),
          home: const MyHomePage(title: 'viatolea Dashboard'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  Widget get page {
    switch (selectedIndex) {
      case 0:
        return AccountsPage();
      case 1:
        return AnalysisPage();
      case 2:
        return DiaryPage();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoggedInAndUserSelected) {
          selectedIndex = 2;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 80, // extracted from the default of the navigation rail
          leading: Center(
            child: Padding(
              padding: const EdgeInsets.all(Paddings.S),
              child: Image.asset(
                'images/viatolea_icon-primary-green-circle.png',
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(right: Paddings.XL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title),
                AccountSelectionDropdown(),
                LogoutButton(),
              ],
            ),
          ),
          actions: [],
        ),
        body: Row(
          children: [
            SafeArea(
              child: BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return NavigationRail(
                    extended: false,
                    destinations: getDestinations(state),
                    selectedIndex: min(
                      selectedIndex,
                      getDestinations(state).length - 1,
                    ),
                    onDestinationSelected: (index) => setState(() {
                      selectedIndex = index;
                    }),
                  );
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<NavigationRailDestination> getDestinations(LoginState state) {
    return [
      NavigationRailDestination(icon: Icon(Icons.people), label: Text('Home')),
      if (!enableLogin || state is LoggedInAndUserSelected) ...[
        NavigationRailDestination(
          icon: Icon(Icons.bar_chart),
          label: Text('Favorites'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.restaurant_menu),
          label: Text('Meals'),
        ),
      ],
    ];
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) => switch (state) {
        LoginInitial() => SizedBox.shrink(),
        LoggedIn() => IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            context.read<LoginCubit>().logout();
          },
          tooltip: 'Logout',
        ),
      },
    );
  }
}
