import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/components/AppText.dart';
import 'package:sweetscapes/res/enums/Fonts.dart';
import 'package:sweetscapes/res/fonts.dart';
import 'package:sweetscapes/view_model/onboarding/updateTags_viewmodel.dart';


@RoutePage()
class SetUpDetailsView extends StatelessWidget {
  SetUpDetailsView({super.key});

  final TextEditingController _nameInputController = TextEditingController();
  final FocusNode _nameInputNode = FocusNode();

  final List<String> genderList = <String>['Male', 'Female'];

  final TextEditingController _birthdayInputController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final upDateViewModel = Provider.of<UpdateTagsViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 52, 24, 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        AutoRouter.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        size: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 44,
                    ),
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
                    const SizedBox(
                      height: 52,
                    ),
                    TextFormField(
                      controller: _nameInputController,
                      keyboardType: TextInputType.text,
                      focusNode: _nameInputNode,
                      decoration: const InputDecoration(
                        hintText: 'Full Name',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: AppColor.secondary,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: AppColor.primary,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    DropdownButtonFormField(
                      items: genderList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        upDateViewModel
                            .updateGender(value ?? upDateViewModel.userGender);
                      },
                      icon: Icon(Icons.keyboard_arrow_down_outlined),
                      decoration: const InputDecoration(
                        hintText: 'Select your Gender',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: AppColor.secondary,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: AppColor.primary,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _birthdayInputController,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: upDateViewModel.userBirthDay,
                          firstDate: DateTime(1999),
                          lastDate: DateTime(DateTime.now().year),
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
                      decoration: const InputDecoration(
                        hintText: 'Birthday',
                        suffixIcon: Icon(
                          Icons.calendar_month_outlined,
                          color: AppColor.black,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: AppColor.secondary,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: AppColor.primary,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    upDateViewModel.submitBasicDetails(_nameInputController.text.toString().trim() ,context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.secondary,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColor.black),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        child: (upDateViewModel.nextLoading)
                            ? const CircularProgressIndicator(
                                color: AppColor.black,
                                strokeWidth: 2,
                              )
                            : const Text(
                                'Proceed',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: AppFonts.button,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.black,
                                  letterSpacing: 0.2,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
