import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sweetscapes/res/components/round_button.dart';
import 'package:sweetscapes/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:sweetscapes/view_model/onboarding/auth_view_model.dart';

@RoutePage()
class LoginView extends StatelessWidget {
  LoginView({super.key});

  ValueNotifier<bool> _obscureLoginPassword = ValueNotifier<bool>(true);

  TextEditingController _emailLoginController = TextEditingController();
  TextEditingController _passwordLoginController = TextEditingController();

  FocusNode _emailLoginNode = FocusNode();
  FocusNode _passwordLoginNode = FocusNode();

  ValueNotifier<bool> _obscureSignupPassword = ValueNotifier<bool>(true);

  TextEditingController _emailSignUpController = TextEditingController();
  TextEditingController _passwordSignUpController = TextEditingController();

  FocusNode _emailSignUpNode = FocusNode();
  FocusNode _passwordSignUpNode = FocusNode();

  TextEditingController _otpController = TextEditingController();

  FocusNode _otpNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFFDFBF0),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _emailLoginController,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: _emailLoginNode,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.email_rounded,
                    ),
                    hintText: 'Enter your mailID',
                    labelText: 'Institute Mail ID',
                  ),
                  onFieldSubmitted: (value) => Utils.fieldFocusChange(
                    context,
                    _emailLoginNode,
                    _passwordLoginNode,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _obscureLoginPassword,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: _passwordLoginController,
                      obscureText: _obscureLoginPassword.value,
                      obscuringCharacter: '~',
                      focusNode: _passwordLoginNode,
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.password_rounded,
                        ),
                        hintText: 'Enter your Password',
                        labelText: 'Password',
                        suffix: InkWell(
                          onTap: () {
                            _obscureLoginPassword.value =
                                !_obscureLoginPassword.value;
                          },
                          child: Icon(_obscureLoginPassword.value
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded),
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RoundButton(
                    title: 'LOGIN',
                    onPress: () {
                      Map data = {
                        'email': _emailLoginController.text.toString().trim(),
                        'password':
                            _passwordLoginController.text.toString().trim(),
                      };
                      authViewModel.loginUrl(data, context);
                    },
                    loading: authViewModel.loading,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailSignUpController,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: _emailSignUpNode,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.email_rounded,
                    ),
                    hintText: 'Enter your mailID',
                    labelText: 'Institute Mail ID',
                  ),
                  onFieldSubmitted: (value) => Utils.fieldFocusChange(
                    context,
                    _emailSignUpNode,
                    _passwordSignUpNode,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RoundButton(
                    title: 'SEND OTP',
                    onPress: () {
                      authViewModel.signUp(
                          _emailSignUpController.text.toString().trim(),
                          context);
                    },
                    loading: authViewModel.signUploading,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  focusNode: _otpNode,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.account_circle_outlined,
                    ),
                    hintText: 'Enter OTP',
                    labelText: 'OTP',
                  ),
                  onFieldSubmitted: (value) => Utils.fieldFocusChange(
                    context,
                    _emailSignUpNode,
                    _passwordSignUpNode,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RoundButton(
                    title: 'VERIFY OTP',
                    onPress: () {
                      authViewModel.verifyOtp(
                          _otpController.text.toString().trim(), context);
                    },
                    loading: authViewModel.verifyOtploading,
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      authViewModel.googleAuthLogIn(context);
                    },
                    child: Container(
                      width: 300,
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 40,
                            child: Image.asset(
                              'assets/images/google.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('Log-in with Google'),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      authViewModel.googleAuthSignIn(context);
                    },
                    child: Container(
                      width: 300,
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 40,
                            child: Image.asset(
                              'assets/images/google.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('Sign-in with Google'),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
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
