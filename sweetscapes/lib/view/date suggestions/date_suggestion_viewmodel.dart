import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:sweetscapes/res/components/SuggestionTile.dart';

import '../../res/enums/DateType.dart';
import '../../view_model/user_view_model.dart';

class DateSuggestionViewModel extends BaseViewModel {
  List<SuggestionTile> dateList = [
    SuggestionTile(
      dateType: DateType.DINEOUT,
      dateOverviewText:
          'Ola cab > Lunch > Standup show > Evening at park > returning ola cab',
      datePrice: 1050,
      onPressed: () {},
    ),
  ];

  Future<void> fetchDates(BuildContext context) async {
    final userPreference = Provider.of<UserViewModel>(context, listen: false);

    // _myrepo
    //     .verifyOTPUrl(otpData)
    //     .then((value) => {
    //           setverifyOtpLoading(false),
    //           if (value.status.toString() == 'Successful')
    //             {
    //               userPreference.saveUser(
    //                 UserModel(
    //                   token: value.token.toString(),
    //                   user: User(
    //                     isNew: false,
    //                   ),
    //                 ),
    //               ),
    //               userData = ApiResponse.completed(value),
    //               Utils.goFlushBar('SignUp Successful', context),
    //               Navigator.pushNamed(context, RoutesName.setPassword),
    //             }
    //           else
    //             {
    //               Utils.goErrorFlush('Try Again', context),
    //             },
    //         })
    //     .onError(
    //       (error, stackTrace) => {
    //         setverifyOtpLoading(false),
    //         userData = ApiResponse.error(error.toString()),
    //         Utils.goErrorFlush(error.toString(), context),
    //       },
    //     );
  }

}
