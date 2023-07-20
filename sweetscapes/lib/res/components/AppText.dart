import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../enums/Fonts.dart';

class AppText extends StatelessWidget {
  AppText({
    super.key,
    required this.text,
    required this.size,
    required this.font,
    required this.weight,
    required this.color,
  });

  final String text;
  final double size;
  final Fonts font;
  final FontWeight weight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontFamily: (font == Fonts.TITLE)
            ? 'SpaceGrotesk'
            : (font == Fonts.SUBTITLE)
                ? 'GeneralSans'
                : (font == Fonts.BUTTON)
                    ? 'ClashGrotesk'
                    : '',
        fontWeight: weight,
        color: color,
      ),
    );
  }
}
