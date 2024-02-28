import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/tsgDuelmen.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns the children vertically
          children: <Widget>[
            Spacer(), // This will take all available space, pushing everything below to the bottom
            Text(
              "PingPong Progress",
              textAlign: TextAlign.center, // Centers the text horizontally
              style: GoogleFonts.bebasNeue( // Using GoogleFonts for styling
                textStyle: TextStyle(
                  color: Color(0xFFFFE019), // Text color
                  fontSize: 110, // Font size
                  fontWeight: FontWeight.bold, // Font weight
                ),
              ),
            ),
            Spacer(), // Another spacer to balance the layout
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70.0, vertical: 20.0), // Padding around the buttons
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out the buttons evenly
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF294597), // Button color #294597
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12), // Button padding
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/registerpage');
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Color(0xFFFFE019),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF294597), // Button color #294597
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12), // Button padding
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/loginpage');
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xFFFFE019),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
