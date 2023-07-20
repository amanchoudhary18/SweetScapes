import 'package:flutter/material.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/components/AppText.dart';
import 'package:sweetscapes/res/enums/Fonts.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton(
      {super.key,
      required this.title,
      this.loading = false,
      required this.onPress});

  final String title;
  final bool loading;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        // height: 40,
        // width: 200,
        decoration: BoxDecoration(
          color: AppColor.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Center(
            child: loading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : AppText(
                    text: title,
                    size: 20,
                    font: Fonts.BUTTON,
                    weight: FontWeight.w600,
                    color: AppColor.black,
                  ),
          ),
        ),
      ),
    );
  }
}
