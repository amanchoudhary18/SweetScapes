import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetscapes/model/user_model.dart';

class UserViewModel with ChangeNotifier {

  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.token.toString());
    sp.setBool('isSubscribed', user.user!.isSubscribed!);
    sp.setBool('isNew', user.user!.isNew!);
    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    return UserModel(
      token: sp.getString('token'),
      user: User(
        isSubscribed: sp.getBool('isSubscribed'),
        isNew: sp.getBool('isNew'),
      ),
    );

  }

  Future<bool> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.clear();
  }
  
}
