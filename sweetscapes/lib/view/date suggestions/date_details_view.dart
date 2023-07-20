import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sweetscapes/view/date%20suggestions/date_details_viewmodel.dart';

import '../../model/date_model.dart' as dateModel;

@RoutePage()
class DateDetailsView extends StatelessWidget {
  const DateDetailsView(this.dateId);

  final String dateId;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => DateDetailsViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: FutureBuilder(
            future: model.fetchDateDetails(context, dateId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                dateModel.Date date = snapshot.data!;
                return Center(
                  child: Text(date.detailedContent??'Detailed Content'),
                );
              }
              return const Text('Show Date Details');
            },
          ),
        ),
      ),
    );
  }
}
