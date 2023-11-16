import 'package:flutter/material.dart';
import 'package:test_application/elements/customPageRouteBuilder.dart';
import 'package:test_application/screens/login.dart';
import 'package:test_application/screens/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tischtennis Minispiele',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Homescreen(title: 'Tischtennis Minispiele'),
    );
  }
}

class Homescreen extends StatefulWidget {
  const Homescreen({super.key, required this.title});
  final String title;

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  void _navigateToRegister() {
    Navigator.push(
      context,
      CustomPageRouteBuilder.slideInFromBottom(Register()),
    );
  }

  void _navigateToLogin() {
    Navigator.push(
      context,
      CustomPageRouteBuilder.slideInFromBottom(Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // build reruns every time setState is called
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          Image.asset('assets/homescreen.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _navigateToLogin,
                  child: const Text('Login'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _navigateToRegister,
                  child: const Text('Registrieren'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
