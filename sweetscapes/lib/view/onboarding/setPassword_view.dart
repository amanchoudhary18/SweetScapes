import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../res/components/round_button.dart';
import '../../utils/utils.dart';
import '../../view_model/onboarding/auth_view_model.dart';

class SetupPasswordView extends StatelessWidget {
  SetupPasswordView({super.key});

  ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);
  TextEditingController _passwordController = TextEditingController();

  final TextEditingController _nameInputController = TextEditingController();
  final FocusNode _nameInputNode = FocusNode();
  final FocusNode _passwordInputNode = FocusNode();

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
                  controller: _nameInputController,
                  focusNode: _nameInputNode,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.person_2_outlined,
                    ),
                    hintText: 'Enter your Name',
                    labelText: 'Name',
                  ),
                  onFieldSubmitted: (value) => Utils.fieldFocusChange(
                    context,
                    _nameInputNode,
                    _passwordInputNode,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _obscurePassword,
                  builder: (context, value, child) {
                    return TextFormField(
                      focusNode: _passwordInputNode,
                      controller: _passwordController,
                      obscureText: _obscurePassword.value,
                      obscuringCharacter: '~',
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
                    title: 'SET PASSWORD',
                    onPress: () {
                      Map data = {
                        "name": _nameInputController.text.toString().trim(),
                        "password": _passwordController.text.toString().trim(),
                      };
                      authViewModel.setNameAndPassword(data, context);
                    },
                    loading: authViewModel.passwordloading,
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
