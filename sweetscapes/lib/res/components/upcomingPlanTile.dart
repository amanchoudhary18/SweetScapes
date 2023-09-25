import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sweetscapes/model/body/saveUserCreatedPlan_body.dart';
import 'package:sweetscapes/model/response/getUpcomingPlans_response.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/fonts.dart';
import 'package:sweetscapes/res/tags_directory.dart';

import '../../app/routes/router.gr.dart';

class UpcomingPlanTile extends StatelessWidget {
  const UpcomingPlanTile({
    super.key,
    required this.plan,
  });

  final UserUpcomingPlans plan;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    var date = DateTime.fromMillisecondsSinceEpoch(plan.planStartTime!);
    String formattedTime = DateFormat('EEE, d MMM - hh:mm a').format(date);

    TagsDirectory tagsDirectory = TagsDirectory();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: () {
          AutoRouter.of(context).push(DateViewPlanViewRoute(
              saveUserCreatedPlanBody: new SaveUserCreatedPlanBody(),
              recentUpcomingPlanId: plan.id.toString()));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColor.black,
              width: 1,
            ),
          ),
          width: screenWidth,
          // height: screenHeight * 0.15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formattedTime,
                      style: const TextStyle(
                          height: 1.3,
                          fontSize: 18,
                          fontFamily: AppFonts.title,
                          fontWeight: FontWeight.w700,
                          color: AppColor.black,
                          letterSpacing: 0.15,
                        ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        '${plan.tileContent}',
                        style: const TextStyle(
                        color: AppColor.black,
                        fontFamily: AppFonts.subtitle,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.43,
                        letterSpacing: 0.24,
                      ),
                      ),
                    ),
                    Wrap(
                      runSpacing: -3,
                      spacing: 8,
                      children: plan.tags!.map((Tags entry) {
                        String iconTag = tagsDirectory.getTagIcon(entry.tag!);

                        Widget chip = Chip(
                          shape: const StadiumBorder(),
                          backgroundColor: AppColor.lightPositive,
                          label: Container(
                            child: SvgPicture.asset(
                              iconTag,
                              color: AppColor.black,
                            ),
                          ),
                        );

                        if (entry.order! < plan.tags!.length) {
                          chip = Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              chip,
                              Container(
                                width: 32, 
                                padding: const EdgeInsets.only(
                                    left: 8),                                 
                                child: const Divider(
                                  color: AppColor.grey9oo,
                                  height: 24, 
                                  thickness: 1,
                                ),
                              )
                            ],
                          );
                        }

                        return chip;
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
