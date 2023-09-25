import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sweetscapes/app/routes/router.gr.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/components/AppText.dart';
import 'package:sweetscapes/res/enums/Fonts.dart';
import 'package:sweetscapes/res/fonts.dart';
import 'package:sweetscapes/view_model/onboarding/auth_view_model.dart';

@RoutePage()
class LoginView extends StatelessWidget {
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 130, 30, 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/svgFiles/College.svg',
                        semanticsLabel: 'Acme Logo'),
                    const SizedBox(
                      height: 57,
                    ),
                    AppText(
                      text: 'Glad to see you here!',
                      size: 28,
                      font: Fonts.TITLE,
                      weight: FontWeight.w700,
                      color: AppColor.black,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    AppText(
                      text: 'Verify your email to continue',
                      size: 16,
                      font: Fonts.SUBTITLE,
                      weight: FontWeight.w400,
                      color: AppColor.black,
                    ),
                    const SizedBox(
                      height: 58,
                    ),
                    UnconstrainedBox(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.secondary,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColor.black),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Note: Please use your ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: AppFonts.subtitle,
                                  fontWeight: FontWeight.normal,
                                  color: AppColor.black,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              Text(
                                'BIT Mesra Email',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: AppFonts.subtitle,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.black,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const SizedBox(
                    //   height: 66,
                    // ),
                    InkWell(
                      onTap: () {
                        authViewModel.googleAuthSignIn(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Continue with Google',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: AppFonts.button,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.white,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                height: 24,
                                child: SvgPicture.asset(
                                  'assets/svgFiles/google.svg',
                                  height: 24,
                                  colorFilter: const ColorFilter.mode(
                                      AppColor.white, BlendMode.srcIn),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    InkWell(
                      onTap: () {
                        authViewModel.resetIncorrectEmailMessage();
                        AutoRouter.of(context).push(VerifyEmailViewRoute());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.secondary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Continue with Email',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: AppFonts.button,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.black,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                height: 24,
                                child: SvgPicture.asset(
                                  'assets/svgFiles/mail.svg',
                                  height: 24,
                                  colorFilter: const ColorFilter.mode(
                                      AppColor.black, BlendMode.srcIn),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
