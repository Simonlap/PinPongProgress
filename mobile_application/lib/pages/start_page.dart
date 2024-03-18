import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _buttonScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
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
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black.withOpacity(1)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 2],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CustomElevatedButton(
                      text: 'Registrieren',
                      onPressed: () {
                        Navigator.pushNamed(context, '/registerpage');
                      },
                      animation: _buttonScaleAnimation,
                    ),
                    CustomElevatedButton(
                      text: 'Login',
                      onPressed: () {
                        Navigator.pushNamed(context, '/loginpage');
                      },
                      animation: _buttonScaleAnimation,
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
