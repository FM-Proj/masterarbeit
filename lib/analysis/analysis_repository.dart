import 'package:viatolea_api/api.dart';

class AnalysisRepository {
  AnalysisRepository();

  Future<Analysis> getAnalysis(String bearerToken) async {
    try {
      var analysis = await AnalysisApi().getAnalysis();
      if (analysis == null) {
        throw Exception('Keine Analyse-Daten gefunden');
      } else {
        return analysis;
      }
      /*final response = await http.get(
        Uri.parse('http://localhost:8090/v1/analysis'),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Fehler beim Laden der Konten: ${response.statusCode}');
      }*/
    } catch (e) {
      throw Exception('Netzwerkfehler: $e');
    }
  }
}
