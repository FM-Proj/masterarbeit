import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dietitian_dashboard/login/login_cubit.dart';

import 'analysis_cubit.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (state is LoginInitial)
                const Text("Nicht eingeloggt")
              else if (state is LoggedIn)
                Column(
                  children: [
                    SizedBox(height: 20),
                    SizedBox(height: 20),
                    buildAnalysis(),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  Widget buildAnalysis() {
    return BlocBuilder<AnalysisCubit, AnalysisState>(
      builder: (context, state) => switch (state) {
        AnalysisInitial() => CircularProgressIndicator(),
        AnalysisLoaded() => _buildAnalysisDisplay(state),
        AnalysisError() => Text(state.error),
      },
    );
  }

  Widget _buildAnalysisDisplay(AnalysisLoaded state) {
    // build a Column that shows all analysis results, fructose, lactose, sorbitol and gluten including all other parameters
    return Column(
      children: [
        Text("Fructose: ${state.analysisData.fructoseAnalysis}"),
        Text("Lactose: ${state.analysisData.lactoseAnalysis}"),
        Text("Sorbitol: ${state.analysisData.sorbitolAnalysis}"),
        Text("Gluten: ${state.analysisData.glutenAnalysis}"),
        Text(''),
        Text(
          'Suggested Treatment: ${state.analysisData.suggestedIntoleranceTreatment}',
        ),
        Text(''),
        Text('Anzahl Mahlzeiten: ${state.analysisData.mealAmount}'),
        Text('Anzahl Symptome: ${state.analysisData.symptomAmount}'),
        Text(''),
        Text(
          "Analysis Message: ${state.analysisData.analysisMessageForPatient}",
        ),
        Text(
          "Analysis Message URL: ${state.analysisData.analysisMessageActionUrl}",
        ),
        // Add more parameters as needed
      ],
    );
  }
}
