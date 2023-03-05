import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sweetscapes/res/components/round_button.dart';
import 'package:sweetscapes/utils/routes/routes_name.dart';
import 'package:sweetscapes/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:sweetscapes/view_model/auth_view_model.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  ValueNotifier<bool> _obscureLoginPassword = ValueNotifier<bool>(true);

  TextEditingController _phoneLoginController = TextEditingController();
  TextEditingController _passwordLoginController = TextEditingController();

  FocusNode _phoneLoginNode = FocusNode();
  FocusNode _passwordLoginNode = FocusNode();

  ValueNotifier<bool> _obscureSignupPassword = ValueNotifier<bool>(true);

  TextEditingController _nameSignUpController = TextEditingController();
  TextEditingController _phoneSignUpController = TextEditingController();
  TextEditingController _passwordSignUpController = TextEditingController();

  FocusNode _nameSignUpNode = FocusNode();
  FocusNode _phoneSignUpNode = FocusNode();
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
                  controller: _phoneLoginController,
                  keyboardType: TextInputType.phone,
                  focusNode: _phoneLoginNode,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.phone_rounded,
                    ),
                    hintText: 'Enter your Phone Number',
                    labelText: 'Phone Number',
                  ),
                  onFieldSubmitted: (value) => Utils.fieldFocusChange(
                    context,
                    _phoneLoginNode,
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
                        'mobileNumber':
                            _phoneLoginController.text.toString().trim(),
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
                  controller: _nameSignUpController,
                  keyboardType: TextInputType.name,
                  focusNode: _nameSignUpNode,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.person_2_outlined,
                    ),
                    hintText: 'Enter your Name',
                    labelText: 'Full Name',
                  ),
                  onFieldSubmitted: (value) => Utils.fieldFocusChange(
                    context,
                    _nameSignUpNode,
                    _phoneSignUpNode,
                  ),
                ),
                TextFormField(
                  controller: _phoneSignUpController,
                  keyboardType: TextInputType.phone,
                  focusNode: _phoneSignUpNode,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.phone_rounded,
                    ),
                    hintText: 'Enter your Phone Number',
                    labelText: 'Phone Number',
                  ),
                  onFieldSubmitted: (value) => Utils.fieldFocusChange(
                    context,
                    _phoneSignUpNode,
                    _passwordSignUpNode,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _obscureSignupPassword,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: _passwordSignUpController,
                      obscureText: _obscureSignupPassword.value,
                      obscuringCharacter: '~',
                      focusNode: _passwordSignUpNode,
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.password_rounded,
                        ),
                        hintText: 'Enter your Password',
                        labelText: 'Password',
                        suffix: InkWell(
                          onTap: () {
                            _obscureSignupPassword.value =
                                !_obscureSignupPassword.value;
                          },
                          child: Icon(_obscureSignupPassword.value
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
                    title: 'SIGNUP',
                    onPress: () {
                      Map data = {
                        'name': _nameSignUpController.text.toString().trim(),
                        'mobileNumber':
                            _phoneSignUpController.text.toString().trim(),
                        'password':
                            _passwordSignUpController.text.toString().trim(),
                      };
                      authViewModel.signUp(data, context);
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
                    _phoneSignUpNode,
                    _passwordSignUpNode,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RoundButton(
                    title: 'VERIFY OTP',
                    onPress: () {
                      authViewModel.verifyOtp(_otpController.text.toString().trim(), context);
                    },
                    loading: authViewModel.verifyOtploading,
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
