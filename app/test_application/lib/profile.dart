import 'package:flutter/material.dart';
import 'package:test_application/bottomNavigationBar.dart';
import 'package:test_application/customPageRouteBuilder.dart';
import 'package:test_application/start.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
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
                const Text(
                  'Herzlich Willkommen, janvau',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // Display Email Address
                const Text(
                  'Email: test@test.de', // Replace with actual email
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
                // You can add more elements as needed for user-related functionality.
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
                  Navigator.push(
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
