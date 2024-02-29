import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final String text;
  final String? subtitle;
  final Function()? onPressed; 
  final Animation<double>? animation;
  final Size? minimumSize;
  final double? fontSize;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.subtitle,
    this.animation,
    this.minimumSize,
    this.fontSize,
  }) : super(key: key);

  @override
  _CustomElevatedButtonState createState() => _CustomElevatedButtonState();
  
  static Widget customButton(
      String text, {
      dynamic? onPressed,
      Size? minimumSize,
      double? fontSize,
      BuildContext? context,
      String? route,
      String? subtitle,
    }) {
      return Row(
        children: <Widget>[
          Expanded(
            child: CustomElevatedButton(
              text: text,
              onPressed: onPressed ?? (context != null && route != null ? () => Navigator.pushNamed(context, route) : null),
              minimumSize: minimumSize ?? const Size(0, 100),
              fontSize: fontSize ?? 24,
              subtitle: subtitle ?? null,
            ),
          ),
        ],
      );
    }
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> with SingleTickerProviderStateMixin {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animation ?? AlwaysStoppedAnimation(1),
      builder: (context, child) {
        return Transform.scale(
          scale: widget.animation?.value ?? 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF294597),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              minimumSize: widget.minimumSize,
            ),
            onPressed: _isLoading || widget.onPressed == null
              ? null
              : () async {
                  setState(() => _isLoading = true);
                  try {
                    final result = widget.onPressed!();
                    if (result is Future) {
                      await result;
                    }
                  } catch (e) {
                    print(e);
                  } finally {
                    if (mounted) {
                      setState(() => _isLoading = false);
                    }
                  }
                },
            child: _isLoading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFFFFE019)),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.text,
                        style: TextStyle(
                          color: const Color(0xFFFFE019),
                          fontSize: widget.fontSize ?? 15,
                          fontWeight: FontWeight.bold,
                          
                        ),
                        
                      ),
                      if (widget.subtitle != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            widget.subtitle!,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: widget.fontSize != null ? widget.fontSize! * 0.75 : 11,
                            ),
                          ),
                        ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
