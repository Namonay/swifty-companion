import 'package:flutter/material.dart';
import 'views/home_screen.dart';
import 'views/profile_screen.dart';
import 'views/login_screen.dart';
import 'views/init_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluty',
      initialRoute: '/',
        onGenerateRoute: (settings) {
      final uri = Uri.parse(settings.name ?? '/');

      if (uri.path == '/') {
        return MaterialPageRoute(builder: (_) => const InitScreen());
      }
      if (uri.path == '/home') {
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      }
      if (uri.path == '/login') {
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      }

      if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'profile') {
        final login = uri.pathSegments[1];
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(login: login),
        );
      }
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(child: Text('404 - Page not found')),
        ),
      );
      },
    );
  }
}
