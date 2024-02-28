import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800), // Make the animation faster
      vsync: this,
    )..repeat(reverse: true);

    _buttonAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(CurvedAnimation( // Increase the scaling effect
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Spacer(),
            Text(
              "PingPong Progress",
              textAlign: TextAlign.center,
              style: GoogleFonts.bebasNeue(
                textStyle: TextStyle(
                  color: Color(0xFFFFE019),
                  fontSize: 110,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 7.0,
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ScaleTransition(
                    scale: _buttonAnimation,
                    child: _animatedButton("Register", '/registerpage'),
                  ),
                  ScaleTransition(
                    scale: _buttonAnimation,
                    child: _animatedButton("Login", '/loginpage'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _animatedButton(String text, String route) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF294597),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      ),
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xFFFFE019),
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
