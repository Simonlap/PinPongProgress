import 'package:flutter/material.dart';
import 'package:test_application/customPageRouteBuilder.dart';
import 'package:test_application/start.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> performLogin() async {
    final url = Uri.parse('http://10.0.2.2:8080/api/auth/signin');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': emailController.text,
        'password': passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      // Login was successful, you can navigate to the next page.
      Navigator.push(
        context,
        CustomPageRouteBuilder.slideInFromRight(Start()),
      );
      print("Success");
    } else {
      // Handle the error or show a message to the user.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Passwort',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                performLogin(); // Call the login function
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
