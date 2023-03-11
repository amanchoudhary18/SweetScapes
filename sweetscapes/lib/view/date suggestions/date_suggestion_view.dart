import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:sweetscapes/model/user_model.dart';
import 'package:sweetscapes/res/components/round_button.dart';
import 'package:sweetscapes/res/enums/DateType.dart';
import 'package:sweetscapes/res/enums/Genders.dart';
import 'package:sweetscapes/res/functions/TextFieldDecoration.dart';
import 'package:sweetscapes/utils/routes/routes_name.dart';
import 'package:sweetscapes/view_model/date_suggestion/date_suggestion_viewmodel.dart';
import 'package:sweetscapes/view_model/home_screen_view_model.dart';
import 'package:intl/intl.dart';
import 'package:sweetscapes/view_model/user_view_model.dart';

import '../../res/components/SuggestionTile.dart';
import '../../utils/utils.dart';

class DateSuggestionView extends StatelessWidget {
  DateSuggestionView({
    super.key,
    required this.showInitialDialog,
  });

  bool showInitialDialog;

  final TextEditingController _ageInputController = TextEditingController();
  final FocusNode _ageInputNode = FocusNode();
  final TextEditingController _dateController = TextEditingController();
  final FocusNode _dateNode = FocusNode();
  final TextEditingController _locationController = TextEditingController();
  final FocusNode _locationNode = FocusNode();
  final TextEditingController _peopleCountController = TextEditingController();
  final FocusNode _peopleCountNode = FocusNode();

  final List<PopupMenuItem> genderOptions = [
    const PopupMenuItem(
      value: Genders.MALE,
      child: Text('Male'),
    ),
    const PopupMenuItem(
      value: Genders.FEMALE,
      child: Text('Female'),
    ),
    const PopupMenuItem(
      value: Genders.OTHERS,
      child: Text('Others'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final model = Provider.of<DateSuggestionViewModel>(context);

    if (model.showDialogHere) {
      model.showDialogHere = showInitialDialog;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFFDFBF0),
      extendBody: true,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: screenWidth,
            height: screenHeight,
            child: Image.asset(
              'assets/images/baloonBG.png',
              fit: BoxFit.cover,
              color: Color.fromRGBO(255, 255, 255, 0.5),
              colorBlendMode: BlendMode.modulate,
            ),
          ),
          Visibility(
            visible: model.showDialogHere,
            child: SafeArea(
              child: Container(
                width: screenWidth * 0.6,
                height: screenHeight,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'Enter basic Details',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Divider(
                          thickness: 5,
                        ),
                        ListTile(
                          title: Text(
                            'BIRTHDAY',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          subtitle: Text(
                            '${DateFormat('dd / MM / yyyy').format(model.userBirthDay)}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          leading: Icon(Icons.cake_outlined),
                          trailing: Icon(Icons.calendar_month_outlined),
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: model.userBirthDay,
                              firstDate: DateTime(1999),
                              lastDate: DateTime(DateTime.now().year),
                            ).then(
                              (value) => model
                                  .updateBirthday(value ?? model.userBirthDay),
                            );
                          },
                        ),
                        const Divider(
                          thickness: 5,
                        ),
                        ListTile(
                          leading: Icon(Icons.man_4_outlined),
                          title: Text(
                            'GENDER',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          subtitle: Text(
                            (model.userGender == Genders.MALE)
                                ? 'Male'
                                : (model.userGender == Genders.FEMALE)
                                    ? 'Female'
                                    : 'Others',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          trailing: PopupMenuButton(
                            itemBuilder: (context) => genderOptions,
                            onSelected: (value) => model.updateGender(value),
                          ),
                        ),
                        const Divider(
                          thickness: 5,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('SUBMIT'),
                          onPressed: () {
                            model.submitBasicDetails(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: !model.showDialogHere,
            child: SafeArea(
              child: SuggestionsWidget(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  locationController: _locationController,
                  locationNode: _locationNode,
                  dateNode: _dateNode,
                  dateController: _dateController,
                  peopleCountNode: _peopleCountNode,
                  peopleCountController: _peopleCountController),
            ),
          )
        ],
      ),
    );
  }
}

class SuggestionsWidget extends StatelessWidget {
  const SuggestionsWidget({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required TextEditingController locationController,
    required FocusNode locationNode,
    required FocusNode dateNode,
    required TextEditingController dateController,
    required FocusNode peopleCountNode,
    required TextEditingController peopleCountController,
  })  : _locationController = locationController,
        _locationNode = locationNode,
        _dateNode = dateNode,
        _dateController = dateController,
        _peopleCountNode = peopleCountNode,
        _peopleCountController = peopleCountController;

  final double screenHeight;
  final double screenWidth;

  final TextEditingController _dateController;
  final FocusNode _dateNode;
  final TextEditingController _locationController;
  final FocusNode _locationNode;
  final TextEditingController _peopleCountController;
  final FocusNode _peopleCountNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: screenWidth * 0.2,
              child: Image.asset(
                'assets/images/logoPurple.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
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
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: TextFieldDecoration.textFieldDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                        onFieldSubmitted: (value) => Utils.fieldFocusChange(
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
                    decoration: TextFieldDecoration.textFieldDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
            child: CupertinoScrollbar(
              child: ListView(
                children: [
                  SuggestionTile(
                    dateType: DateType.DINEOUT,
                    dateOverviewText:
                        'Ola cab > Lunch > Standup show > Evening at park > returning ola cab',
                    datePrice: 1050,
                    onPressed: () {},
                  ),
                  SuggestionTile(
                    dateType: DateType.OUTING,
                    dateOverviewText:
                        'Ola cab > Lunch> Standup show> Evening at park>returning ola cab',
                    datePrice: 1600,
                    onPressed: () {},
                  ),
                  SuggestionTile(
                    dateType: DateType.WORKSHOP,
                    dateOverviewText:
                        'Ola cab > Lunch> Standup show> Evening at park>returning ola cab',
                    datePrice: 870,
                    onPressed: () {},
                  ),
                  SuggestionTile(
                    dateType: DateType.OUTING,
                    dateOverviewText:
                        'Ola cab > Lunch> Standup show> Evening at park>returning ola cab',
                    datePrice: 2200,
                    onPressed: () {},
                  ),
                  SuggestionTile(
                    dateType: DateType.DINEOUT,
                    dateOverviewText:
                        'Ola cab > Lunch > Standup show > Evening at park > returning ola cab',
                    datePrice: 1480,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
