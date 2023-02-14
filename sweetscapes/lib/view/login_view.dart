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

  ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode _phoneNode = FocusNode();
  FocusNode _passwordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                focusNode: _phoneNode,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.phone_rounded,
                  ),
                  hintText: 'Enter your Phone Number',
                  labelText: 'Phone Number',
                ),
                onFieldSubmitted: (value) => Utils.fieldFocusChange(
                  context,
                  _phoneNode,
                  _passwordNode,
                ),
              ),
              ValueListenableBuilder(
                valueListenable: _obscurePassword,
                builder: (context, value, child) {
                  return TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword.value,
                    obscuringCharacter: '~',
                    focusNode: _passwordNode,
                    decoration: InputDecoration(
                      icon: const Icon(
                        Icons.password_rounded,
                      ),
                      hintText: 'Enter your Password',
                      labelText: 'Password',
                      suffix: InkWell(
                        onTap: () {
                          _obscurePassword.value = !_obscurePassword.value;
                        },
                        child: Icon(_obscurePassword.value
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
                      'email': 'eve.holt@reqres.in',
                      'password': 'cityslicka',
                    };
                    authViewModel.loginUrl(data, context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
