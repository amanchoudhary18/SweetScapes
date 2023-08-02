import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:sweetscapes/model/response/getAllPlans_response.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/components/AppText.dart';
import 'package:sweetscapes/res/enums/Fonts.dart';
import 'package:sweetscapes/res/fonts.dart';
import 'package:sweetscapes/view/date suggestions/date_suggestion_viewmodel.dart';
import 'package:sweetscapes/view/date%20suggestions/bottomsheet_tags.dart';

import '../../res/components/SuggestionTile.dart';

@RoutePage()
class DateSuggestionView extends StatelessWidget {
  DateSuggestionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final TextEditingController _planDateController = TextEditingController();
    final FocusNode _planDateNode = FocusNode();

    return ViewModelBuilder.reactive(
      viewModelBuilder: () => DateSuggestionViewModel(),
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: SafeArea(
          child: Container(
            width: screenWidth,
            height: screenHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: AppText(
                      text: 'Lets Escape!',
                      size: 28,
                      font: Fonts.TITLE,
                      weight: FontWeight.w700,
                      color: AppColor.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8),
                        child: TextFormField(
                          controller: _planDateController,
                          cursorHeight: 0,
                          cursorWidth: 0,
                          focusNode: _planDateNode,
                          onTap: () {
                            showDatePicker(
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: AppColor
                                          .primary, // header background color
                                      onPrimary:
                                          AppColor.white, // header text color
                                      onSurface:
                                          AppColor.black, // body text color
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        foregroundColor: AppColor
                                            .primary, // button text color
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                              context: context,
                              initialDate: model.planDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year + 1),
                            ).then(
                              (value) => {
                                model.updatePlanDate(value ?? model.planDate),
                                _planDateController.text =
                                    DateFormat('EEE, MMM d')
                                        .format(value ?? model.planDate),
                              },
                            );
                            _planDateNode.unfocus();
                          },
                          keyboardType: TextInputType.none,
                          decoration: const InputDecoration(
                            hintText: 'When are you going?',
                            suffixIcon: Icon(
                              Icons.calendar_month_outlined,
                              color: AppColor.black,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: 'Suggestions For You',
                            size: 18,
                            font: Fonts.TITLE,
                            weight: FontWeight.w700,
                            color: AppColor.black,
                          ),
                          Text(
                            '${model.plans.length} exciting plans waiting to happen',
                            style: TextStyle(
                              height: 1.14,
                              fontSize: 14,
                              fontFamily: AppFonts.subtitle,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade600,
                              letterSpacing: 0.21,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.secondary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) =>
                                    BottomSheetTags(model.allTags),
                              ).then(
                                (value) => {
                                 model.filterPlans(value??[]),
                                },
                              );
                              ;
                            },
                            child: Icon(Icons.filter_alt_outlined),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: screenWidth,
                      // color: AppColor.secondary,
                      child: (model.plans.isEmpty)
                          ? FutureBuilder(
                              future: model.fetchPlans(context),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasData) {
                                  List<CompletedAllPlans> plans =
                                      snapshot.data!;
                                  return CupertinoScrollbar(
                                    child: ListView.builder(
                                      itemCount: plans.length,
                                      itemBuilder: (context, index) =>
                                          SuggestionTile(
                                        plan: plans[index],
                                      ),
                                    ),
                                  );
                                }
                                return const Text('Not able to fetch plans');
                              },
                            )
                          : CupertinoScrollbar(
                              child: ListView.builder(
                                itemCount: model.plans.length,
                                itemBuilder: (context, index) => SuggestionTile(
                                  plan: model.plans[index],
                                ),
                              ),
                            ),
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
