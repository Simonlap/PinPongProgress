import 'package:flutter/material.dart';
import 'package:test_application/elements/customAlertDialog.dart';
import 'package:test_application/elements/customPageRouteBuilder.dart';
import 'package:test_application/globalVariables.dart' as globalVariables;
import 'package:test_application/screens/start.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../globalVariables.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoggingIn = false;
  Map<String, bool> fieldErrors = {
    'username': false,
    'password': false,
  };

  Future<void> performLogin() async {
    setState(() {
      isLoggingIn = true; // Set login state to true when the button is clicked
      fieldErrors = {
        'username': false,
        'password': false,
      };
    });

    if (!validateInputs()) {
      setState(() {
        isLoggingIn = false;
      });
      return;
    }

    final url = Uri.parse('$apiUrl/api/auth/signin');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': emailController.text,
        'password': passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> accessableResponse = json.decode(response.body);
      globalVariables.username = accessableResponse['username'];
      globalVariables.useremail = accessableResponse['email'];
      globalVariables.userid = accessableResponse['id'] as int;
      globalVariables.userroles = accessableResponse['roles'];

      RegExp regExp = RegExp(r'testjwt=([^;]+)');
      Match? match = regExp.firstMatch(response.headers['set-cookie']!);

      if (match != null) {
        String testjwtValue = match.group(0)!;
        globalVariables.jwtToken = testjwtValue;
      }
      // Login was successful, you can navigate to the next page.
      Navigator.pushAndRemoveUntil(context,
          CustomPageRouteBuilder.slideInFromRight(Start()), (route) => false);
      print("Success");
    } else {
      // Handle the error or show a message to the user.
      showAlert(context, "Authorisierung fehlgeschlagen", "Benutzername und Passwort stimmen nicht überein.");
    }

    setState(() {
      isLoggingIn = false; // Reset login state, whether successful or not
    });
  }

  bool validateInputs() {
    // Reset error flags for all fields
    fieldErrors = {
      'username': false,
      'password': false,
    };

    // Validate username
    String username = emailController.text;
    if (username.length < 3 || username.length > 20) {
      fieldErrors['username'] = true;
      return false;
    }

    // Validate password
    String password = passwordController.text;
    if (password.length < 8 || password.length > 40) {
      fieldErrors['password'] = true;
      return false;
    }

    return true;
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
              decoration: InputDecoration(
                labelText: 'Username',
                errorText: fieldErrors['username'] == true
                    ? 'Username must be between 3 and 20 characters'
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Passwort',
                errorText: fieldErrors['password'] == true
                    ? 'Password must be between 8 and 40 characters'
                    : null,
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
