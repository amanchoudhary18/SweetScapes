import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetscapes/app/routes/router.gr.dart';
import 'package:sweetscapes/data/response/api_response.dart';
import 'package:sweetscapes/model/body/set_preferences_body.dart' as spd;
import 'package:sweetscapes/repository/user_repository.dart';
import 'package:sweetscapes/res/enums/DateType.dart';
import 'package:sweetscapes/res/enums/Genders.dart';

import '../../model/user_model.dart';
import '../../utils/utils.dart';
import '../user_view_model.dart';

class UpdateTagsViewModel with ChangeNotifier {
  List<String> dineChipText = [
    "Fine Dining",
    "Decent Dining",
    "Dhaba",
    "Home Delivery",
    "Take Away",
    "Home-made",
    "Cafe",
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
    "Hill, Lake",
    "Dam, Waterfall",
    "Mall",
    "Movie",
    "Park",
    "Picnic",
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

  Future<bool> onWillPop() async {
    updateonboardingState(0);
    notifyListeners();
    return true;
  }

  bool _nextLoading = false;
  bool get nextLoading => _nextLoading;

  setNextLoading(bool value) {
    _nextLoading = value;
    notifyListeners();
  }

  void submitBasicDetails(BuildContext context) async {
    setNextLoading(true);
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
              setNextLoading(false),
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
            setNextLoading(false),
            Utils.goErrorFlush(error.toString(), context),
          },
        );
  }

  // spd.SetPreferences_Body setPreferences_Body = spd.SetPreferences_Body();

  spd.Dine dineObject = spd.Dine(
    fineDining: false,
    decentDining: false,
    dhabas: false,
    homeDelivery: false,
    takeAway: false,
    homeMade: false,
    cafes: false,
  );

  spd.Outing outingObject = spd.Outing(
    hillsLakes: false,
    damsWaterfalls: false,
    malls: false,
    movie: false,
    park: false,
    picnics: false,
    clubbing: false,
    nightOut: false,
    windowShopping: false,
  );

  late spd.Preferences preferences;
  late spd.SetPreferences_Body setPreferences_Body;

  UpdateTagsViewModel() {
    preferences = spd.Preferences(dine: dineObject, outing: outingObject);
    setPreferences_Body = spd.SetPreferences_Body(preferences: preferences);
  }

  void submitPreferences(BuildContext context) async {
    final userPreference = Provider.of<UserViewModel>(context, listen: false);
    UserModel loggedInUser = await userPreference.getUser();
    String token = loggedInUser.token.toString();

    setPreferences_Body.preferences!.dine!.fineDining = dineSelectedChips[0];
    setPreferences_Body.preferences!.dine!.decentDining = dineSelectedChips[1];
    setPreferences_Body.preferences!.dine!.dhabas = dineSelectedChips[2];
    setPreferences_Body.preferences!.dine!.homeDelivery = dineSelectedChips[3];
    setPreferences_Body.preferences!.dine!.takeAway = dineSelectedChips[4];
    setPreferences_Body.preferences!.dine!.homeMade = dineSelectedChips[5];
    setPreferences_Body.preferences!.dine!.cafes = dineSelectedChips[6];

    setPreferences_Body.preferences!.outing!.hillsLakes =
        outingSelectedChips[0];
    setPreferences_Body.preferences!.outing!.damsWaterfalls =
        outingSelectedChips[1];
    setPreferences_Body.preferences!.outing!.malls = outingSelectedChips[2];
    setPreferences_Body.preferences!.outing!.movie = outingSelectedChips[3];
    setPreferences_Body.preferences!.outing!.park = outingSelectedChips[4];
    setPreferences_Body.preferences!.outing!.picnics = outingSelectedChips[5];
    setPreferences_Body.preferences!.outing!.clubbing = outingSelectedChips[6];
    setPreferences_Body.preferences!.outing!.nightOut = outingSelectedChips[7];
    setPreferences_Body.preferences!.outing!.windowShopping =
        outingSelectedChips[8];

    dynamic data = setPreferences_Body.toJson();

    _myRepo
        .setInitialPreferences(data, token)
        .then((value) => {
              if (value.status.toString() == 'Successful')
                {
                  updateonboardingState(0),
                  Utils.goFlushBar('Preferences Updated', context),
                  userPreference.saveUser(
                    UserModel(
                      user: User(
                        isNew: false,
                      ),
                    ),
                  ),
                  AutoRouter.of(context).push(HomeScreenRoute()),
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
