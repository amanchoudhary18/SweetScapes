import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sweetscapes/data/app_exceptions.dart';
import 'package:sweetscapes/model/user_model.dart';
import 'package:sweetscapes/utils/routes/routes_arguments.dart';
import 'package:sweetscapes/utils/routes/routes_name.dart';
import 'package:sweetscapes/view/home_screen.dart';
import 'package:sweetscapes/view_model/user_view_model.dart';

class SplashServices {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async {
      if (kDebugMode) {
        print(value.token);
      }
      if (value.token == null || value.token == '') {
        await Future.delayed(const Duration(seconds: 2));
        Navigator.popAndPushNamed(
          context,
          RoutesName.login,
        );
      } else if (value.user!.isNew! == true) {
        await Future.delayed(const Duration(seconds: 2));
        Navigator.popAndPushNamed(
          context,
          RoutesName.updateTags,
        );
      } else {
        await Future.delayed(const Duration(seconds: 2));
        Navigator.popAndPushNamed(
          context,
          RoutesName.home,
        );
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
