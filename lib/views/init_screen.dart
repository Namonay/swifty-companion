

import 'package:flutter/material.dart';
import '../methods/api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<bool> initApp() async {
  await dotenv.load();
  await Future.delayed(const Duration(seconds : 2));
  return await checkToken();
}
class InitScreen extends StatelessWidget {
  const InitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<bool?> (
        future: initApp(),
        builder: (context, snapshot)
        {
          if (snapshot.hasError){
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          switch (snapshot.connectionState)
          {
            case ConnectionState.waiting:
              return const Center(
                child: Image(
                  image: AssetImage("assets/images/42_logo.png"),
                  width: 100,
                  height: 100,
                ),
              );
            case ConnectionState.done:
              if (snapshot.data == true) {
                Future.microtask(() {
                  Navigator.pushReplacementNamed(context, '/home');
                });
              }
              else
                {
                  Future.microtask(() {
                    Navigator.pushReplacementNamed(context, '/login');
                  });
                }
              return const Center(
                child: Image(
                  image: AssetImage("assets/images/42_logo.png"),
                  width: 100,
                  height: 100,
                ),
              );
            default:
              Future.microtask(() {
              Navigator.pushReplacementNamed(context, '/login');
            });
              return const Center(
                  child: Text(
                      "Redirect"
                  )
              );
          }
        }
    ),
    );
  }
}