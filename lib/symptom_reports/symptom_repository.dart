import 'package:flutter/services.dart';
import 'package:viatolea_api/api.dart';

import '../misc.dart';

class SymptomReportsRepository {
  Future<List<SymptomReport>?> getSymptomReports() async {
    if (!mockData) {
      return SymptomReportsApi().listSymptomReports();
    } else {
      return (await SymptomReportsApi().apiClient.deserializeAsync(
                await mockResponse,
                'List<SymptomReport>',
              )
              as List)
          .cast<SymptomReport>()
          .toList(growable: false);
    }
  }

  static Future<String> get mockResponse async {
    return rootBundle.loadString('assets/mocks/mock_symptom_reports.json');
  }
}
