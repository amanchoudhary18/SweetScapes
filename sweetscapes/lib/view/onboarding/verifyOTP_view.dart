import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/components/AppText.dart';
import 'package:sweetscapes/res/enums/Fonts.dart';
import 'package:sweetscapes/res/fonts.dart';
import 'package:sweetscapes/view_model/onboarding/auth_view_model.dart';

@RoutePage()
class VerifyOTPView extends StatelessWidget {
  VerifyOTPView({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    TextEditingController otpController = TextEditingController();
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
                  text: 'Enter OTP',
                  size: 28,
                  font: Fonts.TITLE,
                  weight: FontWeight.w700,
                  color: AppColor.black,
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'OTP sent to',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: AppFonts.subtitle,
                    fontWeight: FontWeight.normal,
                    color: AppColor.black,
                    letterSpacing: 0.2,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      authViewModel.userEmail,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: AppFonts.subtitle,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    GestureDetector(
                      onTap: () {
                        AutoRouter.of(context).pop();
                      },
                      child: Text(
                        'Change',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          fontFamily: AppFonts.subtitle,
                          fontWeight: FontWeight.w700,
                          color: AppColor.primary,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 52,
                ),
                OtpTextField(
                  numberOfFields: 4,
                  fieldWidth: 56,
                  focusedBorderColor: AppColor.primary,
                  cursorColor: AppColor.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  enabledBorderColor: AppColor.black,
                  borderWidth: 1,
                  mainAxisAlignment: MainAxisAlignment.start,
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode) {
                    otpController.text = verificationCode;
                  }, // end onSubmit
                ),
                Visibility(
                  visible: authViewModel.isResendVisible,
                  child: GestureDetector(
                    onTap: () {
                      authViewModel.signUp(authViewModel.userEmail, context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Resend",
                        style: const TextStyle(
                          color: AppColor.primary,
                          fontFamily: AppFonts.subtitle,
                          decoration: TextDecoration.underline,
                          fontSize: 18,
                          letterSpacing: 0.14,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  onTap: () {
                    authViewModel.verifyOtp(
                        otpController.text.toString().trim(), context);
                  },
                  child: UnconstrainedBox(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.secondary,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColor.black),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        child: Text(
                          'Verify OTP',
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
