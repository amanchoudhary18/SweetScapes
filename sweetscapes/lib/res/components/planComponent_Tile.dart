import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sweetscapes/model/response/getAllPlans_response.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/fonts.dart';
import 'package:sweetscapes/res/tags_directory.dart';
import 'package:url_launcher/url_launcher.dart';

class PlanComponentTile extends StatefulWidget {
  const PlanComponentTile(
      {super.key,
      required this.component,
      required this.isEditable,
      required this.onChangePressed});

  final Components component;
  final bool isEditable;
  final Function onChangePressed;

  @override
  State<PlanComponentTile> createState() => _PlanComponentTileState();
}

class _PlanComponentTileState extends State<PlanComponentTile> {
  bool showDetails = false;

  void setShowDetails() {
    setState(() {
      showDetails = !showDetails;
    });
  }

  Future<void> _launchMap(String latitude, String longitude) async {
    final Uri googleMapsUrl =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

    // final Uri appleMapsUrl =
    //     Uri.parse('https://maps.apple.com/?q=$latitude,$longitude');

    // if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    // }else if (await canLaunchUrl(appleMapsUrl)) {
    //   await launchUrl(appleMapsUrl);
    // } else {
    //   Utils.goToast('Unable to open Map');
    // }
  }

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
                  TagsDirectory().getTagIcon(
                      widget.component.details!.tags![0].toString()),
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
                  height: (showDetails && !widget.isEditable)
                      ? (widget.component.isHighlight!)
                          ? 282
                          : 250
                      : (widget.component.isHighlight! || widget.isEditable)
                          ? 56
                          : 24,
                ),
              ),
            )
          ],
        ),
        Expanded(
          child: GestureDetector(
            onTap: setShowDetails,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: (widget.component.isHighlight ?? false)
                        ? AppColor.primary
                        : AppColor.secondary,
                    width: 1,
                  ),
                ),
                // width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              (widget.component.details!.type! == 'Dining')
                                  ? '${widget.component.details!.hotelName.toString()}'
                                  : '${widget.component.details!.placeName.toString()}',
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
                          Visibility(
                            visible: (!widget.isEditable),
                            child: (showDetails)
                                ? Icon(Icons.keyboard_arrow_up_outlined)
                                : Icon(Icons.keyboard_arrow_down_outlined),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '${TagsDirectory().getTagLabel(widget.component.details!.tags![0].toString())} ',
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
                            (widget.component.details!.pricePerHead == null)
                                ? ''
                                : (widget.component.details!.pricePerHead == 0)
                                    ? ' Free'
                                    : ' Avg. ₹${widget.component.details!.pricePerHead.toString()}/Person',
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
                      Visibility(
                        visible: widget.component.isHighlight ?? false,
                        child: Chip(
                          shape: const StadiumBorder(),
                          backgroundColor: AppColor.primary.withOpacity(0.3),
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
                        ),
                      ),
                      (showDetails && !widget.isEditable)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    '${widget.component.details!.description} ',
                                    style: TextStyle(
                                      height: 16 / 12,
                                      fontSize: 12,
                                      fontFamily: AppFonts.subtitle,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade600,
                                      letterSpacing: 0.21,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Rating',
                                    style: TextStyle(
                                      height: 16 / 12,
                                      fontSize: 12,
                                      fontFamily: AppFonts.title,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.black,
                                      letterSpacing: 0.15,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    RatingBarIndicator(
                                      rating: widget.component.details!.rating!,
                                      itemBuilder: (context, index) =>
                                          const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 16.0,
                                      direction: Axis.horizontal,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6.0),
                                      child: Text(
                                        '(${widget.component.details!.rating!})',
                                        style: TextStyle(
                                          height: 16 / 12,
                                          fontSize: 12,
                                          fontFamily: AppFonts.subtitle,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey.shade600,
                                          letterSpacing: 0.21,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 12.0),
                                  child: Text(
                                    'Links',
                                    style: TextStyle(
                                      height: 16 / 12,
                                      fontSize: 12,
                                      fontFamily: AppFonts.title,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.black,
                                      letterSpacing: 0.15,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    (widget.component.details!.map!.lat ==
                                                null ||
                                            widget.component.details!.map!
                                                    .lng ==
                                                null)
                                        ? const Text(
                                            'Map location not available',
                                            style: TextStyle(
                                              height: 16 / 12,
                                              fontSize: 12,
                                              fontFamily: AppFonts.subtitle,
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.black,
                                              letterSpacing: 0.21,
                                            ),
                                          )
                                        : InkWell(
                                            child: const Text(
                                              'Location',
                                              style: TextStyle(
                                                height: 16 / 12,
                                                fontSize: 12,
                                                fontFamily: AppFonts.subtitle,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.blue,
                                                letterSpacing: 0.21,
                                              ),
                                            ),
                                            // onTap: () async {
                                            //   await launchUrl(
                                            //     Uri.parse(
                                            //         'https://www.google.com/maps/search/?api=1&query=${widget.component.details!.map!.lat},${widget.component.details!.map!.lng}'),
                                            //   );
                                            // },
                                            // onTap: _launchMap(widget.component.details!.map!.lat!, widget.component.details!.map!.lng!),
                                            onTap: () async {_launchMap('23.40995726498554','85.44449233778705');},
                                          ),
                                    Visibility(
                                      visible: widget
                                              .component.details!.websiteLink !=
                                          null,
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.blue,
                                          radius: 2,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: widget
                                              .component.details!.websiteLink !=
                                          null,
                                      child: InkWell(
                                        child: const Text(
                                          'Website',
                                          style: TextStyle(
                                            height: 16 / 12,
                                            fontSize: 12,
                                            fontFamily: AppFonts.subtitle,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.blue,
                                            letterSpacing: 0.21,
                                          ),
                                        ),
                                        onTap: () async {
                                          await launchUrl(
                                            Uri.parse(
                                                '${widget.component.details!.websiteLink}'),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 12.0),
                                  child: Text(
                                    'Timings',
                                    style: TextStyle(
                                      height: 16 / 12,
                                      fontSize: 12,
                                      fontFamily: AppFonts.title,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.black,
                                      letterSpacing: 0.15,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    for (TimeSlots timeslot
                                        in widget.component.details!.timeSlots!)
                                      Text(
                                        '${timeslot.openingTime} - ${timeslot.closingTime}',
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
                                Visibility(
                                  visible: (widget.component.details!.type ==
                                          'Dining' &&
                                      widget.component.details!.menu != null),
                                  child: const Padding(
                                    padding: EdgeInsets.only(top: 12.0),
                                    child: Text(
                                      'Menu',
                                      style: TextStyle(
                                        height: 16 / 12,
                                        fontSize: 12,
                                        fontFamily: AppFonts.title,
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.black,
                                        letterSpacing: 0.15,
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: (widget.component.details!.type ==
                                          'Dining' &&
                                      widget.component.details!.menu != null),
                                  child: InkWell(
                                    child: const Text(
                                      'See PDF',
                                      style: TextStyle(
                                        height: 16 / 12,
                                        fontSize: 12,
                                        fontFamily: AppFonts.subtitle,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.blue,
                                        letterSpacing: 0.21,
                                      ),
                                    ),
                                    onTap: () async {
                                      await launchUrl(
                                        Uri.parse(
                                            '${widget.component.details!.menu}'),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                          : (widget.isEditable &&
                                  !widget.component.isHighlight!)
                              ? GestureDetector(
                                  onTap: () {
                                    widget.onChangePressed(
                                        widget.component.details!.type,
                                        widget.component.details!.tags![0],
                                        widget.component.order);
                                  },
                                  child: const Chip(
                                    shape: StadiumBorder(
                                        side: BorderSide(
                                      color: AppColor.black,
                                      width: 1,
                                    )),
                                    backgroundColor: AppColor.white,
                                    label: Wrap(
                                      spacing: 4,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
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
                                  ),
                                )
                              : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
