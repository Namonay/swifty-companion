import 'package:flutter/material.dart';
import 'views/home_screen.dart';
import 'views/profile_screen.dart';
import 'views/login_screen.dart';
import 'methods/api.dart';
import 'views/init_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '42 API Client',
      initialRoute: '/',
      routes: {
        '/': (context) => const InitScreen(),
        '/home': (context) => HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
