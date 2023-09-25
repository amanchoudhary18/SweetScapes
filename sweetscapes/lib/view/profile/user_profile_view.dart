import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:sweetscapes/model/response/getMyData_response.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/components/noPlansPlaceHolder.dart';
import 'package:sweetscapes/utils/textDirectory.dart';
import 'package:sweetscapes/view/profile/user_profile_viewmodel.dart';
import 'package:sweetscapes/view_model/home_screen_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class UserProfileView extends StatelessWidget {
  UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    Future<void> _sendEmail() async {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path:
            'sweetscapes.organization@gmail.com',
        query: '',
      );

      // if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
      // } else {
        // Utils.goToast('Unable to open Email app');
        // print('Could not launch email');
      // }
    }

    return ViewModelBuilder.reactive(
      viewModelBuilder: () => UserProfileViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Container(
            width: screenWidth,
            height: screenHeight,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                child:
                    // (model.getMyDataResponse.name == null) ?
                    FutureBuilder(
                  future: model.getMyData(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: AppColor.primary,
                      ));
                    } else if (snapshot.hasData) {
                      UserData userData = snapshot.data!;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: AppColor.secondary,
                            child: SvgPicture.asset(
                              'assets/svgFiles/profile.svg',
                              height: 50,
                              colorFilter: const ColorFilter.mode(
                                  AppColor.primary, BlendMode.srcIn),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: TextDirectory.displayMedium(
                                context, userData.name!),
                          ),
                          TextDirectory.bodySmall(context, userData.email!),
                          Padding(
                            padding: const EdgeInsets.only(top: 32.0),
                            child: Container(
                              height: screenHeight * 0.4,
                              child: ListView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 6.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: AppColor.black,
                                          width: 1,
                                        ),
                                      ),
                                      child: ListTile(
                                        leading: SvgPicture.asset(
                                          'assets/svgFiles/referFriends.svg',
                                          colorFilter: const ColorFilter.mode(
                                              AppColor.black, BlendMode.srcIn),
                                        ),
                                        horizontalTitleGap: 0,
                                        title: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextDirectory.labelSmallBold(
                                              context, 'Refer Friends'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 6.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: AppColor.black,
                                          width: 1,
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: _sendEmail,
                                        child: ListTile(
                                          leading: SvgPicture.asset(
                                            'assets/svgFiles/contactUs.svg',
                                            colorFilter: const ColorFilter.mode(
                                                AppColor.black, BlendMode.srcIn),
                                          ),
                                          horizontalTitleGap: 0,
                                          title: Align(
                                            alignment: Alignment.centerLeft,
                                            child: TextDirectory.labelSmallBold(
                                                context, 'Contact Us'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 6.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: AppColor.black,
                                          width: 1,
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          model.logoutPressed(context);
                                        },
                                        child: ListTile(
                                          leading: SvgPicture.asset(
                                            'assets/svgFiles/logout.svg',
                                            height: 24,
                                            colorFilter: const ColorFilter.mode(
                                                AppColor.black,
                                                BlendMode.srcIn),
                                          ),
                                          horizontalTitleGap: 0,
                                          title: Align(
                                            alignment: Alignment.centerLeft,
                                            child: TextDirectory.labelSmallBold(
                                                context, 'Logout'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return NoPlansPlaceHolder(
                      title: 'No Recent Plans',
                      content: 'Your recently visited plans will be shown here',
                      btnTitle: 'Explore',
                      onPress: () {
                        Provider.of<HomeScreenViewModel>(context, listen: false)
                            .updateIndex(0);
                      },
                    );
                  },
                )
                // : AboutDialog(
                //     applicationIcon:
                //         Text(model.getMyDataResponse.name.toString()),
                //   ),
                ),
          ),
        ),
      ),
    );
  }
}
