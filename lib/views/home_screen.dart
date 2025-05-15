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
    final regex = RegExp(r'^[a-zA-Z\-]+$');
    if (input.isEmpty || regex.hasMatch(input) == false) { return; }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Checking profile of: $input')),
    );
    Navigator.pushReplacementNamed(context, '/profile/$input');
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
          Container(
            color: Colors.black.withOpacity(0.4), // dim overlay
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "🔍 Look up a 42 student",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Enter login',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _handleInput(context, _controller.text);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.blueAccent,
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            right: 12,
            child: Text(
              "Made by vvaas",
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );


  }
}