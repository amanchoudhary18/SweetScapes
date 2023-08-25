import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:sweetscapes/model/body/saveUserCreatedPlan_body.dart';
import 'package:sweetscapes/model/response/saveUserCreatedPlan_response.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/components/AppText.dart';
import 'package:sweetscapes/res/components/viewPlanComponents.dart';
import 'package:sweetscapes/res/enums/Fonts.dart';
import 'package:sweetscapes/res/fonts.dart';
import 'package:sweetscapes/res/tags_directory.dart';
import 'package:sweetscapes/view/date%20suggestions/date_viewPlan_viewmodel.dart';

@RoutePage()
class DateViewPlanView extends StatelessWidget {
  const DateViewPlanView(this.saveUserCreatedPlanBody);

  // final CompletedAllPlans plan;
  // final int numberOfPeople;
  // final FinalTravel selectedTravel;

  final SaveUserCreatedPlanBody saveUserCreatedPlanBody;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    FinalPlanDetails? finalPlanDetails;

    return ViewModelBuilder.reactive(
      viewModelBuilder: () => DateViewPlanViewModel(saveUserCreatedPlanBody),
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        AutoRouter.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        size: 32,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.share_rounded,
                            size: 24,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Container(
                      width: screenWidth,
                      child: SingleChildScrollView(
                        child: (finalPlanDetails == null)
                            ? FutureBuilder(
                                future: model.fetchFinalPlan(context),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasData) {
                                    finalPlanDetails = snapshot.data!;
                                    return ViewPlanPage(
                                        finalPlanDetails!, context, model);
                                  }
                                  return Center(
                                    child: AppText(
                                      text: 'Not able to fetch Final Plan',
                                      size: 20,
                                      font: Fonts.TITLE,
                                      weight: FontWeight.w700,
                                      color: AppColor.black,
                                    ),
                                  );
                                },
                              )
                            : ViewPlanPage(finalPlanDetails!, context, model),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column ViewPlanPage(FinalPlanDetails finalPlanDetails, BuildContext context,
      DateViewPlanViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Plan Details',
          style: TextStyle(
            height: 36 / 28,
            fontSize: 28,
            fontFamily: AppFonts.title,
            fontWeight: FontWeight.w700,
            color: AppColor.black,
            letterSpacing: 0.15,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Text(
            'for ${DateFormat('EEE, MMM d').format(DateTime.fromMillisecondsSinceEpoch(finalPlanDetails.planStartTime!))}',
            style: const TextStyle(
              height: 20 / 14,
              fontSize: 14,
              fontFamily: AppFonts.title,
              fontWeight: FontWeight.w400,
              color: AppColor.black,
              letterSpacing: 0.21,
            ),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            viewportFraction: 1,
          ),
          items: finalPlanDetails.images!.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        child: Image.network(
                          "https://drive.google.com/uc?export=view&id=${i.imgLink}",
                          // "https://drive.google.com/uc?export=view&id=1QdNJBwl8XNk8dR_NDa1LU9mrsLj2kDkh",
                          fit: BoxFit.fill,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : 0.2,
                                  ),
                                  const Text('Loading Image...'),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.black.withOpacity(0.4),
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(12)),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8.0),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                'Place ${i.order}: ${i.imgName}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: AppFonts.subtitle,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.white,
                                  letterSpacing: 0.16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Start At ${DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(finalPlanDetails.planStartTime!))}, Cover ${finalPlanDetails.noOfComponents} locations',
                style: const TextStyle(
                  height: 1.3,
                  fontSize: 12,
                  fontFamily: AppFonts.title,
                  fontWeight: FontWeight.w500,
                  color: AppColor.black,
                  letterSpacing: 0.15,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  '${finalPlanDetails.tileContent}',
                  style: const TextStyle(
                    height: 1.3,
                    fontSize: 18,
                    fontFamily: AppFonts.title,
                    fontWeight: FontWeight.w700,
                    color: AppColor.black,
                    letterSpacing: 0.15,
                  ),
                ),
              ),
              Wrap(
                runSpacing: -3,
                spacing: 8,
                children: finalPlanDetails.tags!.map((String entry) {
                  String iconTag = TagsDirectory().getTagIcon(entry);
                  String iconLabel = TagsDirectory().getTagLabel(entry);

                  return Chip(
                    shape: const StadiumBorder(),
                    backgroundColor: AppColor.lightPositive,
                    label: Wrap(
                      spacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: SvgPicture.asset(
                            iconTag,
                            color: AppColor.black,
                          ),
                        ),
                        Text(
                          iconLabel,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: AppFonts.subtitle,
                            fontWeight: FontWeight.w500,
                            color: AppColor.black,
                            letterSpacing: 0.14,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 32, 0, 24),
          child: Text(
            'Journey',
            style: TextStyle(
              height: 24 / 18,
              fontSize: 18,
              fontFamily: AppFonts.title,
              fontWeight: FontWeight.w700,
              color: AppColor.black,
              letterSpacing: 0.15,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 48.0),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: finalPlanDetails.completeTravel!.length,
            itemBuilder: (context, index) => ViewPlanComponent(
              viewPlanComponent: finalPlanDetails.completeTravel![index],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColor.secondary),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Expenses For',
                          style: TextStyle(
                            height: 24 / 18,
                            fontSize: 18,
                            fontFamily: AppFonts.title,
                            fontWeight: FontWeight.w700,
                            color: AppColor.black,
                            letterSpacing: 0.15,
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: ChoiceChip(
                                shape: StadiumBorder(),
                                backgroundColor: AppColor.white,
                                selectedColor: AppColor.primary,
                                label: Wrap(
                                  spacing: 4,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      'Individual',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: AppFonts.subtitle,
                                        fontWeight: FontWeight.w500,
                                        color: (model.showIndividualPricing)
                                            ? AppColor.white
                                            : AppColor.black,
                                        letterSpacing: 0.14,
                                      ),
                                    ),
                                  ],
                                ),
                                selected: model.showIndividualPricing,
                                onSelected: (bool selected) {
                                  model.updateIndividualPricing();
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: ChoiceChip(
                                shape: StadiumBorder(),
                                backgroundColor: AppColor.white,
                                selectedColor: AppColor.primary,
                                label: Wrap(
                                  spacing: 4,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      'All',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: AppFonts.subtitle,
                                        fontWeight: FontWeight.w500,
                                        color: (model.showTotalPricing)
                                            ? AppColor.white
                                            : AppColor.black,
                                        letterSpacing: 0.14,
                                      ),
                                    ),
                                  ],
                                ),
                                selected: model.showTotalPricing,
                                onSelected: (bool selected) {
                                  model.updateTotalPricing();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColor.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Transport Expense',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: AppFonts.subtitle,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.grey9oo,
                                      letterSpacing: 0.14,
                                    ),
                                  ),
                                  Text(
                                    (model.showIndividualPricing)
                                    ? '₹ ${(model.finalPlanDetails.travelPrice!/model.finalPlanDetails.peopleCount!).ceil()}'
                                    : '₹ ${model.finalPlanDetails.travelPrice}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: AppFonts.subtitle,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.grey9oo,
                                      letterSpacing: 0.14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Other Expense',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: AppFonts.subtitle,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.grey9oo,
                                      letterSpacing: 0.14,
                                    ),
                                  ),
                                  Text(
                                    (model.showIndividualPricing)
                                    ? '₹ ${(model.finalPlanDetails.componentPrice!/model.finalPlanDetails.peopleCount!).ceil()}'
                                    : '₹ ${model.finalPlanDetails.componentPrice}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: AppFonts.subtitle,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.grey9oo,
                                      letterSpacing: 0.14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                              color: AppColor.secondary,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total Expense',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: AppFonts.subtitle,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.black,
                                      letterSpacing: 0.14,
                                    ),
                                  ),
                                  Text(
                                    (model.showIndividualPricing)
                                    ? '₹ ${((model.finalPlanDetails.travelPrice! + model.finalPlanDetails.componentPrice!)/model.finalPlanDetails.peopleCount!).ceil()}'
                                    : '₹ ${model.finalPlanDetails.travelPrice! + model.finalPlanDetails.componentPrice!}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: AppFonts.subtitle,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.black,
                                      letterSpacing: 0.14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
