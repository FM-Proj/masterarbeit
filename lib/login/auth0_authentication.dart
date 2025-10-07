import 'package:flutter/widgets.dart';
import 'package:viatolea_api/api.dart';
import 'package:dietitian_dashboard/login/login_repository.dart';

class Auth0Authentication extends Authentication {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Future<void> applyToParams(
    List<QueryParam> queryParams,
    Map<String, String> headerParams,
  ) async {
    if (await LoginRepository.isLoggedIn()) {
      final accessToken = await LoginRepository.getAccessToken();
      headerParams['Authorization'] = 'Bearer $accessToken';
    } else {
      LoginRepository.maybeLogin();
    }
  }
}
