import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:sweetscapes/model/response/getMyData_response.dart';
import 'package:sweetscapes/model/user_model.dart';
import 'package:sweetscapes/repository/user_repository.dart';
import 'package:sweetscapes/utils/utils.dart';

import '../../app/routes/router.gr.dart';
import '../../view_model/user_view_model.dart';

class UserProfileViewModel extends BaseViewModel {
  UserViewModel userViewModel = UserViewModel();
  String _userName = "";
  String get userName => _userName;
  final _userRepo = UserRepository();

  void getName(BuildContext context) {
    notifyListeners();
  }

  UserData getMyDataResponse = UserData();

  Future<UserData> getMyData(BuildContext context) async {
    final userPreference = Provider.of<UserViewModel>(context, listen: false);
    UserModel loggedInUser = await userPreference.getUser();
    String token = loggedInUser.token.toString();

    await _userRepo
        .getMyData(token)
        .then((value) => {
              if (value.status.toString() == 'Successful')
                {
                  getMyDataResponse = value.userData!,
                }
              
            })
        .onError(
          (error, stackTrace) => {
            Utils.goErrorFlush(error.toString(), context),
          },
        );

    return getMyDataResponse;
  }

  void logoutPressed(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context, listen: false);
    userPreference.remove();
    AutoRouter.of(context).push(LoginViewRoute());
  }
}
