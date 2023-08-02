import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sweetscapes/model/response/getAllPlans_response.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/fonts.dart';
import 'package:sweetscapes/res/tags_directory.dart';

class PlanComponentTile extends StatelessWidget {
  const PlanComponentTile({super.key, required this.component, required this.isEditable});

  final Components component;
  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: AppColor.black,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(
                  TagsDirectory()
                      .getTagIcon(component.details!.tags![0].toString()),
                  color: AppColor.white,
                ),
              ),
            ),
            Visibility(
              visible: true,
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                child: Container(
                  width: 2,
                  color: AppColor.secondary,
                  height: (component.isHighlight! || isEditable) ? 56 : 24,
                ),
              ),
            )
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, bottom: 8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColor.secondary,
                  width: 1,
                ),
              ),
              // width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        (component.details!.type! == 'Dining')
                            ? '${component.details!.hotelName.toString()}'
                            : '${component.details!.placeName.toString()}',
                        style: const TextStyle(
                          height: 20 / 14,
                          fontSize: 14,
                          fontFamily: AppFonts.title,
                          fontWeight: FontWeight.w700,
                          color: AppColor.black,
                          letterSpacing: 0.15,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${TagsDirectory().getTagLabel(component.details!.tags![0].toString())} ',
                          style: TextStyle(
                            height: 16 / 12,
                            fontSize: 12,
                            fontFamily: AppFonts.subtitle,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade600,
                            letterSpacing: 0.21,
                          ),
                        ),
                        const CircleAvatar(
                          radius: 2,
                          backgroundColor: AppColor.black,
                        ),
                        Text(
                          (component.details!.pricePerHead == null)
                              ? ''
                              : (component.details!.pricePerHead == 0)
                                  ? ' Free'
                                  : ' Avg. ₹${component.details!.pricePerHead.toString()}/Person',
                          style: TextStyle(
                            height: 16 / 12,
                            fontSize: 12,
                            fontFamily: AppFonts.subtitle,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade600,
                            letterSpacing: 0.21,
                          ),
                        ),
                      ],
                    ),
                    (component.isHighlight!)?
                    Chip(
                      shape: const StadiumBorder(),
                      backgroundColor: AppColor.lightPositive,
                      label: Wrap(
                        spacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: SvgPicture.asset(
                              'assets/svgFiles/highlight.svg',
                              color: AppColor.black,
                            ),
                          ),
                          const Text(
                            'Highlight',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: AppFonts.title,
                              fontWeight: FontWeight.w500,
                              color: AppColor.black,
                              letterSpacing: 0.14,
                            ),
                          ),
                        ],
                      ),
                    )
                    : (isEditable) ?
                    const Chip(
                      shape: const StadiumBorder(side: BorderSide(color: AppColor.black, width: 1,)),
                      backgroundColor: AppColor.white,
                      label: Wrap(
                        spacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Change',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: AppFonts.title,
                              fontWeight: FontWeight.w500,
                              color: AppColor.black,
                              letterSpacing: 0.14,
                            ),
                          ),
                        ],
                      ),
                    ):Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
