// home_screen.dart
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  void _handleInput(BuildContext context, String input) {
    // Replace with your desired logic
    print("Input received: $input");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('You entered: $input')),
    );
    Navigator.pushReplacementNamed(context, '/profile/${input}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/cluster-photo-00.jpg',
            fit: BoxFit.cover,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter something...',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      _handleInput(context, _controller.text);
                    },
                    child: const Text('Submit Input'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    child: const Text('Go to Profile'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}