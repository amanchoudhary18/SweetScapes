import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/components/primary_button.dart';
import 'package:sweetscapes/res/fonts.dart';

class NoPlansPlaceHolder extends StatelessWidget {
  const NoPlansPlaceHolder({
    super.key,
    required this.title,
    required this.content,
    required this.btnTitle,
    required this.onPress,
  });

  final String title;
  final String content;
  final String btnTitle;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/svgFiles/noPlans.svg',
          height: 250,
        ),
        Text(
          title,
          style: const TextStyle(
            color: AppColor.grey4oo,
            fontFamily: AppFonts.title,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            height: 1.33,
            letterSpacing: -0.408,
          ),
        ),
        Text(
          content,
          style: const TextStyle(
            color: AppColor.grey4oo,
            fontFamily: AppFonts.subtitle,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 1.43,
            letterSpacing: 0.21,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 100),
          child: PrimaryButton(title: btnTitle, onPress: onPress),
        )
      ],
    );
  }
}