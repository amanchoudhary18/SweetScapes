import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sweetscapes/res/enums/DateType.dart';

import '../../view_model/onboarding/updateTags_viewmodel.dart';

class ChoiceChipWidget extends StatefulWidget {
  ChoiceChipWidget({
    super.key,
    required this.isSelected,
    required this.model,
    required this.index,
    required this.dateType,
  });

  bool isSelected;
  DateType dateType;
  int index;
  UpdateTagsViewModel model;

  @override
  State<ChoiceChipWidget> createState() => _ChoiceChipWidgetState();
}

class _ChoiceChipWidgetState extends State<ChoiceChipWidget> {
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        (widget.dateType == DateType.DINEOUT)
        ? widget.model.dineChipText[widget.index]
        : widget.model.outingChipText[widget.index],
        style: TextStyle(color: Colors.white),
      ),
      selected: widget.isSelected,
      backgroundColor: Colors.blueGrey.shade300,
      selectedColor: Colors.purple.shade200,
      onSelected: (newState) {
        setState(() {
          widget.isSelected = newState;
          widget.model.updateChipStatus(widget.index, widget.dateType);
        });
      },
    );
  }
}
