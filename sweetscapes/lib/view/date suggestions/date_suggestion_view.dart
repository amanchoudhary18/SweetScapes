import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:sweetscapes/model/response/getAllPlans_response.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/components/AppText.dart';
import 'package:sweetscapes/res/components/noPlansPlaceHolder.dart';
import 'package:sweetscapes/res/enums/Fonts.dart';
import 'package:sweetscapes/res/fonts.dart';
import 'package:sweetscapes/res/tags_directory.dart';
import 'package:sweetscapes/utils/textDirectory.dart';
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

    ScrollController _scrollController = ScrollController();

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
                      text: 'Lets Escape !',
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
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(12),
                      //   border: Border.all(
                      //     color: AppColor.primary,
                      //     width: 1,
                      //   ),
                      // ),
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
                              lastDate: DateTime(DateTime.now().year,
                                  DateTime.now().month + 5),
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
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
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
                            TextDirectory.bodySmall(context,
                                '${model.plans.length} exciting plans waiting to happen'),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: AppColor.secondary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) =>
                                    BottomSheetTags(model.allTags),
                              ).then(
                                (value) => {
                                  model.selectedTags =
                                      List<String>.from(value),
                                  model.filterPlans(value ?? []),
                                  _scrollController.animateTo(
                                    0.0,
                                    duration:
                                        const Duration(milliseconds: 3000),
                                    curve: Curves.easeInOut,
                                  ),
                                },
                              );
                              ;
                            },
                            child: Icon(Icons.filter_alt_outlined),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        (model.selectedTags.isNotEmpty)
                            ? Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    model.clearTags();
                                    _scrollController.animateTo(
                                      0.0,
                                      duration:
                                          const Duration(milliseconds: 3000),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: Chip(
                                    shape: StadiumBorder(),
                                    backgroundColor: AppColor.secondary,
                                    label: Wrap(
                                      spacing: 4,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        TextDirectory.labelSmall(
                                            context, 'Clear All'),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        ...model.selectedTags.map((String entry) {
                          String label = TagsDirectory().getTagLabel(entry);
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Chip(
                              shape: StadiumBorder(),
                              backgroundColor: AppColor.black,
                              label: Wrap(
                                spacing: 4,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Container(
                                    child: SvgPicture.asset(
                                      TagsDirectory().getTagIcon(entry),
                                      color: AppColor.white,
                                    ),
                                  ),
                                  Text(
                                    label,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: AppFonts.subtitle,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.white,
                                      letterSpacing: 0.14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: screenWidth,
                      child: (model.plans.isEmpty)
                          ? FutureBuilder(
                              future: model.fetchPlans(context),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator(
                                    color: AppColor.primary,
                                  ));
                                } else if (snapshot.hasData) {
                                  List<CompletedAllPlans> plans =
                                      snapshot.data!;
                                  return RefreshIndicator(
                                    color: AppColor.primary,
                                    onRefresh: () async {
                                      List<CompletedAllPlans> refreshedPlans =
                                          await model.fetchPlans(context);
                                      model.refreshPlan(refreshedPlans);
                                      model.filterPlans(model.selectedTags);
                                    },
                                    child: ListView.builder(
                                      controller: _scrollController,
                                      itemCount: plans.length,
                                      itemBuilder: (context, index) =>
                                          SuggestionTile(
                                        plan: plans[index],
                                        isActive:
                                            model.isPlanAvailable(plans[index]),
                                        planDate: model.planDate,
                                      ),
                                    ),
                                  );
                                }
                                return NoPlansPlaceHolder(
                                  title: 'No Current Plans',
                                  content:
                                      'Please refresh/restart the app to view plans',
                                  btnTitle: 'Refresh',
                                  onPress: () async {
                                    List<CompletedAllPlans> refreshedPlans =
                                        await model.fetchPlans(context);
                                    model.refreshPlan(refreshedPlans);
                                    model.filterPlans(model.selectedTags);
                                  },
                                );
                              },
                            )
                          : RefreshIndicator(
                              onRefresh: () async {
                                List<CompletedAllPlans> refreshedPlans =
                                    await model.fetchPlans(context);
                                model.refreshPlan(refreshedPlans);
                                model.filterPlans(model.selectedTags);
                              },
                              child: ListView.builder(
                                controller: _scrollController,
                                itemCount: model.plans.length,
                                itemBuilder: (context, index) => SuggestionTile(
                                  plan: model.plans[index],
                                  isActive:
                                      model.isPlanAvailable(model.plans[index]),
                                  planDate: model.planDate,
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
