import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sweetscapes/model/response/getAllPlans_response.dart';

class DateDetailsViewModel extends BaseViewModel {
  List<Components> planComponents = [];
  List<Images> planImages = [];

  Future<void> initializePlanDetails(BuildContext context,
      List<Components> componentList, List<Images> imageList) async {
    planComponents = componentList;
    planImages = imageList;
  }
}
