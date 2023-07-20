import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/components/AppText.dart';
import 'package:sweetscapes/res/enums/Fonts.dart';
import 'package:sweetscapes/res/fonts.dart';
import 'package:sweetscapes/view_model/onboarding/auth_view_model.dart';

@RoutePage()
class VerifyEmailView extends StatelessWidget {
  VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    TextEditingController emailSignUpController = TextEditingController();
    FocusNode emailSignUpNode = FocusNode();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 52, 24, 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    AutoRouter.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 24,
                  ),
                ),
                const SizedBox(
                  height: 44,
                ),
                AppText(
                  text: 'Verify email via OTP',
                  size: 28,
                  font: Fonts.TITLE,
                  weight: FontWeight.w700,
                  color: AppColor.black,
                ),
                const SizedBox(
                  height: 8,
                ),
                const Row(
                  children: [
                    Text(
                      'Please enter your',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: AppFonts.subtitle,
                        fontWeight: FontWeight.normal,
                        color: AppColor.black,
                        letterSpacing: 0.2,
                      ),
                    ),
                    Text(
                      ' BIT Mesra Email',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: AppFonts.subtitle,
                        fontWeight: FontWeight.w700,
                        color: AppColor.black,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 52,
                ),
                TextFormField(
                  controller: emailSignUpController,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: emailSignUpNode,
                  decoration: const InputDecoration(
                    hintText: 'ex: abc@bitmesra.ac.in',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: AppColor.secondary,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: AppColor.primary,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      authViewModel.errorMessageMail,
                      style: const TextStyle(
                        color: Colors.red,
                        fontFamily: AppFonts.subtitle,
                        fontSize: 14,
                        letterSpacing: 0.14,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    authViewModel.signUp(
                        emailSignUpController.text.toString().trim(), context);
                  },
                  child: UnconstrainedBox(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.secondary,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColor.black),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        child: (authViewModel.signUploading)
                            ? const CircularProgressIndicator(
                                color: AppColor.black,
                                strokeWidth: 2,
                              )
                            : const Text(
                                'Get OTP',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: AppFonts.button,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.black,
                                  letterSpacing: 0.2,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
