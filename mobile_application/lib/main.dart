import 'package:flutter/material.dart';
import 'package:mobile_application/pages/alleGegenAlle_page.dart';
import 'package:mobile_application/pages/home_page.dart';
import 'package:mobile_application/pages/login_page.dart';
import 'package:mobile_application/pages/navigation_page.dart';
import 'package:mobile_application/pages/profile_page.dart';
import 'package:mobile_application/pages/register_page.dart';
import 'package:mobile_application/pages/start_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartPage(),
      routes: {
        '/startpage' :(context) => StartPage(),
        '/loginpage' :(context) => LoginPage(),
        '/registerpage' :(context) => RegisterPage(),
        '/navigationpage' :(context) => NavigationPage(),
        '/homepage' :(context) => HomePage(),
        '/profilePage' :(context) => ProfilePage(),
        '/allegegenallepage' :(context) => AlleGegenAllePage(),
      }
    );
  }
}
