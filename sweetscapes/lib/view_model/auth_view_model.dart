import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetscapes/data/response/api_response.dart';
import 'package:sweetscapes/model/user_model.dart';
import 'package:sweetscapes/repository/auth_repository.dart';
import 'package:sweetscapes/utils/routes/routes_name.dart';
import 'package:sweetscapes/utils/utils.dart';
import 'package:sweetscapes/view_model/user_view_model.dart';

class AuthViewModel with ChangeNotifier {
  final _myrepo = AuthRepository();
  bool _loading = false;
  bool get loading => _loading;

  ApiResponse<UserModel> userData = ApiResponse.loading();

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setuserDataStatus(ApiResponse<UserModel> response) {
    userData = response;
    notifyListeners();
  }

  Future<void> loginUrl(dynamic data, BuildContext context) async {
    userData = ApiResponse.loading();
    final userPreference = Provider.of<UserViewModel>(context, listen: false);

    setLoading(true);
    _myrepo
        .loginUrl(data)
        .then((value) => {
              setLoading(false),
              // final userPreference = Provider.of<UserViewModel>(context , listen: false);
              if (value.status.toString() == 'Successful')
                {
                  userPreference
                      .saveUser(UserModel(token: value.token.toString())),
                  userData = ApiResponse.completed(value),
                  Utils.goFlushBar('Login Successful', context),
                  Navigator.pushNamed(context, RoutesName.home),
                }
              else
                {
                  Utils.goErrorFlush('Try Again', context),
                },
              if (kDebugMode)
                {
                  print(value.toString()),
                },
            })
        .onError(
          (error, stackTrace) => {
            setLoading(false),
            userData = ApiResponse.error(error.toString()),
            Utils.goErrorFlush(error.toString(), context),
          },
        );
  }
}
