import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sweetscapes/app/routes/router.gr.dart';
import 'package:sweetscapes/data/app_exceptions.dart';
import 'package:sweetscapes/model/user_model.dart';
import 'package:sweetscapes/view/home_screen.dart';
import 'package:sweetscapes/view_model/user_view_model.dart';

class SplashServices {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async {
      if (kDebugMode) {
        print('Here ${value.token}');
      }
      if (value.token == null || value.token == 'null') {
        await Future.delayed(const Duration(seconds: 2));
        AutoRouter.of(context).popAndPush(LoginViewRoute());
      } else if (value.user!.isNew ?? true == true) {
        await Future.delayed(const Duration(seconds: 2));
        AutoRouter.of(context).popAndPush(UpdateTagsViewRoute());
      } else {
        await Future.delayed(const Duration(seconds: 2));
        AutoRouter.of(context).popAndPush(HomeScreenRoute());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
