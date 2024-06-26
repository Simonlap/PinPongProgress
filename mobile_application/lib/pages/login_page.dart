import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'package:mobile_application/elements/customToast.dart';
import 'package:mobile_application/globalVariables.dart' as globalVariables;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_application/pages/navigation_page.dart';


import '../globalVariables.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController= TextEditingController();
  Map<String, bool> fieldErrors = {
    'username': false,
    'password': false,
  };

  performLogin() async {
    setState(() {
      fieldErrors = {
        'username': false,
        'password': false,
      };
    });

    if (!validateInputs()) {
      setState(() {});
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
      CustomToast.show(context, 'Login erfolgreich!');

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
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => NavigationPage()),
        (Route<dynamic> route) => false,
      );

      print("Success");
    } else {
      CustomToast.show(context, 'Login fehlgeschlagen!');
    }
  }

  bool validateInputs() {
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
      appBar: CustomAppBar(
        title: "Login",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Nutzername',
                errorText: fieldErrors['username'] == true
                    ? 'Nutzername muss zwischen 3 und 20 Zeichen sein.'
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
                    ? 'Passwort muss zwischen 8 und 40 Zeichen haben.'
                    : null,
              ),
            ),
            const SizedBox(height: 32),
            Stack(
              children: [
                CustomElevatedButton(
                  text: 'Login',
                  onPressed: performLogin,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}