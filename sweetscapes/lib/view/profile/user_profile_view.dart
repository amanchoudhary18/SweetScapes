import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../utils/routes/routes_name.dart';
import '../../view_model/user_view_model.dart';

class UserProfileView extends StatelessWidget {
  UserProfileView({super.key});

  UserViewModel userViewModel = UserViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Logout'),
          onPressed: () {
            userViewModel.remove();
            Navigator.pushNamed(context, RoutesName.login);
          },
        ),
      ),
    );
  }
}
