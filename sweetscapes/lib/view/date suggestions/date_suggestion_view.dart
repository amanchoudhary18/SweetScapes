import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sweetscapes/app/routes/router.gr.dart';
import 'package:sweetscapes/model/response/getDates_response.dart';
import 'package:sweetscapes/res/enums/DateType.dart';
import 'package:sweetscapes/res/functions/TextFieldDecoration.dart';
import 'package:sweetscapes/view/date suggestions/date_suggestion_viewmodel.dart';

import '../../res/components/SuggestionTile.dart';
import '../../utils/utils.dart';

@RoutePage()
class DateSuggestionView extends StatelessWidget {
  DateSuggestionView({
    super.key,
  });

  final TextEditingController _dateController = TextEditingController();
  final FocusNode _dateNode = FocusNode();
  final TextEditingController _locationController = TextEditingController();
  final FocusNode _locationNode = FocusNode();
  final TextEditingController _peopleCountController = TextEditingController();
  final FocusNode _peopleCountNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ViewModelBuilder.reactive(
      viewModelBuilder: () => DateSuggestionViewModel(),
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFFDFBF0),
        extendBody: true,
        body: SafeArea(
          child: Container(
            width: screenWidth,
            height: screenHeight,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: Container(
                  //     width: screenWidth * 0.2,
                  //     child: Image.asset(
                  //       'assets/images/logoPurple.png',
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: Container(
                      decoration: TextFieldDecoration.textFieldDecoration(),
                      width: screenWidth,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextFormField(
                          controller: _locationController,
                          keyboardType: TextInputType.streetAddress,
                          focusNode: _locationNode,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.location_on_outlined,
                              size: 30,
                              color: Colors.grey,
                            ),
                            hintText: 'Location',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            border: InputBorder.none,
                          ),
                          onFieldSubmitted: (value) => Utils.fieldFocusChange(
                            context,
                            _locationNode,
                            _dateNode,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration:
                                TextFieldDecoration.textFieldDecoration(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextFormField(
                                controller: _dateController,
                                keyboardType: TextInputType.none,
                                focusNode: _dateNode,
                                decoration: const InputDecoration(
                                  icon: Icon(
                                    Icons.calendar_today_outlined,
                                    size: 25,
                                    color: Colors.grey,
                                  ),
                                  hintText: 'Date',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: InputBorder.none,
                                ),
                                onFieldSubmitted: (value) =>
                                    Utils.fieldFocusChange(
                                  context,
                                  _dateNode,
                                  _peopleCountNode,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.03,
                        ),
                        Expanded(
                          child: Container(
                            decoration:
                                TextFieldDecoration.textFieldDecoration(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextFormField(
                                  controller: _peopleCountController,
                                  keyboardType: TextInputType.none,
                                  focusNode: _peopleCountNode,
                                  decoration: const InputDecoration(
                                    icon: Icon(
                                      Icons.people_alt_outlined,
                                      size: 25,
                                      color: Colors.grey,
                                    ),
                                    hintText: 'People',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  onFieldSubmitted: (value) => {}),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Container(
                    height: screenHeight * 0.597,
                    width: screenWidth,
                    child: FutureBuilder(
                      future: model.fetchDates(context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasData) {
                          List<Date> dates = snapshot.data!;
                          return CupertinoScrollbar(
                            child: ListView.builder(
                              itemCount: dates.length,
                              itemBuilder: (context, index) => SuggestionTile(
                                dateType: (dates[index].category! == "Outing")
                                    ? DateType.OUTING
                                    : DateType.DINEOUT,
                                dateOverviewText: dates[index].tileContent!,
                                datePrice:
                                    dates[index].pricePerHead!.toDouble(),
                                onPressed: () {
                                  AutoRouter.of(context).push(
                                    DateDetailsViewRoute(dateId: dates[index].sId!.toString())
                                  );
                                },
                              ),
                            ),
                          );
                        }
                        return const Text('Show Suggestions');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}