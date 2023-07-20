import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/components/primary_button.dart';

import '../../../app/routes/router.gr.dart';
import '../../../res/components/AppText.dart';
import '../../../res/enums/Fonts.dart';

@RoutePage()
class IntroScreen1 extends StatelessWidget {
  const IntroScreen1({super.key});

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
                        'assets/images/intro1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 36,
                    ),
                    AppText(
                      text: 'Discover the\nessence of cities',
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
                          'Unleash the explorer within as SweetScapes takes you on a thrilling journey through hidden gems and uncharted territories, revealing the soul of every city you visit.',
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
                          backgroundColor: Colors.black,
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
                          backgroundColor: Colors.black.withOpacity(0.4),
                          radius: 4,
                        )
                      ],
                    ),
                    PrimaryButton(title: 'Next', onPress: () {
                      AutoRouter.of(context).push(IntroScreen2Route());
                    })
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
