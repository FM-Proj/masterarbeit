import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:viatolea_api/api.dart';

import 'login/auth0_authentication.dart';

class ApiClientConfigurer {
  static Future<void> setUpApiClient() async {
    var packageInfo = await PackageInfo.fromPlatform();
    var apiBaseUrl = "http://localhost:8090/v1";
    if (!kReleaseMode) {
      const apiBaseUrlFromENV = String.fromEnvironment("API_BASE_URL");
      if (apiBaseUrlFromENV.isNotEmpty) {
        apiBaseUrl = apiBaseUrlFromENV;
      }
    }

    defaultApiClient = ApiClient(
      authentication: getAuth(),
      basePath: apiBaseUrl,
    );
    defaultApiClient.addDefaultHeader(
      "X-Client-Version",
      packageInfo.buildNumber,
    );
    var packageName = packageInfo.packageName;
    defaultApiClient.addDefaultHeader(
      "User-Agent",
      '${_getUserAgent()} $packageName/${packageInfo.buildNumber}',
    );
  }

  static String _getUserAgent() {
    //var version = Platform.version;
    // Only include major and minor version numbers.
    //int index = version.indexOf('.', version.indexOf('.') + 1);
    //version = version.substring(0, index);
    String version = 'web';
    return 'Dart/$version (dart:io)';
  }

  static Authentication getAuth() => Auth0Authentication();
}
