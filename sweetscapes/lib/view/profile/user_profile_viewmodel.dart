import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../app/routes/router.gr.dart';
import '../../view_model/user_view_model.dart';

class UserProfileViewModel extends BaseViewModel {
  UserViewModel userViewModel = UserViewModel();
  String _userName = "";
  String get userName => _userName;

  void getName(BuildContext context) {
    notifyListeners();
  }

  void logoutPressed(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context, listen: false);
    userPreference.remove();
    AutoRouter.of(context).push(LoginViewRoute());
  }
}
