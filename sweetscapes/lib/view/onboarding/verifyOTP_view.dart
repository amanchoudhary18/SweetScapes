import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/components/AppText.dart';
import 'package:sweetscapes/res/components/primary_button.dart';
import 'package:sweetscapes/res/enums/Fonts.dart';
import 'package:sweetscapes/res/fonts.dart';
import 'package:sweetscapes/view_model/onboarding/auth_view_model.dart';

@RoutePage()
class VerifyOTPView extends StatelessWidget {
  VerifyOTPView({super.key});

  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: AppText(
                        text: 'Enter OTP',
                        size: 28,
                        font: Fonts.TITLE,
                        weight: FontWeight.w700,
                        color: AppColor.black,
                      ),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 44.0),
                      child: OtpTextField(
                        numberOfFields: 4,
                        fieldWidth: 56,
                        focusedBorderColor: AppColor.primary,
                        cursorColor: AppColor.primary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0)),
                        enabledBorderColor: AppColor.black,
                        borderWidth: 1,
                        mainAxisAlignment: MainAxisAlignment.start,
                        showFieldAsBox: true,
                        onCodeChanged: (String code) {
                          //handle validation or checks here
                        },
                        //runs when every textfield is filled
                        onSubmit: (String verificationCode) {
                          otpController.text = verificationCode;
                        }, // end onSubmit
                      ),
                    ),
                    Row(
                      children: [
                        if (authViewModel.incorrectOTPmessage != '')
                        Text(
                          authViewModel.incorrectOTPmessage,
                          style: const TextStyle(
                            color: Colors.red,
                            fontFamily: AppFonts.subtitle,
                            fontSize: 14,
                            letterSpacing: 0.14,
                          ),
                        ),
                        if (authViewModel.incorrectOTPmessage != '')
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: AppColor.secondary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (authViewModel.isResendVisible) {
                              authViewModel.signUp(
                                  authViewModel.userEmail, context);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              (authViewModel.isResendVisible)
                                  ? 'Resend OTP now'
                                  : 'Resend OTP (in ${authViewModel.remainingSeconds} sec)',
                              style: TextStyle(
                                color: (authViewModel.isResendVisible)
                                    ? AppColor.primary
                                    : AppColor.black,
                                fontFamily: AppFonts.subtitle,
                                decoration: (authViewModel.isResendVisible)
                                    ? TextDecoration.underline
                                    : TextDecoration.none,
                                fontSize: 14,
                                letterSpacing: 0.161,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: PrimaryButton(
                        title: (!authViewModel.verifyOtploading)
                            ? 'Verify OTP'
                            : 'Checking . . .',
                        onPress: () {
                          authViewModel.verifyOtp(
                              otpController.text.toString().trim(), context);
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColor.secondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    onTap: () {
                      AutoRouter.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      size: 30,
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
