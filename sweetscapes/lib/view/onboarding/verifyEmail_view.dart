import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/components/AppText.dart';
import 'package:sweetscapes/res/components/primary_button.dart';
import 'package:sweetscapes/res/enums/Fonts.dart';
import 'package:sweetscapes/res/fonts.dart';
import 'package:sweetscapes/utils/textDirectory.dart';
import 'package:sweetscapes/view_model/onboarding/auth_view_model.dart';

@RoutePage()
class VerifyEmailView extends StatelessWidget {
  VerifyEmailView({super.key});

  final TextEditingController emailSignUpController = TextEditingController();
  final FocusNode emailSignUpNode = FocusNode();

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
                        text: 'Verify email via OTP',
                        size: 28,
                        font: Fonts.TITLE,
                        weight: FontWeight.w700,
                        color: AppColor.black,
                      ),
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 44, 0, 6),
                      child: TextDirectory.labelSmallBold(context, 'Email'),
                    ),
                    TextFormField(
                      controller: emailSignUpController,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: emailSignUpNode,
                      decoration: const InputDecoration(
                        hintText: 'ex: abc@bitmesra.ac.in',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: AppColor.secondary,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: AppColor.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
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
                    PrimaryButton(
                      title: (!authViewModel.signUploading)
                          ? 'Get OTP'
                          : 'Loading . . .',
                      onPress: () {
                        authViewModel.signUp(
                            emailSignUpController.text.toString().trim(),
                            context);
                      },
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
