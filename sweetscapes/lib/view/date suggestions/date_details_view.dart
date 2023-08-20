import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:sweetscapes/model/response/getAllPlans_response.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/components/AppText.dart';
import 'package:sweetscapes/res/components/planComponent_Tile.dart';
import 'package:sweetscapes/res/components/primary_button.dart';
import 'package:sweetscapes/res/enums/Fonts.dart';
import 'package:sweetscapes/res/fonts.dart';
import 'package:sweetscapes/res/tags_directory.dart';
import 'package:sweetscapes/view/date%20suggestions/bottomsheet_compareTransport.dart';
import 'package:sweetscapes/view/date%20suggestions/bottomsheet_editcomponents.dart';
import 'package:sweetscapes/view/date%20suggestions/date_details_viewmodel.dart';

@RoutePage()
class DateDetailsView extends StatelessWidget {
  const DateDetailsView(this.plan);

  final CompletedAllPlans plan;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ViewModelBuilder.reactive(
      viewModelBuilder: () => DateDetailsViewModel(plan),
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          model.resetPlan();
          return true;
        },
        child: Scaffold(
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
                      Row(
                        children: [
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
                                  Icons.bookmark_border_rounded,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
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
                          ),
                        ],
                      )
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Container(
                        width: screenWidth,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              CarouselSlider(
                                options: CarouselOptions(
                                  height: 200,
                                  viewportFraction: 1,
                                ),
                                items: model.plan.images!.map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Stack(
                                        alignment:
                                            AlignmentDirectional.bottomStart,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 200,
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(12)),
                                              child: Image.network(
                                                "https://drive.google.com/uc?export=view&id=${i.imgLink}",
                                                // "https://drive.google.com/uc?export=view&id=1QdNJBwl8XNk8dR_NDa1LU9mrsLj2kDkh",
                                                fit: BoxFit.fill,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        CircularProgressIndicator(
                                                          value: loadingProgress
                                                                      .expectedTotalBytes !=
                                                                  null
                                                              ? loadingProgress
                                                                      .cumulativeBytesLoaded /
                                                                  loadingProgress
                                                                      .expectedTotalBytes!
                                                              : 0.2,
                                                        ),
                                                        const Text(
                                                            'Loading Image...'),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppColor.black
                                                  .withOpacity(0.4),
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                      bottom:
                                                          Radius.circular(12)),
                                            ),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 8.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                    child: Text(
                                                      'Place ${i.order}: ${i.imgName}',
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        fontFamily:
                                                            AppFonts.subtitle,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                padding: const EdgeInsets.only(top: 32.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Start At ${DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(model.plan.planStartTime!))}',
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
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Text(
                                        '${model.plan.tileContent}',
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
                                    Text(
                                      '₹${model.plan.price}/person + Travel Charges',
                                      style: TextStyle(
                                        height: 1.14,
                                        fontSize: 14,
                                        fontFamily: AppFonts.subtitle,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade600,
                                        letterSpacing: 0.21,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Wrap(
                                      runSpacing: -3,
                                      spacing: 8,
                                      children:
                                          model.plan.tags!.map((String entry) {
                                        String iconTag =
                                            TagsDirectory().getTagIcon(entry);
                                        String iconLabel =
                                            TagsDirectory().getTagLabel(entry);

                                        return Chip(
                                          shape: const StadiumBorder(),
                                          backgroundColor:
                                              AppColor.lightPositive,
                                          label: Wrap(
                                            spacing: 4,
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
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
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 28.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AppText(
                                            text: 'Plan Components',
                                            size: 18,
                                            font: Fonts.TITLE,
                                            weight: FontWeight.w700,
                                            color: AppColor.black,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              model.initializePlanDetails();
                                              showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                builder: (BuildContext
                                                        context) =>
                                                    BottomSheetEditComponents(
                                                        model
                                                            .editPlanComponents,
                                                        model),
                                              );
                                            },
                                            child: Container(
                                              height: 20,
                                              child: Text(
                                                'Edit',
                                                style: TextStyle(
                                                  height: 1.14,
                                                  fontSize: 14,
                                                  fontFamily: AppFonts.subtitle,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.blue.shade400,
                                                  letterSpacing: 0.21,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: model.plan.components!
                                          .map((Components component) {
                                        return PlanComponentTile(
                                          component: component,
                                          isEditable: false,
                                          onChangePressed: () {},
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 16, 0, 24),
                                child: PrimaryButton(
                                    title: 'Compare Transport',
                                    onPress: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (BuildContext context) =>
                                            BottomSheetCompareTransport(model),
                                      );
                                    }),
                              ),
                            ],
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
