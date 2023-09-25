import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sweetscapes/model/response/createPlan_response.dart'
    as createPlan_response;
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/fonts.dart';
import 'package:sweetscapes/res/transport_directory.dart';

class RouteComponentTile extends StatelessWidget {
  const RouteComponentTile({super.key, required this.routeComponent});

  final createPlan_response.Route routeComponent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (routeComponent.boardingPoint!.contains('BIT Mesra'))
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
                          Icons.outlined_flag_rounded,
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
                              '${routeComponent.boardingPoint}',
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
                            'at ${DateFormat('h:mm a').format(DateTime.fromMillisecondsSinceEpoch(routeComponent.boardingTime!))}',
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Container(
                    width: 2,
                    color: AppColor.secondary,
                    height: 64,
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
                        (routeComponent.dropPoint!.contains('BIT Mesra'))
                            ? Icons.outlined_flag_rounded
                            : (routeComponent.dropPoint!.contains('Bus Stop'))
                                ? Icons.stop
                                : Icons.location_on_outlined,
                        size: 12,
                        color: AppColor.white,
                      ),
                    ),
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
                      padding: const EdgeInsets.only(top: 12.0),
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
                                  TransportDirectory()
                                      .getTransportIcon(routeComponent.mode!),
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
                                          (routeComponent.mode == "bus")
                                              ? 'Board Bus'
                                              : (routeComponent.mode ==
                                                      "walking")
                                                  ? 'Walk'
                                                  : (routeComponent.mode ==
                                                          "auto")
                                                      ? 'Board Auto'
                                                      : (routeComponent.mode ==
                                                              "scooty")
                                                          ? 'Ride Scooty'
                                                          : (routeComponent
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
                                            'at ${DateFormat('h:mm a').format(DateTime.fromMillisecondsSinceEpoch(routeComponent.boardingTime!))} ',
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
                                            ' ${routeComponent.duration} mins ',
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
                                            ' ${routeComponent.distance}',
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
                                (routeComponent.price != 0)
                                    ? '₹ ${routeComponent.price}'
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
                      padding: const EdgeInsets.only(top: 14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              '${routeComponent.dropPoint}',
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
                            'at ${DateFormat('h:mm a').format(DateTime.fromMillisecondsSinceEpoch(routeComponent.dropTime!))}',
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
                  ],
                ),
              ),
            ),
          ],
        ),
        (routeComponent.dropPoint!.contains('BIT Mesra'))
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
