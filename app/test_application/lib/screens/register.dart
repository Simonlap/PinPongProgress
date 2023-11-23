import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_application/elements/customAlertDialog.dart';
import 'package:test_application/elements/customPageRouteBuilder.dart';
import 'package:test_application/globalVariables.dart';
import 'dart:convert';

import 'package:test_application/screens/login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();
  bool isRegistering = false;

  Map<String, bool> fieldErrors = {
    'username': false,
    'email': false,
    'password': false,
    'repeatPassword': false,
  };

  // @override
  // void initState() {
  //   super.initState();

  //   // Add listeners to text controllers to validate inputs dynamically
  //   usernameController.addListener(validateInputs);
  //   emailController.addListener(validateInputs);
  //   passwordController.addListener(validateInputs);
  //   repeatPasswordController.addListener(validateInputs);
  // }

  // @override
  // void dispose() {
  //   // Dispose of the controllers to avoid memory leaks
  //   usernameController.dispose();
  //   emailController.dispose();
  //   passwordController.dispose();
  //   repeatPasswordController.dispose();

  //   super.dispose();
  // }

  Future<void> performRegistration() async {
    setState(() {
      isRegistering = true;
      fieldErrors = {
        'username': false,
        'email': false,
        'password': false,
        'repeatPassword': false,
      };
    });

    // FE Logic to check length, verify email and password.
    if (!validateInputs()) {
      setState(() {
        isRegistering = false;
      });
      return;
    }

    final url = Uri.parse('$apiUrl/api/auth/signup');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': usernameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'role': ['user']
      }),
    );

    Map<String, dynamic> accessableResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      showAlert(
        context,
        'Erfolgreich',
        'Die Registrierung war erfolgreich!',
      );
      Navigator.push(
        context,
        CustomPageRouteBuilder.slideInFromRight(Login()),
      );
    } else if (response.statusCode == 400) {
      if (accessableResponse['code'] == "USERNAMEEXISTS") {
        // Handle the error or show a message to the user.
        showAlert(
          context,
          'Nutzername',
          'Dieser Nutzername existiert leider bereits!',
        );
      } else if (accessableResponse['code'] == "EMAILEXISTS") {
        // Handle the error or show a message to the user.
        showAlert(
          context,
          'Email',
          'Diese Email existiert leider bereits!',
        );
      }
    } else {
      showAlert(
        context,
        'Unbekannter Fehler',
        'Leider ist ein unbekannter Fehler aufgetreten.',
      );
    }

    setState(() {
      isRegistering = false;
    });
  }

  bool validateInputs() {
    // Reset error flags for all fields
    fieldErrors = {
      'username': false,
      'email': false,
      'password': false,
      'repeatPassword': false,
    };

    // Validate username
    String username = usernameController.text;
    if (username.length < 3 || username.length > 20) {
      fieldErrors['username'] = true;
      return false;
    }

    // Validate email
    String email = emailController.text;
    final emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
      caseSensitive: false,
    );
    if (email.length > 50 || !emailRegex.hasMatch(email)) {
      fieldErrors['email'] = true;
      return false;
    }

    // Validate password
    String password = passwordController.text;
    if (password.length < 8 || password.length > 40) {
      fieldErrors['password'] = true;
      return false;
    }

    // Validate password and repeat password match
    String repeatPassword = repeatPasswordController.text;
    if (password != repeatPassword) {
      fieldErrors['repeatPassword'] = true;
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register', style: TextStyle(fontSize: 32)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                errorText: fieldErrors['username'] == true
                    ? 'Username must be between 3 and 20 characters'
                    : null,
              ),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'E-Mail',
                errorText: fieldErrors['email'] == true
                    ? 'Invalid email format (max 50 characters)'
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: fieldErrors['password'] == true
                    ? 'Password must be between 8 and 40 characters'
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: repeatPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Repeat Password',
                errorText: fieldErrors['repeatPassword'] == true
                    ? 'Passwords do not match'
                    : null,
              ),
            ),
            const SizedBox(height: 32),
            Stack(
              children: [
                ElevatedButton(
                  onPressed: isRegistering ? null : performRegistration,
                  child: const Text('Registrieren'),
                ),
                if (isRegistering)
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
