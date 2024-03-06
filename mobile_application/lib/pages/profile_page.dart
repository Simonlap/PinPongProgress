import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'package:mobile_application/elements/customToast.dart';
import 'package:mobile_application/globalVariables.dart';
import 'package:mobile_application/pages/start_page.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.stretch, 
              children: <Widget>[
                Text(
                  'Herzlich Willkommen, $username',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Email: $useremail',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  onPressed: () {
                    CustomToast.show(context, "Noch nicht implementiert!");
                  },
                  text: 'Passwort zurücksetzen',
                ),
                CustomElevatedButton(
                  onPressed: () async {
                    final url = Uri.parse('$apiUrl/api/auth/signout');
                    final response = await http.post(
                      url,
                      headers: {'Content-Type': 'application/json'},
                    );

                    if (response.statusCode == 200) {
                      CustomToast.show(context, "Logout erfolgreich!");
                      print("Logged out");

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => StartPage()),
                        (Route<dynamic> route) => false, 
                      );
                    } else {
                      CustomToast.show(context, "Logout fehlgeschlagen!");
                      print("Failed to log out!");
                    }
                  },
                  text: 'Ausloggen',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
