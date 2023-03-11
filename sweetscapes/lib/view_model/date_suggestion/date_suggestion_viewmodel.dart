import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetscapes/repository/user_repository.dart';
import 'package:sweetscapes/res/enums/Genders.dart';

import '../../model/user_model.dart';
import '../../utils/routes/routes_arguments.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../user_view_model.dart';

class DateSuggestionViewModel with ChangeNotifier {
  final _myRepo = UserRepository();

  DateTime _userBirthDay = DateTime(2000, 1, 1);
  DateTime get userBirthDay => _userBirthDay;

  Genders _userGender = Genders.MALE;
  Genders get userGender => _userGender;

  bool showDialogHere = true;

  void updateBirthday(DateTime value) {
    _userBirthDay = value;
    notifyListeners();
  }

  void updateGender(Genders value) {
    _userGender = value;
    notifyListeners();
  }

  void updateShowDialogHere(bool value) {
    showDialogHere = value;
    notifyListeners();
  }

  void submitBasicDetails(BuildContext context) async {
    final userPreference = Provider.of<UserViewModel>(context, listen: false);
    UserModel loggedInUser = await userPreference.getUser();
    String token = loggedInUser.token.toString();

    String userBday = _userBirthDay.millisecondsSinceEpoch.toString();
    String userGen = (_userGender == Genders.MALE)
        ? 'Male'
        : (_userGender == Genders.FEMALE)
            ? 'Female'
            : 'Others';

    Map data = {'birthday': userBday, 'age': userGen};

    _myRepo
        .updateUserDetailsUrl(data, token)
        .then((value) => {
              if (value.status.toString() == 'Successful')
                {
                  Utils.goFlushBar('Birthday and Gender Updated', context),
                  // Navigator.pushReplacementNamed(
                  //   context,
                  //   RoutesName.home,
                  //   arguments: HomeScreenArguments(showInitialDialogBox: false),
                  // ),
                  updateShowDialogHere(false),
                  print(showDialogHere),
                }
              else
                {
                  Utils.goErrorFlush('Try Again', context),
                },
            })
        .onError(
          (error, stackTrace) => {
            Utils.goErrorFlush(error.toString(), context),
          },
        );
  }
}
