import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/components/AppText.dart';
import 'package:sweetscapes/res/components/primary_button.dart';
import 'package:sweetscapes/res/components/secondary_button.dart';
import 'package:sweetscapes/res/enums/Fonts.dart';
import 'package:sweetscapes/res/fonts.dart';
import 'package:sweetscapes/view/date%20suggestions/date_suggestion_viewmodel.dart';

class BottomSheetTags extends StatefulWidget {
  BottomSheetTags(this.allTags);

  final Map<String, bool> allTags;

  @override
  _BottomSheetTagsState createState() => _BottomSheetTagsState();
}

class _BottomSheetTagsState extends State<BottomSheetTags> {
  List<String> selectedTags = [];

  void _onTagSelected(String tag) {
    int selectedCount =
        widget.allTags.values.where((selected) => selected).length;

    // Allow selection if less than 3 choices are already selected or if the current choice is being unselected.
    if (selectedCount < 3 || widget.allTags[tag] == true) {
      setState(() {
        widget.allTags[tag] = !widget.allTags[tag]!;

        // Update the selectedTags list based on the current selected tags.
        selectedTags = widget.allTags.entries
            .where((entry) => entry.value)
            .map((entry) => entry.key)
            .toList();
      });
    }
  }

  void _resetTags() {
    setState(() {
      widget.allTags.forEach((key, value) {
        widget.allTags[key] = false;
      });
      selectedTags = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<DateSuggestionViewModel>(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: 'Filters',
                size: 24,
                font: Fonts.TITLE,
                weight: FontWeight.w700,
                color: AppColor.black,
              ),
              Text(
                'You can select upto 3 tags',
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
                height: 44,
              ),
              AppText(
                text: 'Dining Preferences',
                size: 18,
                font: Fonts.TITLE,
                weight: FontWeight.w700,
                color: AppColor.black,
              ),
              Wrap(
                runSpacing: -3,
                spacing: 8,
                children: model.diningTags.entries
                    .map((MapEntry<String, bool> entry) {
                  String label = entry.key;

                  return ChoiceChip(
                    shape: StadiumBorder(),
                    backgroundColor: AppColor.secondary,
                    selectedColor: AppColor.black,
                    label: Wrap(
                      spacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          child: SvgPicture.asset(
                            model.diningIcons[label]!,
                            color: (widget.allTags[label]!)
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
                            color: (widget.allTags[label]!)
                                ? AppColor.white
                                : AppColor.black,
                            letterSpacing: 0.14,
                          ),
                        ),
                      ],
                    ),
                    selected: widget.allTags[label]!,
                    onSelected: (selected) => _onTagSelected(label),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 32,
              ),
              AppText(
                text: 'Outing Preferences',
                size: 18,
                font: Fonts.TITLE,
                weight: FontWeight.w700,
                color: AppColor.black,
              ),
              Wrap(
                runSpacing: -3,
                spacing: 8,
                children: model.outingTags.entries
                    .map((MapEntry<String, bool> entry) {
                  String label = entry.key;

                  return ChoiceChip(
                    shape: StadiumBorder(),
                    backgroundColor: AppColor.secondary,
                    selectedColor: AppColor.black,
                    label: Wrap(
                      spacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: SvgPicture.asset(
                            model.outingIcons[label]!,
                            color: (widget.allTags[label]!)
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
                            color: (widget.allTags[label]!)
                                ? AppColor.white
                                : AppColor.black,
                            letterSpacing: 0.14,
                          ),
                        ),
                      ],
                    ),
                    selected: widget.allTags[label]!,
                    onSelected: (selected) => _onTagSelected(label),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 44,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SecondaryButton(
                        title: 'Clear All',
                        onPress: () {
                          _resetTags();
                          Navigator.pop(context, selectedTags);
                        }),
                  ),
                  SizedBox(
                    width: 9,
                  ),
                  Expanded(
                    child: PrimaryButton(
                        title: 'Apply',
                        onPress: () {
                          // model.filterPlans(context, selectedTags, model.plans);
                          Navigator.pop(context, selectedTags);
                          // AutoRouter.of(context).pop();
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
