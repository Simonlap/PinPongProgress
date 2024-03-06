import 'package:flutter/material.dart';

class CustomToast {
  static void show(BuildContext context, String message) {
    OverlayEntry overlayEntry = OverlayEntry(builder: (context) => CustomToastWidget(message: message));
    Overlay.of(context)!.insert(overlayEntry);

    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}

class CustomToastWidget extends StatefulWidget {
  final String message;

  const CustomToastWidget({Key? key, required this.message}) : super(key: key);

  @override
  _CustomToastWidgetState createState() => _CustomToastWidgetState();
}

class _CustomToastWidgetState extends State<CustomToastWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _positionAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _positionAnimation = Tween<Offset>(
      begin: Offset(0, 3.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));

    _controller.forward();

    Future.delayed(Duration(seconds: 2), () {
      _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50.0,
      child: Material(
        color: Colors.transparent,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _positionAnimation,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFFE019).withOpacity(0.95),
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  widget.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFF294597),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
