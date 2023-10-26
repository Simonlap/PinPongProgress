import 'package:flutter/material.dart';
import 'package:test_application/customPageRouteBuilder.dart';
import 'package:test_application/globalVariables.dart' as globalVariables;
import 'package:test_application/start.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'globalVariables.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoggingIn = false;

  Future<void> performLogin() async {
    setState(() {
      isLoggingIn = true; // Set login state to true when the button is clicked
    });
    final url = Uri.parse('$apiUrl/api/auth/signin');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': emailController.text,
        'password': passwordController.text,
      }),
    );

    Map<String, dynamic> accessableResponse = json.decode(response.body);
    globalVariables.username = accessableResponse['username'];
    globalVariables.useremail = accessableResponse['email'];
    globalVariables.userid = accessableResponse['id'] as int;
    globalVariables.userroles = accessableResponse['roles'];

    print(response.headers['set-cookie']); //TODO:

    if (response.statusCode == 200) {
      // Login was successful, you can navigate to the next page.
      Navigator.pushAndRemoveUntil(context,
          CustomPageRouteBuilder.slideInFromRight(Start()), (route) => false);
      print("Success");
    } else {
      // Handle the error or show a message to the user.
    }
    setState(() {
      isLoggingIn = false; // Reset login state, whether successful or not
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(fontSize: 32)),
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
            Stack(
              children: [
                ElevatedButton(
                  onPressed: isLoggingIn
                      ? null
                      : performLogin, // Disable click when logging in
                  child: const Text('Login'),
                ),
                if (isLoggingIn)
                  Positioned.fill(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
