import 'package:flutter/material.dart';
import 'package:sweetscapes/model/response/getAllPlans_response.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/components/AppText.dart';
import 'package:sweetscapes/res/components/planComponent_Tile.dart';
import 'package:sweetscapes/res/components/primary_button.dart';
import 'package:sweetscapes/res/components/secondary_button.dart';
import 'package:sweetscapes/res/enums/Fonts.dart';
import 'package:sweetscapes/res/fonts.dart';

class BottomSheetEditComponents extends StatefulWidget {
  BottomSheetEditComponents(this.planComponents);

  final List<Components> planComponents;

  @override
  _BottomSheetTagsState createState() => _BottomSheetTagsState();
}

class _BottomSheetTagsState extends State<BottomSheetEditComponents> {
  List<String> selectedTags = [];

  void _onTagSelected(String tag) {}

  void _resetTags() {}

  @override
  Widget build(BuildContext context) {
    // final model = Provider.of<DateDetailsViewModel>(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: 'Edit Plan',
                size: 24,
                font: Fonts.TITLE,
                weight: FontWeight.w700,
                color: AppColor.black,
              ),
              Text(
                'You can change location other than the highlight',
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
              Column(
                children: widget.planComponents.map((Components component) {
                  return PlanComponentTile(component: component, isEditable: true,);
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
