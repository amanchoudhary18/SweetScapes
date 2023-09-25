import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/components/AppText.dart';
import 'package:sweetscapes/res/components/primary_button.dart';
import 'package:sweetscapes/res/enums/Fonts.dart';
import 'package:sweetscapes/res/fonts.dart';
import 'package:sweetscapes/view_model/onboarding/updateTags_viewmodel.dart';

@RoutePage()
class UpdateTagsView extends StatelessWidget {
  UpdateTagsView({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<UpdateTagsViewModel>(context);
    // final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: GestureDetector(
                          onTap: () {
                            AutoRouter.of(context).pop();
                          },
                          child: const Icon(
                            Icons.arrow_back_rounded,
                            size: 24,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: AppText(
                          text: 'Let us know,\nWhat defines you',
                          size: 28,
                          font: Fonts.TITLE,
                          weight: FontWeight.w700,
                          color: AppColor.black,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 8.0, 0, 36),
                        child: Text(
                          'Select your preferences for a \"Perfect day\" to get recommendations tailored to your interests',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: AppFonts.subtitle,
                            fontWeight: FontWeight.normal,
                            color: AppColor.black,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                      Expanded(
                        child: CupertinoScrollbar(
                          child: ListView(
                            children: [
                              AppText(
                                text: 'Dining Preferences',
                                size: 20,
                                font: Fonts.TITLE,
                                weight: FontWeight.w700,
                                color: AppColor.black,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 20.0, 0, 36),
                                child: Wrap(
                                  runSpacing: -3,
                                  spacing: 8,
                                  children: model.diningTags.entries
                                      .map((MapEntry<String, bool> entry) {
                                    String label = entry.key;
                                    bool isSelected = entry.value;
                
                                    return ChoiceChip(
                                      shape: StadiumBorder(side: BorderSide()),
                                      backgroundColor: AppColor.white,
                                      selectedColor: AppColor.black,
                                      label: Wrap(
                                        spacing: 4,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          Container(
                                            child: SvgPicture.asset(
                                              model.diningIcons[label]!,
                                              color: isSelected
                                                  ? AppColor.white
                                                  : AppColor.black,
                                            ),
                                          ),
                                          Text(
                                            label,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: AppFonts.subtitle,
                                              fontWeight: FontWeight.w500,
                                              color: (isSelected)
                                                  ? AppColor.white
                                                  : AppColor.black,
                                              letterSpacing: 0.14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      selected: isSelected,
                                      onSelected: (bool selected) {
                                        model.updateDiningTags(label);
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                              AppText(
                                text: 'Outing Preferences',
                                size: 20,
                                font: Fonts.TITLE,
                                weight: FontWeight.w700,
                                color: AppColor.black,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 20.0, 0, 36),
                                child: Wrap(
                                  runSpacing: -3,
                                  spacing: 8,
                                  children: model.outingTags.entries
                                      .map((MapEntry<String, bool> entry) {
                                    String label = entry.key;
                                    bool isSelected = entry.value;
                
                                    return ChoiceChip(
                                      shape: StadiumBorder(side: BorderSide()),
                                      backgroundColor: AppColor.white,
                                      selectedColor: AppColor.black,
                                      label: Wrap(
                                        spacing: 4,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: SvgPicture.asset(
                                              model.outingIcons[label]!,
                                              color: isSelected
                                                  ? AppColor.white
                                                  : AppColor.black,
                                            ),
                                          ),
                                          Text(
                                            label,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: AppFonts.subtitle,
                                              fontWeight: FontWeight.w500,
                                              color: (isSelected)
                                                  ? AppColor.white
                                                  : AppColor.black,
                                              letterSpacing: 0.14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      selected: isSelected,
                                      onSelected: (bool selected) {
                                        model.updateOutingTags(label);
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                PrimaryButton(
                  title: (model.submitLoading) ? 'Submitting . . .' : 'Submit',
                  onPress: () => model.submitPreferences(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
