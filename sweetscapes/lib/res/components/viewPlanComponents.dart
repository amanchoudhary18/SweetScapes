import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sweetscapes/model/response/saveUserCreatedPlan_response.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/fonts.dart';
import 'package:sweetscapes/res/tags_directory.dart';
import 'package:sweetscapes/res/transport_directory.dart';

class ViewPlanComponent extends StatelessWidget {
  const ViewPlanComponent({super.key, required this.viewPlanComponent});

  final CompleteTravel viewPlanComponent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (viewPlanComponent.boardingPoint! == "BIT Mesra" ||
                viewPlanComponent.boardingPoint! == "PMC Bus Stop")
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(1.0),
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColor.black,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.location_on_outlined,
                          size: 12,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              '${viewPlanComponent.boardingPoint}',
                              style: const TextStyle(
                                height: 24 / 16,
                                fontSize: 16,
                                fontFamily: AppFonts.title,
                                fontWeight: FontWeight.w700,
                                color: AppColor.black,
                                letterSpacing: 0.15,
                              ),
                            ),
                          ),
                          Text(
                            'at ${DateFormat('h:mm a').format(DateTime.fromMillisecondsSinceEpoch(viewPlanComponent.boardingTime!))}',
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
                    ),
                  ),
                ],
              )
            : Container(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Container(
                    width: 2,
                    color: AppColor.secondary,
                    height: 72,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: AppColor.black,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        (viewPlanComponent.dropPoint == 'BIT Mesra')
                            ? Icons.location_on_outlined
                            : (viewPlanComponent.dropPoint!
                                    .contains('Bus Stop'))
                                ? Icons.stop
                                : Icons.outlined_flag_rounded,
                        size: 12,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ),
                (((viewPlanComponent.boardingPoint! == "BIT Mesra" ||
                        viewPlanComponent.boardingPoint! == "PMC Bus Stop") && viewPlanComponent.mode == 'bus') || (viewPlanComponent.dropPoint! == "BIT Mesra" ||
                        viewPlanComponent.dropPoint! == "PMC Bus Stop"))
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Container(
                          width: 2,
                          color: AppColor.secondary,
                          height: 72,
                        ),
                      ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: (viewPlanComponent.dropPointComponent != null)? const EdgeInsets.only(top: 0.0): const EdgeInsets.only(top: 12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColor.secondary,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: SvgPicture.asset(
                                  TransportDirectory().getTransportIcon(
                                      viewPlanComponent.mode!),
                                  color: AppColor.black,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 6.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Text(
                                          (viewPlanComponent.mode == "bus")
                                              ? 'Board Bus'
                                              : (viewPlanComponent.mode ==
                                                      "walking")
                                                  ? 'Walk'
                                                  : (viewPlanComponent.mode ==
                                                          "auto")
                                                      ? 'Board Auto'
                                                      : (viewPlanComponent
                                                                  .mode ==
                                                              "scooty")
                                                          ? 'Ride Scooty'
                                                          : (viewPlanComponent
                                                                      .mode ==
                                                                  "bike")
                                                              ? 'Ride Bike'
                                                              : 'Drive',
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
                                            'at ${DateFormat('h:mm a').format(DateTime.fromMillisecondsSinceEpoch(viewPlanComponent.boardingTime!))} ',
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
                                            ' ${viewPlanComponent.duration} mins ',
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
                                            ' ${viewPlanComponent.distance}',
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
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                (viewPlanComponent.price != 0)
                                    ? '₹ ${viewPlanComponent.price}'
                                    : '',
                                style: const TextStyle(
                                  height: 20 / 14,
                                  fontSize: 14,
                                  fontFamily: AppFonts.title,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.black,
                                  letterSpacing: 0.15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 14.0, 0, 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              '${viewPlanComponent.dropPoint}',
                              style: const TextStyle(
                                height: 24 / 16,
                                fontSize: 16,
                                fontFamily: AppFonts.title,
                                fontWeight: FontWeight.w700,
                                color: AppColor.black,
                                letterSpacing: 0.15,
                              ),
                            ),
                          ),
                          Text(
                            'at ${DateFormat('h:mm a').format(DateTime.fromMillisecondsSinceEpoch(viewPlanComponent.dropTime!))}',
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
                    ),
                    (viewPlanComponent.dropPointComponent != null)
                        ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: (viewPlanComponent
                                      .dropPointComponent!.isHighlight!)
                                  ? AppColor.primary
                                  : AppColor.secondary,
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: SvgPicture.asset(
                                    TagsDirectory().getTagIcon(
                                        viewPlanComponent
                                            .dropPointComponent!.tag!),
                                    color: AppColor.black,
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 6.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Text(
                                            viewPlanComponent
                                                .dropPointComponent!.name!,
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
                                        Text(
                                          'Average time spent here: ${((viewPlanComponent.dropPointComponent!.duration)! / 60).round()} hr(s)',
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
                                  ),
                                ),
                                Text(
                                  (viewPlanComponent.dropPointComponent!.pricePerHead! != 0)
                                      ? '₹ ${viewPlanComponent.dropPointComponent!.pricePerHead!}'
                                      : '',
                                  style: const TextStyle(
                                    height: 20 / 14,
                                    fontSize: 14,
                                    fontFamily: AppFonts.title,
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.black,
                                    letterSpacing: 0.15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
        (viewPlanComponent.dropPoint! == "BIT Mesra" ||
                viewPlanComponent.dropPoint! == "PMC Bus Stop")
            ? Padding(
                padding: const EdgeInsets.fromLTRB(36, 12, 0, 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColor.secondary,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: const Text(
                            'Plan Ends Here',
                            style: TextStyle(
                              height: 20 / 14,
                              fontSize: 14,
                              fontFamily: AppFonts.title,
                              fontWeight: FontWeight.w700,
                              color: AppColor.black,
                              letterSpacing: 0.15,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.check_circle_outline_rounded,
                          size: 24,
                          color: Colors.green,
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
