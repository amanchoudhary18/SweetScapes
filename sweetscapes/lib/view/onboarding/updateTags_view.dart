import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sweetscapes/res/enums/DateType.dart';

import '../../res/components/choiceChip_widget.dart';
import '../../res/enums/Genders.dart';
import '../../view_model/onboarding/updateTags_viewmodel.dart';
import '../date suggestions/date_suggestion_view.dart';

class UpdateTagsView extends StatelessWidget {
  UpdateTagsView({super.key});

  final List<PopupMenuItem> genderOptions = [
    const PopupMenuItem(
      value: Genders.MALE,
      child: Text('Male'),
    ),
    const PopupMenuItem(
      value: Genders.FEMALE,
      child: Text('Female'),
    ),
    const PopupMenuItem(
      value: Genders.OTHERS,
      child: Text('Others'),
    ),
  ];

  List<ChoiceChipWidget> dineChips = [];

  void initializeDineChips(UpdateTagsViewModel model) {
    for (int i = 0; i < model.dineChipText.length; i++) {
      dineChips.add(
        ChoiceChipWidget(
          isSelected: false,
          index: i,
          model: model,
          dateType: DateType.DINEOUT,
        ),
      );
    }
  }

  List<ChoiceChipWidget> outingChips = [];

  void initializeOutingChips(UpdateTagsViewModel model) {
    for (int i = 0; i < model.outingChipText.length; i++) {
      outingChips.add(
        ChoiceChipWidget(
          isSelected: false,
          index: i,
          model: model,
          dateType: DateType.OUTING,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final model = Provider.of<UpdateTagsViewModel>(context);
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFFDFBF0),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: screenWidth * 0.8,
                height: screenHeight * 0.7,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: (model.onboardingState == 0)
                          ? Column(
                              children: [
                                Text(
                                  'Enter basic Details',
                                  style:
                                      Theme.of(context).textTheme.titleLarge,
                                ),
                                const Divider(
                                  thickness: 5,
                                ),
                                ListTile(
                                  title: Text(
                                    'BIRTHDAY',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium,
                                  ),
                                  subtitle: Text(
                                    '${DateFormat('dd / MM / yyyy').format(model.userBirthDay)}',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  leading: Icon(Icons.cake_outlined),
                                  trailing:
                                      Icon(Icons.calendar_month_outlined),
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: model.userBirthDay,
                                      firstDate: DateTime(1999),
                                      lastDate: DateTime(DateTime.now().year),
                                    ).then(
                                      (value) => model.updateBirthday(
                                          value ?? model.userBirthDay),
                                    );
                                  },
                                ),
                                const Divider(
                                  thickness: 5,
                                ),
                                ListTile(
                                  leading: Icon(Icons.man_4_outlined),
                                  title: Text(
                                    'GENDER',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium,
                                  ),
                                  subtitle: Text(
                                    (model.userGender == Genders.MALE)
                                        ? 'Male'
                                        : (model.userGender == Genders.FEMALE)
                                            ? 'Female'
                                            : 'Others',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  trailing: PopupMenuButton(
                                    itemBuilder: (context) => genderOptions,
                                    onSelected: (value) =>
                                        model.updateGender(value),
                                  ),
                                ),
                                const Divider(
                                  thickness: 5,
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .labelLarge,
                                  ),
                                  child: const Text('NEXT'),
                                  onPressed: () {
                                    initializeDineChips(model);
                                    initializeOutingChips(model);
                                    model.submitBasicDetails(context);
                                  },
                                ),
                              ],
                            )
                          : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Enter Preferences',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                const Divider(
                                  thickness: 5,
                                ),
                                Text(
                                  'Dining Preferences',
                                  style:
                                      Theme.of(context).textTheme.titleLarge,
                                ),
                                Wrap(
                                  spacing: 5,
                                  runSpacing: 1,
                                  children: dineChips,
                                ),
                                const Divider(
                                  thickness: 5,
                                ),
                                Text(
                                  'Outing Preferences',
                                  style:
                                      Theme.of(context).textTheme.titleLarge,
                                ),
                                Wrap(
                                  spacing: 5,
                                  runSpacing: 1,
                                  children: outingChips,
                                ),
                                const Divider(
                                  thickness: 5,
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}