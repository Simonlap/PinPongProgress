import 'package:flutter/material.dart';
import 'package:test_application/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Register()));
    });
  }

  void _navigateToLogin() {
    // You can implement navigation to the Login screen here
    // For now, let's just print a message
    print('Navigate to Login');
  }

  @override
  Widget build(BuildContext context) {
    // build reruns every time setState is called
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. takes a single child
        child: Column(
          // Column is a layout widget. takes a list of children
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(image: AssetImage('assets/homescreen.jpg')),
            // SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _navigateToRegister,
                  child: const Text('Login'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _navigateToRegister,
                  child: const Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
