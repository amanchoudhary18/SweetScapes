import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/components/AppText.dart';
import 'package:sweetscapes/res/components/ExpandedListAnimationWidget.dart';
import 'package:sweetscapes/res/components/primary_button.dart';
import 'package:sweetscapes/res/enums/Fonts.dart';
import 'package:sweetscapes/res/fonts.dart';
import 'package:sweetscapes/utils/textDirectory.dart';
import 'package:sweetscapes/utils/utils.dart';
import 'package:sweetscapes/view_model/onboarding/updateTags_viewmodel.dart';

@RoutePage()
class SetUpDetailsView extends StatelessWidget {
  SetUpDetailsView({super.key});

  final TextEditingController _nameInputController = TextEditingController();
  final FocusNode _nameInputNode = FocusNode();

  final List<String> genderList = <String>['Male', 'Female'];
  final TextEditingController _genderInputController = TextEditingController();
  final FocusNode _genderInputNode = FocusNode();

  final TextEditingController _birthdayInputController =
      TextEditingController();
  final FocusNode _dobInputNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final upDateViewModel = Provider.of<UpdateTagsViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: 'Welcome Aboard!',
                      size: 28,
                      font: Fonts.TITLE,
                      weight: FontWeight.w700,
                      color: AppColor.black,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Email Verified! Please enter some basic details before we dive into the app.',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: AppFonts.subtitle,
                        fontWeight: FontWeight.normal,
                        color: AppColor.black,
                        letterSpacing: 0.2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 44, 0, 6),
                      child: TextDirectory.labelSmallBold(context, 'Name'),
                    ),
                    TextFormField(
                      controller: _nameInputController,
                      keyboardType: TextInputType.text,
                      cursorColor: AppColor.black,
                      focusNode: _nameInputNode,
                      decoration: InputDecoration(
                        hintText: 'Enter Full Name',
                        hintStyle:
                            const TextStyle(color: AppColor.disabledState),
                        filled: true,
                        fillColor: _nameInputNode.hasFocus
                            ? AppColor.secondary
                            : AppColor.tertiary,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: AppColor.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12, 0, 6),
                      child: TextDirectory.labelSmallBold(context, 'Gender'),
                    ),
                    TextFormField(
                      controller: _genderInputController,
                      keyboardType: TextInputType.none,
                      cursorHeight: 0,
                      cursorWidth: 0,
                      onTap: upDateViewModel.updateIsGenderDropdownExpanded,
                      decoration: InputDecoration(
                        hintText: 'Select your gender',
                        hintStyle:
                            const TextStyle(color: AppColor.disabledState),
                        filled: true,
                        fillColor: _genderInputNode.hasFocus
                            ? AppColor.secondary
                            : AppColor.tertiary,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: AppColor.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        suffixIcon: (!upDateViewModel.isGenderDropdownExpanded)
                            ? const Icon(
                                Icons
                                    .keyboard_arrow_down_rounded, // You can replace this with your desired icon
                                color: AppColor.black, // Icon color
                              )
                            : const Icon(
                                Icons
                                    .keyboard_arrow_up_rounded, // You can replace this with your desired icon
                                color: AppColor.black, // Icon color
                              ),
                      ),
                    ),
                    ExpandedSection(
                      height: 200,
                      expand: upDateViewModel.isGenderDropdownExpanded,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: genderList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: <Widget>[
                              RadioListTile(
                                title: Text(genderList.elementAt(index)),
                                value: genderList.elementAt(index),
                                groupValue: upDateViewModel.userGender,
                                activeColor: AppColor.primary,
                                onChanged: (val) {
                                  upDateViewModel.updateGender(
                                      val ?? upDateViewModel.userGender);
                                  _genderInputController.text =
                                      upDateViewModel.userGender;
                                  upDateViewModel
                                      .updateIsGenderDropdownExpanded();
                                },
                              ),
                              if (index < genderList.length - 1)
                                const Divider(
                                  thickness: 1,
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12, 0, 6),
                      child: TextDirectory.labelSmallBold(context, 'Birthday'),
                    ),
                    TextFormField(
                      controller: _birthdayInputController,
                      focusNode: _dobInputNode,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: upDateViewModel.userBirthDay,
                          firstDate: DateTime(1999),
                          lastDate: DateTime(DateTime.now().year-15),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: AppColor
                                      .primary, // header background color
                                  onPrimary:
                                      AppColor.white, // header text color
                                  onSurface: AppColor.black, // body text color
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        AppColor.primary, // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        ).then(
                          (value) => {
                            upDateViewModel.updateBirthday(
                                value ?? upDateViewModel.userBirthDay),
                            _birthdayInputController.text =
                                '${DateFormat('dd / MM / yyyy').format(value ?? upDateViewModel.userBirthDay)}',
                          },
                        );
                      },
                      keyboardType: TextInputType.none,
                      cursorHeight: 0,
                      cursorWidth: 0,
                      decoration: InputDecoration(
                        hintText: 'Select your DOB',
                        suffixIcon: const Icon(
                          Icons.calendar_month_outlined,
                          color: AppColor.black,
                        ),
                        hintStyle:
                            const TextStyle(color: AppColor.disabledState),
                        filled: true,
                        fillColor: _dobInputNode.hasFocus
                            ? AppColor.secondary
                            : AppColor.tertiary,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: AppColor.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColor.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: () {
                          AutoRouter.of(context).pop();
                        },
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          size: 30,
                        ),
                      ),
                    ),
                    PrimaryButton(
                      title: (!upDateViewModel.nextLoading)
                          ? '  Next  '
                          : 'Saving . . .',
                      onPress: () {
                        if (_nameInputController.text != '' &&
                            _genderInputController.text != '' &&
                            _birthdayInputController.text != '') {
                          upDateViewModel.submitBasicDetails(
                              _nameInputController.text.toString().trim(),
                              context);
                        } else {
                          Utils.goToast('Enter all details');
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
