import 'package:flutter/material.dart';

class CustomToast {
  static void show(BuildContext context, String message) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 70.0, 
        width: MediaQuery.of(context).size.width, 
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            margin: EdgeInsets.symmetric(horizontal: 40.0),
            decoration: BoxDecoration(
              color: Color(0xFFFFE019),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF294597),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Insert the overlay entry into the overlay
    Overlay.of(context)!.insert(overlayEntry);

    // Remove the overlay after some time
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}
