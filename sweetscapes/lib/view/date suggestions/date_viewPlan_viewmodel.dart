import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:sweetscapes/model/body/saveUserCreatedPlan_body.dart';
import 'package:sweetscapes/model/response/getAllPlans_response.dart';
import 'package:sweetscapes/model/response/saveUserCreatedPlan_response.dart';
import 'package:sweetscapes/model/user_model.dart';
import 'package:sweetscapes/repository/dates_repository.dart';
import 'package:sweetscapes/utils/utils.dart';
import 'package:sweetscapes/view_model/user_view_model.dart';

class DateViewPlanViewModel extends BaseViewModel {
  final _datesRepo = DatesRepository();

  late CompletedAllPlans plan;
  // late int numberOfPeople;
  // late FinalTravel selectedTravel;

  late SaveUserCreatedPlanBody saveUserCreatedPlanBody;
  late String recentUpcomingPlanId;

  DateViewPlanViewModel(SaveUserCreatedPlanBody saveUserCreatedPlanBodyProps, String recentUpcomingPlanIdProps) {
    saveUserCreatedPlanBody = saveUserCreatedPlanBodyProps;
    recentUpcomingPlanId = recentUpcomingPlanIdProps;
  }

  FinalPlanDetails finalPlanDetails = FinalPlanDetails();

  bool showIndividualPricing = true;
  bool showTotalPricing = false;

  void updateIndividualPricing() {
    showIndividualPricing = true;
    showTotalPricing = false;
    notifyListeners();
  }

  void updateTotalPricing() {
    showIndividualPricing = false;
    showTotalPricing = true;
    notifyListeners();
  }

  // SaveUserCreatedPlanBody saveUserCreatedPlanBody = SaveUserCreatedPlanBody();

  Future<FinalPlanDetails> fetchFinalPlan(BuildContext context) async {
    final userPreference = Provider.of<UserViewModel>(context, listen: false);
    UserModel loggedInUser = await userPreference.getUser();
    String token = loggedInUser.token.toString();

    print(recentUpcomingPlanId);

    if (recentUpcomingPlanId == '') {

    dynamic saveUserCreatedPlanBodyJson = saveUserCreatedPlanBody.toJson();

    await _datesRepo
        .saveUserCreatedPlan(token, saveUserCreatedPlanBodyJson)
        .then((value) => {
              if (value.status.toString() == 'Successful')
                {
                  finalPlanDetails = value.finalPlanDetails!,
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
    else {
      await _datesRepo
        .getSavedUserCreatedPlan(token, recentUpcomingPlanId)
        .then((value) => {
              if (value.status.toString() == 'Successful')
                {
                  finalPlanDetails = value.finalPlanDetails!,
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

    return finalPlanDetails;
  }
}
