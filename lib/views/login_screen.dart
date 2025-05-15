
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:swifty/methods/api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const FlutterAppAuth _appAuth = FlutterAppAuth();

Future<void> redirect_to_oauth(BuildContext context) async {
  String _clientId = dotenv.get('CLIENT-ID');
  String _clientSecret = dotenv.get('CLIENT-SECRET');
  const String _redirectUrl = 'swifty-companion://oauth2/callback';
  const String _authorizationEndpoint = 'https://api.intra.42.fr/oauth/authorize';
  const String _tokenEndpoint = 'https://api.intra.42.fr/oauth/token';
  final request = AuthorizationRequest(
      _clientId,
      _redirectUrl,
      serviceConfiguration: const AuthorizationServiceConfiguration(
        authorizationEndpoint: _authorizationEndpoint,
        tokenEndpoint: _tokenEndpoint,
      ));
  try {
    final AuthorizationResponse? result = await _appAuth.authorize(request);
    if (result == null) { throw PlatformException(code: "fatal_error"); }
    final token_request = TokenRequest(
      _clientId,
      _redirectUrl,
      clientSecret: _clientSecret,
      authorizationCode: result.authorizationCode,
      grantType: 'authorization_code',
      serviceConfiguration: const AuthorizationServiceConfiguration(
        authorizationEndpoint: "https://api.intra.42.fr/oauth/authorize",
        tokenEndpoint: _tokenEndpoint,
      ),
    );
    final TokenResponse? tokenResponse = await _appAuth.token(token_request);
    saveToken(tokenResponse?.accessToken ?? '', tokenResponse?.refreshToken ?? '', tokenResponse?.accessTokenExpirationDateTime ?? DateTime.now());
    Navigator.pushReplacementNamed(context, "/home");
  }
  on PlatformException catch (e)
  {
    if (e.code == "authorize_failed" && e.message?.contains('User cancelled flow') == true) { return; }
  }
  catch (e) {
    return;
  }
}
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/cluster-photo-00.jpg',
            fit: BoxFit.cover,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                redirect_to_oauth(context);
              },
              child: const Text('Login into 42 API'),
            ),
          ),
        ],
      ),
    );
  }
}