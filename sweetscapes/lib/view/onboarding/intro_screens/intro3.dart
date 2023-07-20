import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/components/primary_button.dart';

import '../../../app/routes/router.gr.dart';
import '../../../res/components/AppText.dart';
import '../../../res/components/secondary_button.dart';
import '../../../res/enums/Fonts.dart';

@RoutePage()
class IntroScreen3 extends StatelessWidget {
  const IntroScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 130, 30, 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      child: Image.asset(
                        'assets/images/intro3.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 36,
                    ),
                    AppText(
                      text: 'Unlock effortless\nexploration',
                      size: 28,
                      font: Fonts.TITLE,
                      weight: FontWeight.w700,
                      color: AppColor.black,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AppText(
                      text:
                          'Smooth city navigation with transport info, route guidance, and essential contacts for a hassle-free journey.',
                      size: 16,
                      font: Fonts.SUBTITLE,
                      weight: FontWeight.w400,
                      color: AppColor.black,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.4),
                          radius: 4,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.4),
                          radius: 4,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 4,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SecondaryButton(
                            title: 'Back',
                            onPress: () {
                              AutoRouter.of(context).pop();
                            }),
                        SizedBox(
                          width: 9,
                        ),
                        PrimaryButton(
                            title: 'Proceed',
                            onPress: () {
                              AutoRouter.of(context).push(LoginViewRoute());
                            }),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
