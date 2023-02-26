import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sweetscapes/model/user_model.dart';
import 'package:sweetscapes/res/components/round_button.dart';
import 'package:sweetscapes/utils/routes/routes_name.dart';
import 'package:sweetscapes/view_model/user_view_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  UserViewModel userViewModel = UserViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: RoundButton(
          title: 'Logout',
          onPress: () {
            userViewModel.remove();
            Navigator.pushNamed(context, RoutesName.login);
          },
        ),
      ),
    );
  }
}
