import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:sweetscapes/model/user_model.dart';
import 'package:sweetscapes/repository/dates_repository.dart';
import 'package:sweetscapes/view_model/user_view_model.dart';

import '../../model/date_model.dart';

class DateDetailsViewModel extends BaseViewModel {
  final _datesRepo = DatesRepository();

  Future<Date> fetchDateDetails(BuildContext context, String id) async {
    final userPreference = Provider.of<UserViewModel>(context, listen: false);
    UserModel loggedInUser = await userPreference.getUser();
    String token = loggedInUser.token.toString();

    Date date = Date();

    await _datesRepo
        .getDateDetails(id, token)
        .then((value) => {
              if (value.status.toString() == 'Successful')
                {
                  date = value.date!,
                }
              else
                {
                  // Utils.goFlushBar('Please restart app', context),
                },
            })
        .onError(
          (error, stackTrace) => {
            // Utils.goErrorFlush(error.toString(), context),
          },
        );

    return date;
  }
}
