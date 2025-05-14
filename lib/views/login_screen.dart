
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const FlutterAppAuth _appAuth = FlutterAppAuth();

Future<void> redirect_to_oauth(BuildContext context) async {
  final String _clientId = dotenv.env['CLIENT-ID'] ?? '';
  final String _clientSecret = dotenv.env['CLIENT-SECRET'] ?? '';
  final String _redirectUrl = 'swifty-companion://oauth2/callback';
  final String _authorizationEndpoint = 'https://api.intra.42.fr/oauth/authorize';
  final String _tokenEndpoint = 'https://api.intra.42.fr/oauth/token';
  final request = AuthorizationRequest(
      _clientId,
      _redirectUrl,
      serviceConfiguration: AuthorizationServiceConfiguration(
        authorizationEndpoint: _authorizationEndpoint,
        tokenEndpoint: _tokenEndpoint,
      ));
  print("swap");
  try {
    print("trying");
    final AuthorizationResponse? result = await _appAuth.authorize(request);
    print("tried");
    if (result != null) {
      print("nonull result");
      Navigator.pushReplacementNamed(context, "/home");
      print('Authorization Code: ${result.authorizationCode}');
      final token_request = TokenRequest(
        _clientId,
        _redirectUrl,
        clientSecret: _clientSecret,
        authorizationCode: result.authorizationCode,
        grantType: 'authorization_code',
        serviceConfiguration: AuthorizationServiceConfiguration(
          authorizationEndpoint: "https://api.intra.42.fr/oauth/authorize",
          tokenEndpoint: _tokenEndpoint,
        ),
      );
      print("pre token");
      final TokenResponse? tokenResponse = await _appAuth.token(token_request);
      print("token");
      print(tokenResponse?.accessToken);
      print(tokenResponse?.refreshToken);
      // You can now use this code to exchange for an access token (via a separate API call to the token endpoint)
    }
  }
  catch (e) {
    print("error $e");
  }
}
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            redirect_to_oauth(context);
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}