import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:sweetscapes/model/response/getDates_response.dart';
import 'package:sweetscapes/model/user_model.dart';
import 'package:sweetscapes/repository/dates_repository.dart';
import 'package:sweetscapes/view_model/user_view_model.dart';

class DateSuggestionViewModel extends BaseViewModel {
  final _datesRepo = DatesRepository();

  bool _datesLoading = false;
  bool get nextLoading => _datesLoading;

  setDatesLoading(bool value) {
    _datesLoading = value;
    notifyListeners();
  }

  List<Date> errorDate = [
    Date(
      tileContent: 'ERROR',
      pricePerHead: 404
    )
  ];

  Future<List<Date>> fetchDates(BuildContext context) async {
    // setDatesLoading(true);

    final userPreference = Provider.of<UserViewModel>(context, listen: false);
    UserModel loggedInUser = await userPreference.getUser();
    String token = loggedInUser.token.toString();

    List<Date> _dates = [];

    await _datesRepo
        .getAllDates(token)
        .then((value) => {
              // setDatesLoading(false),
              if (value.status.toString() == 'Successful')
                {
                  // Utils.goFlushBar('Success', context),
                  _dates = value.date!,
                  print(value.date),
                  print(value.date![0].tileContent!),
                }
              else
                {
                  _dates = errorDate,
                  // Utils.goFlushBar('Please restart app', context),
                },
            })
        .onError(
          (error, stackTrace) => {
            // setDatesLoading(false),
            // Utils.goErrorFlush(error.toString(), context),
          },
        );

    return _dates;
  }
}
