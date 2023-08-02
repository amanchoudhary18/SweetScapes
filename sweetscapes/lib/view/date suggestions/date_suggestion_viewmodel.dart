import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:sweetscapes/model/response/getAllPlans_response.dart';
import 'package:sweetscapes/model/user_model.dart';
import 'package:sweetscapes/repository/dates_repository.dart';
import 'package:sweetscapes/utils/utils.dart';
import 'package:sweetscapes/view_model/user_view_model.dart';

class DateSuggestionViewModel extends BaseViewModel {
  final _datesRepo = DatesRepository();

  List<CompletedAllPlans> plans = [];

  DateTime _planDate = DateTime.now();
  DateTime get planDate => _planDate;

  bool _datesLoading = false;
  bool get nextLoading => _datesLoading;

  updatePlanDate(DateTime value) {
    _planDate = value;
    notifyListeners();
  }

  setDatesLoading(bool value) {
    _datesLoading = value;
    notifyListeners();
  }

  List<CompletedAllPlans> errorDate = [
    CompletedAllPlans(tileContent: 'ERROR', price: 404)
  ];

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

  Map<String, bool> allTags = {
    'Fine Dining': false,
    'Decent Dining': false,
    'Dhaba': false,
    'Cafe': false,
    'Street Food': false,
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

  void updateOutingTags(String label) {
    outingTags[label] = !outingTags[label]!;
    notifyListeners();
  }

  void filterPlans(List<String> filterTags) async {
    if (filterTags.isEmpty) {
      resetPlansOrder();
    } else {
      Map<CompletedAllPlans, double> likenessMap = {};

      for (CompletedAllPlans plan in plans) {
        double likeness = plan.likeness!;
        int match = 0;

        for (String tag in filterTags) {
          List<String> filterWords = tag.toLowerCase().split(' ');

          if (filterWords.every((word) => plan.tags!
              .any((planTag) => planTag.toLowerCase().contains(word)))) {
            match++;
          }
        }

        likeness += match;
        likenessMap[plan] = likeness;
      }

      plans.sort((a, b) => likenessMap[b]!.compareTo(likenessMap[a]!));
      notifyListeners();
    }
  }

  void resetPlansOrder() {
    plans.sort((a, b) => b.likeness!.compareTo(a.likeness as num));
    notifyListeners();
  }

  Future<List<CompletedAllPlans>> fetchPlans(BuildContext context) async {
    final userPreference = Provider.of<UserViewModel>(context, listen: false);
    UserModel loggedInUser = await userPreference.getUser();
    String token = loggedInUser.token.toString();

    plans = errorDate;

    await _datesRepo
        .getAllPlans(token)
        .then((value) => {
              if (value.status.toString() == 'Successful')
                {
                  plans = value.completedAllPlans!,
                }
              else
                {
                  plans = errorDate,
                },
            })
        .onError(
          (error, stackTrace) => {
            Utils.goErrorFlush(error.toString(), context),
          },
        );

    notifyListeners();
    return plans;
  }
}
