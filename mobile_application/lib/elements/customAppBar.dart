import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool? automaticallyImplyLeading;

  CustomAppBar({required this.title, this.actions, this.automaticallyImplyLeading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white, 
        ),
      ),
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      backgroundColor: Color(0xFF294597),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); 
}
