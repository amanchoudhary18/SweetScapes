import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetscapes/repository/user_repository.dart';
import 'package:sweetscapes/res/enums/DateType.dart';
import 'package:sweetscapes/res/enums/Genders.dart';

import '../../model/user_model.dart';
import '../../utils/routes/routes_arguments.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../user_view_model.dart';

class UpdateTagsViewModel with ChangeNotifier {
  List<String> dineChipText = [
    "Fine Dining",
    "Decent Dining",
    "Dhabas",
    "Home Delivery",
    "Take Away",
    "Home-made",
    "Cafes",
  ];

  List<bool> dineSelectedChips = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  List<String> outingChipText = [
    "Hills, Lakes",
    "Dams, Waterfalls",
    "Malls",
    "Movie",
    "Park",
    "Picnics",
    "Clubbing",
    "Night Out",
    "Window Shopping",
  ];

  List<bool> outingSelectedChips = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  bool showDialogHere = true;

  final _myRepo = UserRepository();
  int _onboardingState = 0;
  DateTime _userBirthDay = DateTime(2000, 1, 1);
  Genders _userGender = Genders.MALE;

  DateTime get userBirthDay => _userBirthDay;

  int get onboardingState => _onboardingState;

  Genders get userGender => _userGender;

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

  void updateonboardingState(int value) {
    _onboardingState = value;
    notifyListeners();
  }

  updateChipStatus(int index, DateType dateType) {
    if (dateType == DateType.DINEOUT) {
      dineSelectedChips[index] = !dineSelectedChips[index];
    } else if (dateType == DateType.OUTING) {
      outingSelectedChips[index] = !outingSelectedChips[index];
    }
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

    Map data = {'birthday': userBday, 'gender': userGen};

    _myRepo
        .updateUserDetailsUrl(data, token)
        .then((value) => {
              if (value.status.toString() == 'Successful')
                {
                  Utils.goFlushBar('Birthday and Gender Updated', context),
                  updateonboardingState(1),
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

  void submitPreferences(BuildContext context) async {
    final userPreference = Provider.of<UserViewModel>(context, listen: false);
    UserModel loggedInUser = await userPreference.getUser();
    String token = loggedInUser.token.toString();

    String userBday = _userBirthDay.millisecondsSinceEpoch.toString();
    String userGen = (_userGender == Genders.MALE)
        ? 'Male'
        : (_userGender == Genders.FEMALE)
            ? 'Female'
            : 'Others';

    Map data = {'birthday': userBday, 'gender': userGen};

    _myRepo
        .updateUserDetailsUrl(data, token)
        .then((value) => {
              if (value.status.toString() == 'Successful')
                {
                  Utils.goFlushBar('Preferences Updated', context),
                  userPreference.saveUser(
                    UserModel(
                      token: value.token.toString(),
                      user: User(
                        isSubscribed: value.user!.isSubscribed!,
                        isNew: value.user!.isNew!,
                      ),
                    ),
                  ),
                  updateShowDialogHere(false),
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
