import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sweetscapes/model/response/getDates_response.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/enums/Fonts.dart';
import 'package:sweetscapes/res/fonts.dart';
import 'package:sweetscapes/res/tags_directory.dart';

import '../enums/DateType.dart';

class SuggestionTile extends StatelessWidget {
  const SuggestionTile({
    super.key,
    required this.plan,
  });

  final CompletedAllPlans plan;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    var date = DateTime.fromMillisecondsSinceEpoch(plan.planStartTime!);
    String formattedTime = DateFormat('hh:mm a').format(date);

    TagsDirectory tagsDirectory = TagsDirectory();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: () {},
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
              CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  viewportFraction: 1,
                  // autoPlay: true,
                  // autoPlayInterval: const Duration(seconds: 3),
                ),
                items: plan.images!.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              child: Image.network(
                                "https://drive.google.com/uc?export=view&id=${i.imgLink}",
                                // "https://drive.google.com/uc?export=view&id=1QdNJBwl8XNk8dR_NDa1LU9mrsLj2kDkh",
                                fit: BoxFit.fill,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                        Text('Loading Image...'),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Container(
                            color: AppColor.black.withOpacity(0.4),
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 8.0),
                              child: Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Start At ${formattedTime}',
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
                        '${plan.tileContent}',
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
                      '₹${plan.price}/person + Travel Charges',
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
                      height: 28,
                    ),
                    Wrap(
                      runSpacing: -3,
                      spacing: 8,
                      children: plan.tags!.map((String entry) {
                        String iconTag = tagsDirectory.getTagIcon(entry);
                        String iconLabel = tagsDirectory.getTagLabel(entry);

                        return Chip(
                          shape: const StadiumBorder(),
                          backgroundColor: AppColor.secondary,
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
              )
            ],
          ),
          // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Container(
          //             width: MediaQuery.of(context).size.width * 0.5,
          //             child: Text(
          //               dateOverviewText,
          //             ),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.only(top: 20.0, left: 8),
          //             child: Text(
          //               '₹ $datePrice',
          //               style: const TextStyle(
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 16,
          //               ),
          //             ),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.only(left: 8),
          //             child: Container(
          //               width: screenWidth * 0.25,
          //               decoration: BoxDecoration(
          //                 color: Colors.grey.withOpacity(0.5),
          //                 borderRadius: BorderRadius.circular(10),
          //               ),
          //               child: const Icon(
          //                 Icons.keyboard_arrow_down_outlined,
          //                 size: 30,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Container(
          //         height: MediaQuery.of(context).size.height * 0.1,
          //         child: Image.asset(
          //           (dateType == DateType.DINEOUT)
          //               ? 'assets/images/dineout.png'
          //               : (dateType == DateType.WORKSHOP)
          //                   ? 'assets/images/workshop.png'
          //                   : 'assets/images/outing.png',
          //           fit: BoxFit.cover,
          //           // color: Color.fromRGBO(255, 255, 255, 0.5),
          //           colorBlendMode: BlendMode.modulate,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
