import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:sweetscapes/app/routes/router.gr.dart';
import 'package:sweetscapes/data/response/api_response.dart';
import 'package:sweetscapes/model/body/componentsByTag_body.dart';
import 'package:sweetscapes/model/body/createPlan_body.dart';
import 'package:sweetscapes/model/body/saveUserCreatedPlan_body.dart';
import 'package:sweetscapes/model/response/createPlan_response.dart'
    as createPlan_response;
import 'package:sweetscapes/model/response/getAllPlans_response.dart';
import 'package:sweetscapes/model/user_model.dart';
import 'package:sweetscapes/repository/dates_repository.dart';
import 'package:sweetscapes/res/transport_directory.dart';
import 'package:sweetscapes/utils/utils.dart';
import 'package:sweetscapes/view_model/user_view_model.dart';

class DateDetailsViewModel extends BaseViewModel {
  late CompletedAllPlans plan;
  late CompletedAllPlans originalPlan;
  DateDetailsViewModel(CompletedAllPlans completePlan) {
    plan = CompletedAllPlans.copy(completePlan);
    originalPlan = CompletedAllPlans.copy(completePlan);
    notifyListeners();
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

  void resetPlan() {
    plan = CompletedAllPlans.copy(originalPlan);
    notifyListeners();
  }

  void updatePlan() {
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

  CreatePlanBody createPlanBody = CreatePlanBody();
  List<FinalComponents> finalComponents = [];
  bool showCompareTransportLoader = false;
  String selectedModeOfTransport = "";

  Map<String, bool> modesOfTransport = {
    "bus": true,
    "auto": false,
    "scooty": false,
    "bike": false,
    "mid_size": false,
    "suv": false,
  };

  Map<String, bool> modesOfTransportWithBus = {
    "bus": true,
    "auto": false,
    "scooty": false,
    "bike": false,
    "mid_size": false,
    "suv": false,
  };

  Map<String, bool> modesOfTransportWithoutBus = {
    "auto": true,
    "scooty": false,
    "bike": false,
    "mid_size": false,
    "suv": false,
  };

  double busTravelAmount = 0;
  double autoTravelAmount = 0;
  double scootyTravelAmount = 0;
  double bikeTravelAmount = 0;
  double midSizeTravelAmount = 0;
  double suvTravelAmount = 0;

  double totalTravelAmount = 0;

  void updateTransportMode(String label) {
    modesOfTransport.forEach((key, value) {
      modesOfTransport[key] = (key == label);
      if (modesOfTransport[key]!) {
        selectedModeOfTransport = TransportDirectory().getTransportLabel(key);
      }
    });

    notifyListeners();
  }

  createPlan_response.AllTravel allTravel = createPlan_response.AllTravel();
  createPlan_response.Bus busTravel = createPlan_response.Bus();
  createPlan_response.Auto autoTravel = createPlan_response.Auto();
  createPlan_response.Scooty scootyTravel = createPlan_response.Scooty();
  createPlan_response.Bike bikeTravel = createPlan_response.Bike();
  createPlan_response.MidSizeCar midSizeCarTravel =
      createPlan_response.MidSizeCar();
  createPlan_response.SUV suvTravel = createPlan_response.SUV();

  bool busIsAvailable = true;

  Future<List<createPlan_response.Route>> compareTransport(
      BuildContext context) async {
    showCompareTransportLoader = true;
    createPlanBody.planStartTime = plan.planStartTime;
    finalComponents = [];
    for (Components component in plan.components!) {
      finalComponents.add(FinalComponents(
          order: component.order,
          type: component.details!.type,
          id: component.details!.sId));
    }
    createPlanBody.finalComponents = finalComponents;

    final userPreference = Provider.of<UserViewModel>(context, listen: false);
    UserModel loggedInUser = await userPreference.getUser();
    String token = loggedInUser.token.toString();

    dynamic createPlanBodyData = createPlanBody.toJson();

    await _datesRepo
        .createPlan(token, createPlanBodyData)
        .then((value) => {
              if (value.status.toString() == 'Successful')
                {
                  showCompareTransportLoader = false,
                  allTravel = value.allTravel!,
                  autoTravel = value.allTravel!.auto!,
                  autoTravelAmount = value.allTravel!.auto!.price!,
                  scootyTravel = value.allTravel!.scooty!,
                  scootyTravelAmount = value.allTravel!.scooty!.price!,
                  bikeTravel = value.allTravel!.bike!,
                  bikeTravelAmount = value.allTravel!.bike!.price!,
                  midSizeCarTravel = value.allTravel!.midSize!,
                  midSizeTravelAmount = value.allTravel!.midSize!.price!,
                  suvTravel = value.allTravel!.suv!,
                  suvTravelAmount = value.allTravel!.suv!.price!,
                  if (value.allTravel!.bus == null)
                    {
                      busIsAvailable = false,
                      modesOfTransport = Map.from(modesOfTransportWithoutBus),
                    }
                  else
                    {
                      busIsAvailable = true,
                      modesOfTransport = Map.from(modesOfTransportWithBus),
                      busTravel = value.allTravel!.bus!,
                      busTravelAmount = value.allTravel!.bus!.price!,
                    }
                }
              else
                {
                  showCompareTransportLoader = false,
                  Utils.goErrorFlush(value.message ?? 'Try Again', context),
                },
            })
        .onError(
          (error, stackTrace) => {
            Utils.goErrorFlush(error.toString(), context),
          },
        );

    showCompareTransportLoader = false;
    notifyListeners();
    if (busIsAvailable) {
      totalTravelAmount = updateBusTravelAmount(busTravel.route!);
      selectedModeOfTransport = "Bus";
      return busTravel.route!;
    } else {
      totalTravelAmount = autoTravelAmount;
      selectedModeOfTransport = "Auto";
      return autoTravel.route!;
    }
  }

  double updateBusTravelAmount(List<createPlan_response.Route> route) {
    double newBusPrice = 0;
    for (createPlan_response.Route routeComponent in route) {
      if (routeComponent.mode == 'bus') {
        newBusPrice = newBusPrice + (2 * routeComponent.price!.toDouble());
      } else if (routeComponent.mode == 'auto') {
        newBusPrice = newBusPrice + routeComponent.price!;
      }
    }
    return newBusPrice;
  }

  SaveUserCreatedPlanBody saveUserCreatedPlanBody = SaveUserCreatedPlanBody();

  Future<void> gotoViewPlan(BuildContext context, int peopleCount) async {
    saveUserCreatedPlanBody.peopleCount = peopleCount;
    saveUserCreatedPlanBody.tileContent = plan.tileContent;

    List<FinalComponentsforViewPlan> finalComponentsforViewPlan = [];
    for (Components component in plan.components!) {
      finalComponentsforViewPlan.add(FinalComponentsforViewPlan(
          order: component.order,
          type: component.details!.type,
          componentId: component.details!.sId,
          isHighlight: component.isHighlight));
    }
    saveUserCreatedPlanBody.finalComponents = finalComponentsforViewPlan;

    FinalTravel finalTravelForViewPlan = FinalTravel();

    if (selectedModeOfTransport == "Bus") {
      finalTravelForViewPlan.distance = busTravel.distance;
      finalTravelForViewPlan.duration = busTravel.duration;
      finalTravelForViewPlan.price = busTravel.price;
      finalTravelForViewPlan.route = busTravel.route;
    } else if (selectedModeOfTransport == "Auto") {
      finalTravelForViewPlan.distance = autoTravel.distance;
      finalTravelForViewPlan.duration = autoTravel.duration;
      finalTravelForViewPlan.price = autoTravel.price;
      finalTravelForViewPlan.route = autoTravel.route;
    } else if (selectedModeOfTransport == "Scooty") {
      finalTravelForViewPlan.distance = scootyTravel.distance;
      finalTravelForViewPlan.duration = scootyTravel.duration;
      finalTravelForViewPlan.price = scootyTravel.price;
      finalTravelForViewPlan.route = scootyTravel.route;
    } else if (selectedModeOfTransport == "Bike") {
      finalTravelForViewPlan.distance = bikeTravel.distance;
      finalTravelForViewPlan.duration = bikeTravel.duration;
      finalTravelForViewPlan.price = bikeTravel.price;
      finalTravelForViewPlan.route = bikeTravel.route;
    } else if (selectedModeOfTransport == "Mid-Size Car") {
      finalTravelForViewPlan.distance = midSizeCarTravel.distance;
      finalTravelForViewPlan.duration = midSizeCarTravel.duration;
      finalTravelForViewPlan.price = midSizeCarTravel.price;
      finalTravelForViewPlan.route = midSizeCarTravel.route;
    } else {
      finalTravelForViewPlan.distance = suvTravel.distance;
      finalTravelForViewPlan.duration = suvTravel.duration;
      finalTravelForViewPlan.price = suvTravel.price;
      finalTravelForViewPlan.route = suvTravel.route;
    }

    saveUserCreatedPlanBody.finalTravel = finalTravelForViewPlan;

    AutoRouter.of(context).push(DateViewPlanViewRoute(
        saveUserCreatedPlanBody: saveUserCreatedPlanBody));

    // await _datesRepo
    //     .saveUserCreatedPlan(token, saveUserCreatedPlanBodyJson)
    //     .then((value) => {
    //           if (value.status.toString() == 'Successful')
    //             {
    //               print('Here'),
    //               finalPlanDetails = value.finalPlanDetails!,
    //             }
    //           else
    //             {
    //               Utils.goErrorFlush('Try Again', context),
    //             },
    //         })
    //     .onError(
    //       (error, stackTrace) => {
    //         Utils.goErrorFlush(error.toString(), context),
    //       },
    //     );

    // notifyListeners();
  }
}
