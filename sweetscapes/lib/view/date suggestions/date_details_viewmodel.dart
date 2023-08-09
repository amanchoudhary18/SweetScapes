import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:sweetscapes/data/response/api_response.dart';
import 'package:sweetscapes/model/body/componentsByTag_body.dart';
import 'package:sweetscapes/model/response/getAllPlans_response.dart';
import 'package:sweetscapes/model/user_model.dart';
import 'package:sweetscapes/repository/dates_repository.dart';
import 'package:sweetscapes/utils/utils.dart';
import 'package:sweetscapes/view_model/user_view_model.dart';

class DateDetailsViewModel extends BaseViewModel {
  late CompletedAllPlans plan;
  DateDetailsViewModel(CompletedAllPlans completePlan) {
    plan = completePlan;
  }

  final _datesRepo = DatesRepository();
  ApiResponse<UserModel> userData = ApiResponse.loading();

  int planPrice = 0;
  // List<Components> planComponents = [];
  List<Components> editPlanComponents = [];
  List<Components> componentsByTag = [];
  List<Images> planImages = [];

  Future<void> initializePlanDetails() async {
    // planComponents = List<Components>.from(componentList);
    editPlanComponents = List<Components>.from(plan.components!);
    // editPlanComponents = componentList;
  }

  void updatePlan() {
    print('Here');
    plan.price = 0;
    // int index = 0;
    for (Components component in editPlanComponents) {
      plan.price = plan.price! + component.details!.pricePerHead!;
      // plan.images![index].imgLink = component.details!.img!;
      // plan.images![index].imgName = (component.details!.type == 'Dining') ? component.details!.hotelName! : component.details!.placeName!;
    }
    plan.components = List<Components>.from(editPlanComponents);
    notifyListeners();
  }

  ComponentsByTagBody componentsByTagBody = ComponentsByTagBody();

  Future<List<Components>> getComponentsByTag(
      String type, String tag, BuildContext context) async {
    componentsByTagBody.type = type;
    componentsByTagBody.tag = tag;

    final userPreference = Provider.of<UserViewModel>(context, listen: false);
    UserModel loggedInUser = await userPreference.getUser();
    String token = loggedInUser.token.toString();

    dynamic componentsByTagBodyData = componentsByTagBody.toJson();

    await _datesRepo
        .getComponentsByTag(token, componentsByTagBodyData)
        .then((value) => {
              if (value.status.toString() == 'Successful')
                {
                  componentsByTag = value.components!,
                }
              else
                {
                  componentsByTag = [],
                  Utils.goErrorFlush('Try Again', context),
                },
            })
        .onError(
          (error, stackTrace) => {
            // Utils.goErrorFlush(error.toString(), context),
          },
        );

    return componentsByTag;
  }
}
