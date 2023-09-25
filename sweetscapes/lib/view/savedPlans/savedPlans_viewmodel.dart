import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:sweetscapes/model/response/getRecentPlans_response.dart';
import 'package:sweetscapes/model/response/getUpcomingPlans_response.dart';
import 'package:sweetscapes/model/user_model.dart';
import 'package:sweetscapes/repository/dates_repository.dart';
import 'package:sweetscapes/utils/utils.dart';
import 'package:sweetscapes/view_model/user_view_model.dart';

class SavedPlansViewModel extends BaseViewModel {
  final _datesRepo = DatesRepository();

  List<UserRecentPlans> recentPlans = [];
  List<UserRecentPlans> savedPlans = [];
  List<UserUpcomingPlans> upcomingPlans = [];

  void refreshRecentPlans(List<UserRecentPlans> newPlans) {
    recentPlans = List<UserRecentPlans>.from(newPlans);
    notifyListeners();
  }

  void refreshUpcomingPlans(List<UserUpcomingPlans> newPlans) {
    upcomingPlans = List<UserUpcomingPlans>.from(newPlans);
    notifyListeners();
  }

  Future<List<UserRecentPlans>> fetchRecentPlans(BuildContext context) async {
    final userPreference = Provider.of<UserViewModel>(context, listen: false);
    UserModel loggedInUser = await userPreference.getUser();
    String token = loggedInUser.token.toString();

    await _datesRepo
        .getRecentPlans(token)
        .then((value) => {
              if (value.status.toString() == 'Successful')
                {
                  recentPlans = value.userRecentPlans!,
                }
              else
                {
                  recentPlans = [],
                },
            })
        .onError(
          (error, stackTrace) => {
            Utils.goToast('No Plans Here')
          },
        );

    notifyListeners();
    return recentPlans;
  }

  Future<List<UserUpcomingPlans>> fetchUpcomingPlans(
      BuildContext context) async {
    final userPreference = Provider.of<UserViewModel>(context, listen: false);
    UserModel loggedInUser = await userPreference.getUser();
    String token = loggedInUser.token.toString();

    await _datesRepo
        .getUpcomingPlans(token)
        .then((value) => {
              if (value.status.toString() == 'Successful')
                {
                  upcomingPlans = value.userUpcomingPlans!,
                }
              else
                {
                  upcomingPlans = [],
                },
            })
        .onError(
          (error, stackTrace) => {
            Utils.goErrorFlush(error.toString(), context),
          },
        );

    notifyListeners();
    return upcomingPlans;
  }
}
