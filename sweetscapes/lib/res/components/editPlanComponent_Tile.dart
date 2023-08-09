import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sweetscapes/model/response/getAllPlans_response.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/fonts.dart';
import 'package:sweetscapes/res/tags_directory.dart';

class EditPlanComponentTile extends StatelessWidget {
  const EditPlanComponentTile(
      {super.key, required this.component, required this.onPressed});

  final Components component;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed(component);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: SvgPicture.asset(
                TagsDirectory()
                    .getTagIcon(component.details!.tags![0].toString()),
                color: AppColor.black,
                width: 24,
                height: 24,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
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
                    const Padding(
                      padding: EdgeInsets.only(top: 12.0),
                      child: Divider(
                        color: AppColor.black,
                        height: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
