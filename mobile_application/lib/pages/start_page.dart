import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF294597),  // Blue shade
              Color(0xFFFFE019),  // Yellow shade
            ],
          ),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Text(
                "Ping Pong Progress",
                textAlign: TextAlign.center,
                style: GoogleFonts.bebasNeue(
                  textStyle: TextStyle(
                    fontSize: 60, // Increased font size
                    color: Colors.white, // Text color changed to white for contrast
                    fontWeight: FontWeight.bold, // Font weight
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/registerpage');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFFE019), // Yellow shade for button background
                        onPrimary: Color(0xFF294597), // Blue shade for text
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: Text(
                          'Register',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/loginpage');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFFE019), // Yellow shade for button background
                        onPrimary: Color(0xFF294597), // Blue shade for text
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
