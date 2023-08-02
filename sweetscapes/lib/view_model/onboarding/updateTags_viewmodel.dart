import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetscapes/app/routes/router.gr.dart';
import 'package:sweetscapes/model/body/set_preferences_body.dart' as spd;
import 'package:sweetscapes/repository/user_repository.dart';

import '../../model/user_model.dart';
import '../../utils/utils.dart';
import '../user_view_model.dart';

class UpdateTagsViewModel with ChangeNotifier {
  Map<String, bool> diningTags = {
    'Fine Dining': false,
    'Decent Dining': false,
    'Dhaba': false,
    'Cafe': false,
    'Street Food': false,
  };

  Map<String, String> diningIcons = {
    'Fine Dining': 'assets/tagIcons/icons=fineDining.svg',
    'Decent Dining': 'assets/tagIcons/icons=decentDining.svg',
    'Dhaba': 'assets/tagIcons/icons=dhabas.svg',
    'Cafe': 'assets/tagIcons/icons=cafes.svg',
    'Street Food': 'assets/tagIcons/icons=streetfood.svg',
  };

  void updateDiningTags(String label) {
    diningTags[label] = !diningTags[label]!;
    notifyListeners();
  }

  Map<String, bool> outingTags = {
    'Hills': false,
    'Lakes': false,
    'Dams Waterfalls': false,
    'Malls': false,
    'Movie': false,
    'Parks': false,
    // 'Picnics': false,
    'Clubbing': false,
    'Night Out': false,
    'Shopping': false,
    'Places of Worship': false,
    'Museum': false,
  };

  Map<String, String> outingIcons = {
    'Hills': 'assets/tagIcons/icons=hills.svg',
    'Lakes': 'assets/tagIcons/icons=Lakes.svg',
    'Dams Waterfalls': 'assets/tagIcons/icons=Dams_Waterfall.svg',
    'Malls': 'assets/tagIcons/icons=malls.svg',
    'Movie': 'assets/tagIcons/icons=movie.svg',
    'Parks': 'assets/tagIcons/icons=park.svg',
    // 'Picnics': 'assets/tagIcons/icons=picnic.svg',
    'Clubbing': 'assets/tagIcons/icons=clubs.svg',
    'Night Out': 'assets/tagIcons/icons=Night out.svg',
    'Shopping': 'assets/tagIcons/icons=shopping.svg',
    'Places of Worship': 'assets/tagIcons/icons=religious.svg',
    'Museum': 'assets/tagIcons/icons=Museum.svg',
  };

  void updateOutingTags(String label) {
    outingTags[label] = !outingTags[label]!;
    notifyListeners();
  }

  final _myRepo = UserRepository();
  int _onboardingState = 0;
  DateTime _userBirthDay = DateTime(2000, 1, 1);
  String _userGender = "";

  DateTime get userBirthDay => _userBirthDay;

  int get onboardingState => _onboardingState;

  String get userGender => _userGender;

  void updateBirthday(DateTime value) {
    _userBirthDay = value;
    notifyListeners();
  }

  void updateGender(String value) {
    _userGender = value;
    notifyListeners();
  }

  bool _nextLoading = false;
  bool get nextLoading => _nextLoading;

  setNextLoading(bool value) {
    _nextLoading = value;
    notifyListeners();
  }

  void submitBasicDetails(String userName, BuildContext context) async {
    setNextLoading(true);
    final userPreference = Provider.of<UserViewModel>(context, listen: false);
    UserModel loggedInUser = await userPreference.getUser();
    String token = loggedInUser.token.toString();

    String userBday = _userBirthDay.millisecondsSinceEpoch.toString();
    String userGen = _userGender;

    Map data = {'name': userName, 'birthday': userBday, 'gender': userGen};

    _myRepo
        .updateUserDetailsUrl(data, token)
        .then((value) => {
              setNextLoading(false),
              if (value.status.toString() == 'Successful')
                {
                  Utils.goFlushBar('Birthday and Gender Updated', context),
                  AutoRouter.of(context).push(UpdateTagsViewRoute()),
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
    cafes: false,
    streetfood: false,
  );

  spd.Outing outingObject = spd.Outing(
    hills: false,
    lakes: false,
    damsWaterfalls: false,
    malls: false,
    movieHalls: false,
    parks: false,
    // picnics: false,
    clubbing: false,
    nightOut: false,
    shopping: false,
    placesOfWorship: false,
    museum: false,
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

    setPreferences_Body.preferences!.dine!.fineDining =
        diningTags['Fine Dining'];
    setPreferences_Body.preferences!.dine!.decentDining =
        diningTags['Decent Dining'];
    setPreferences_Body.preferences!.dine!.dhabas = diningTags['Dhaba'];
    setPreferences_Body.preferences!.dine!.cafes = diningTags['Cafe'];
    setPreferences_Body.preferences!.dine!.streetfood =
        diningTags['Street Food'];

    setPreferences_Body.preferences!.outing!.hills = outingTags['Hills'];
    setPreferences_Body.preferences!.outing!.lakes = outingTags['Lakes'];
    setPreferences_Body.preferences!.outing!.damsWaterfalls =
        outingTags['Dams, Waterfalls'];
    setPreferences_Body.preferences!.outing!.malls = outingTags['Malls'];
    setPreferences_Body.preferences!.outing!.movieHalls = outingTags['Movie'];
    setPreferences_Body.preferences!.outing!.parks = outingTags['Parks'];
    setPreferences_Body.preferences!.outing!.clubbing = outingTags['Clubbing'];
    setPreferences_Body.preferences!.outing!.nightOut = outingTags['Night Out'];
    setPreferences_Body.preferences!.outing!.shopping = outingTags['Shopping'];
    setPreferences_Body.preferences!.outing!.placesOfWorship =
        outingTags['Places of Worship'];
    setPreferences_Body.preferences!.outing!.museum = outingTags['Museum'];

    dynamic data = setPreferences_Body.toJson();

    _myRepo
        .setInitialPreferences(data, token)
        .then((value) => {
              if (value.status.toString() == 'Successful')
                {
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
