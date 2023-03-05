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
import 'package:sweetscapes/res/functions/TextFieldDecoration.dart';
import 'package:sweetscapes/utils/routes/routes_name.dart';
import 'package:sweetscapes/view_model/home_screen_view_model.dart';
import 'package:sweetscapes/view_model/user_view_model.dart';

import '../../res/components/SuggestionTile.dart';
import '../../utils/utils.dart';

class DateSuggestionView extends StatelessWidget {
  DateSuggestionView({
    super.key,
  });

  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _peopleCountController = TextEditingController();

  final FocusNode _locationNode = FocusNode();
  final FocusNode _dateNode = FocusNode();
  final FocusNode _peopleCountNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
          SafeArea(
            child: Container(
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
                        vertical: 8.0, horizontal: 16),
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
            ),
          )
        ],
      ),
    );
  }
}
