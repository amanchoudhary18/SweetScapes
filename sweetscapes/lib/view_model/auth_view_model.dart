import 'package:flutter/material.dart';
import 'package:sweetscapes/repository/auth_repository.dart';
import 'package:sweetscapes/utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _myrepo = AuthRepository();

  Future<void> loginUrl(dynamic data, BuildContext context) async {
    _myrepo
        .loginUrl(data)
        .then((value) => {
          Utils.goErrorFlush('Logged In Successfully', context),
        })
        .onError((error, stackTrace) => {
          Utils.goErrorFlush(error.toString(), context),
        });
  }
}
