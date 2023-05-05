import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../app/routes/router.gr.dart';
import '../../view_model/user_view_model.dart';

@RoutePage()
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
            AutoRouter.of(context).push(LoginViewRoute());
          },
        ),
      ),
    );
  }
}
