import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_application/bottomNavigationBar.dart';
import 'package:test_application/customPageRouteBuilder.dart';
import 'package:test_application/globalVariables.dart';
import 'package:test_application/main.dart';
import 'package:test_application/start.dart';
import 'package:http/http.dart' as http;

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontSize: 32)),
        automaticallyImplyLeading: false, // Remove the back button
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.stretch, // Stretch horizontally
              children: <Widget>[
                Text(
                  'Herzlich Willkommen, $username',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // Display Email Address
                Text(
                  'Email: $useremail',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                // Button to Reset Password
                ElevatedButton(
                  onPressed: () {
                    // Implement password reset logic here
                  },
                  child: const Text('Passwort zurücksetzen'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final url = Uri.parse('$apiUrl/api/auth/signout');
                    final response = await http.post(
                      url,
                      headers: {'Content-Type': 'application/json'},
                    );
                    print(response.body);
                    Navigator.pushAndRemoveUntil(
                        context,
                        CustomPageRouteBuilder.slideInFromRight(Homescreen(
                          title: 'Tischtennis Minispiele',
                        )),
                        (route) => false);
                  },
                  child: const Text('Ausloggen'),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomBottomNavigationBar(
              currentIndex: 1,
              onTap: (int index) {
                if (index == 0) {
                  // Use custom transition for navigating to the Start page
                  Navigator.pushReplacement(
                    context,
                    CustomPageRouteBuilder.slideInFromLeft(const Start()),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
