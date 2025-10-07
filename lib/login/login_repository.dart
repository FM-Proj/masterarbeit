import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:auth0_flutter_platform_interface/auth0_flutter_platform_interface.dart';
import 'package:dietitian_dashboard/misc.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class LoginRepository {
  // This class will handle
  static final Auth0Web _auth0 = Auth0Web(
    'login.viatolea.de',
    '5v4j6Vl3kwOrxXwGWrYQkEdBMWzSZl4Y',
  );

  static final _loginSubject = BehaviorSubject<LoginRepositoryState>.seeded(
    LoginInitial(),
  );

  LoginRepository() {
    if (enableLogin) {
      _handleOnLoad();
    } else {
      _loginSubject.add(
        LoggedInAndUserSelected(
          accessToken: "dummy_access_token",
          actAs: "auth0|abc",
        ),
      );
    }
  }

  void _handleOnLoad() async {
    _auth0.onLoad(audience: 'de.pyramedi.viatolea').then((final credentials) {
      if (credentials == null) {
        _loginWithRedirect();
      } else {
        emitLoggedInState(credentials);
      }
    });
  }

  static Future<bool> isLoggedIn() {
    return _auth0.hasValidCredentials();
  }

  static Future<String?> getAccessToken() async {
    if (await _auth0.hasValidCredentials()) {
      final credentials = await _auth0.credentials();
      return credentials.accessToken;
    } else {
      return null;
    }
  }

  static Future<void> maybeLogin() async {
    if (await _auth0.hasValidCredentials()) {
      final credentials = await _auth0.credentials();
      emitLoggedInState(credentials);
    } else {
      _loginWithRedirect();
    }
  }

  static void emitLoggedInState(Credentials credentials) {
    if (credentials.user.customClaims?["act_as"] != null) {
      _loginSubject.add(
        LoggedInAndUserSelected(
          accessToken: credentials.accessToken,
          actAs: credentials.user.customClaims!["act_as"],
        ),
      );
    } else {
      _loginSubject.add(LoggedIn(accessToken: credentials.idToken));
    }
  }

  Stream<LoginRepositoryState> get $login => _loginSubject.stream;

  void actAs(String actAs) {
    _loginWithRedirect(actAs: actAs);
  }

  static Future<void> _loginWithRedirect({String? actAs}) {
    return _auth0.loginWithRedirect(
      redirectUrl: 'http://localhost:3000',
      scopes: {'openid', 'profile', 'email'},
      parameters: actAs != null ? {'act_as': actAs} : {},
    );
  }

  void logout() async {
    await _auth0.logout(returnToUrl: 'http://localhost:3000');
  }
}

@immutable
sealed class LoginRepositoryState {}

final class LoginInitial extends LoginRepositoryState {}

final class LoggedIn extends LoginRepositoryState {
  LoggedIn({required this.accessToken});
  final String accessToken;
}

final class LoggedInAndUserSelected extends LoggedIn {
  LoggedInAndUserSelected({required super.accessToken, required this.actAs});
  final String actAs;
}
