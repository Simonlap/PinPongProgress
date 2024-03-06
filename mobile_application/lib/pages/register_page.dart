import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'package:mobile_application/elements/customToast.dart';
import 'package:mobile_application/globalVariables.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController = TextEditingController();
  bool isRegistering = false;

  Map<String, bool> fieldErrors = {
    'username': false,
    'email': false,
    'password': false,
    'repeatPassword': false,
  };

  performRegistration() async {
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

      CustomToast.show(context, "Registrierung erfolgreich!");
      Navigator.popAndPushNamed(context, '/loginpage');

    } else if (response.statusCode == 400) {

      if (accessableResponse['code'] == "USERNAMEEXISTS") {
        CustomToast.show(context, "Benutzername existiert bereits!");
      } else if (accessableResponse['code'] == "EMAILEXISTS") {
        CustomToast.show(context, "Email existiert bereits!");
      }
      
    } else {
      CustomToast.show(context, "Unbekannter Fehler");
    }

    setState(() {
      isRegistering = false;
    });
  }

  bool validateInputs() {
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
      appBar: CustomAppBar(title: 'Registrieren'),
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
                CustomElevatedButton(
                  onPressed: performRegistration,
                  text: 'Registrieren',
                ),
                if (isRegistering)
                  const Positioned.fill(
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
