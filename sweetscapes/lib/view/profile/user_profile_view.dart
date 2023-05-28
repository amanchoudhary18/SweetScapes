import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:stacked/stacked.dart';
import 'package:sweetscapes/view/profile/user_profile_viewmodel.dart';

import '../../app/routes/router.gr.dart';
import '../../view_model/user_view_model.dart';

@RoutePage()
class UserProfileView extends StatelessWidget {
  UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => UserProfileViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text('Get Name'),
                onPressed: () {
                  model.getName(context);
                },
              ),
              Card(
                child: Text(model.userName),
              ),
              ElevatedButton(
                child: Text('Logout'),
                onPressed: () {
                  model.logoutPressed(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
