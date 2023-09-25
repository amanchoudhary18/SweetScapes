import 'dart:core';
import 'package:flutter/material.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/fonts.dart';

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

class TextDirectory {

  static FittedBox displayLarge(BuildContext context, String text) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: const TextStyle(
          color: AppColor.black,
          fontFamily: AppFonts.title,
          fontWeight: FontWeight.w700,
          fontSize: 36,
          height: 1.33,
          letterSpacing: -0.408,
        ),
      ),
    );
  }

  static FittedBox displayMedium(BuildContext context, String text) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: const TextStyle(
          color: AppColor.black,
          fontFamily: AppFonts.title,
          fontWeight: FontWeight.w700,
          fontSize: 28,
          height: 1.28,
          letterSpacing: -0.408,
        ),
      ),
    );
  }

  static FittedBox displaySmall(BuildContext context, String text) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: const TextStyle(
          color: AppColor.black,
          fontFamily: AppFonts.title,
          fontWeight: FontWeight.w700,
          fontSize: 24,
          height: 1.33,
          letterSpacing: -0.408,
        ),
      ),
    );
  }

  static FittedBox displayXSmall(BuildContext context, String text) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: const TextStyle(
          color: AppColor.black,
          fontFamily: AppFonts.title,
          fontWeight: FontWeight.w700,
          fontSize: 18,
          height: 1.33,
          letterSpacing: -0.408,
        ),
      ),
    );
  }

  static FittedBox headingLarge(BuildContext context, String text) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: const TextStyle(
          color: AppColor.black,
          fontFamily: AppFonts.title,
          fontWeight: FontWeight.w700,
          fontSize: 28,
          height: 1.28,
          letterSpacing: -0.408,
        ),
      ),
    );
  }

  static FittedBox headingMedium(BuildContext context, String text) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: const TextStyle(
          color: AppColor.black,
          fontFamily: AppFonts.title,
          fontWeight: FontWeight.w700,
          fontSize: 24,
          height: 1.33,
          letterSpacing: -0.408,
        ),
      ),
    );
  }

  static FittedBox headingSmall(BuildContext context, String text) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: const TextStyle(
          color: AppColor.black,
          fontFamily: AppFonts.title,
          fontWeight: FontWeight.w700,
          fontSize: 18,
          height: 1.33,
          letterSpacing: -0.408,
        ),
      ),
    );
  }

  static FittedBox headingXSmall(BuildContext context, String text) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: const TextStyle(
          color: AppColor.black,
          fontFamily: AppFonts.title,
          fontWeight: FontWeight.w700,
          fontSize: 16,
          height: 1.50,
          letterSpacing: -0.408,
        ),
      ),
    );
  }

  static FittedBox bodyLarge(BuildContext context, String text) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: const TextStyle(
          color: AppColor.black,
          fontFamily: AppFonts.subtitle,
          fontWeight: FontWeight.w500,
          fontSize: 18,
          height: 1.33,
          letterSpacing: 0.225,
        ),
      ),
    );
  }

  static FittedBox bodyMedium(BuildContext context, String text) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: const TextStyle(
          color: AppColor.black,
          fontFamily: AppFonts.subtitle,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          height: 1.50,
          letterSpacing: 0.28,
        ),
      ),
    );
  }

  static FittedBox bodyRegular(BuildContext context, String text) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: const TextStyle(
          color: AppColor.black,
          fontFamily: AppFonts.subtitle,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 1.50,
          letterSpacing: 0.28,
        ),
      ),
    );
  }

  static FittedBox bodySmall(BuildContext context, String text) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: const TextStyle(
          color: AppColor.black,
          fontFamily: AppFonts.subtitle,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 1.43,
          letterSpacing: 0.21,
        ),
      ),
    );
  }


  static FittedBox bodyXSmall(BuildContext context, String text) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: const TextStyle(
          color: AppColor.black,
          fontFamily: AppFonts.subtitle,
          fontWeight: FontWeight.w400,
          fontSize: 12,
          height: 1.33,
          letterSpacing: 0.24,
        ),
      ),
    );
  }

  static FittedBox labelLarge(BuildContext context, String text) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text.toTitleCase(),
        style: const TextStyle(
          color: AppColor.black,
          fontFamily: AppFonts.title,
          fontWeight: FontWeight.w500,
          fontSize: 18,
          height: 1.33,
          letterSpacing: 0.18,
        ),
      ),
    );
  }

  static FittedBox labelMedium(BuildContext context, String text) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text.toTitleCase(),
        style: const TextStyle(
          color: AppColor.black,
          fontFamily: AppFonts.subtitle,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          height: 1.50,
          letterSpacing: 0.16,
        ),
      ),
    );
  }

  static FittedBox labelSmall(BuildContext context, String text) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text.toTitleCase(),
        style: const TextStyle(
          color: AppColor.black,
          fontFamily: AppFonts.subtitle,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 1.43,
          letterSpacing: 0.161,
        ),
      ),
    );
  }

  static FittedBox labelSmallBold(BuildContext context, String text) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text.toTitleCase(),
        style: const TextStyle(
          color: AppColor.black,
          fontFamily: AppFonts.subtitle,
          fontWeight: FontWeight.w700,
          fontSize: 14,
          height: 1.43,
          letterSpacing: 0.161,
        ),
      ),
    );
  }


  static FittedBox labelXSmall(BuildContext context, String text) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text.toTitleCase(),
        style: const TextStyle(
          color: AppColor.black,
          fontFamily: AppFonts.subtitle,
          fontWeight: FontWeight.w400,
          fontSize: 12,
          height: 1.33,
          letterSpacing: 0.15,
        ),
      ),
    );
  }
}
