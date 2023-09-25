import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/fonts.dart';
import 'package:sweetscapes/view/savedPlans/savedPlans_view.dart';
import 'package:sweetscapes/view/date%20suggestions/date_suggestion_view.dart';
import 'package:sweetscapes/view/profile/user_profile_view.dart';
import 'package:sweetscapes/view_model/home_screen_view_model.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });

  final List<BottomNavigationBarItem> navbarItems = [
    /// Home
    BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: SvgPicture.asset('assets/svgFiles/explore.svg',
            height: 24,
            // theme: const SvgTheme(currentColor: Color.fromRGBO(158, 158, 158, 1)),
            // color: Color.fromRGBO(158, 158, 158, 1),
            colorFilter: ColorFilter.mode(
                Color.fromRGBO(158, 158, 158, 1), BlendMode.srcIn)),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: SvgPicture.asset('assets/svgFiles/explore.svg',
            height: 24,
            // theme: const SvgTheme(currentColor: AppColor.primary),
            // color: AppColor.primary,
            colorFilter: ColorFilter.mode(AppColor.primary, BlendMode.srcIn)),
      ),
      label: 'Explore',
    ),

    /// Saved
    BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: SvgPicture.asset('assets/svgFiles/saved.svg',
            height: 24,
            // theme: const SvgTheme(currentColor: Color.fromRGBO(158, 158, 158, 1)),
            // color: Color.fromRGBO(158, 158, 158, 1),
            colorFilter: ColorFilter.mode(
                Color.fromRGBO(158, 158, 158, 1), BlendMode.srcIn)),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: SvgPicture.asset('assets/svgFiles/saved.svg',
            height: 24,
            // theme: const SvgTheme(currentColor: AppColor.primary),
            // color: AppColor.primary,
            colorFilter: ColorFilter.mode(AppColor.primary, BlendMode.srcIn)),
      ),
      label: 'Plans',
    ),

    /// Profile
    BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: SvgPicture.asset('assets/svgFiles/profile.svg',
            height: 24,
            // theme: const SvgTheme(currentColor: Color.fromRGBO(158, 158, 158, 1)),
            // color: Color.fromRGBO(158, 158, 158, 1),
            colorFilter: ColorFilter.mode(
                Color.fromRGBO(158, 158, 158, 1), BlendMode.srcIn)),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: SvgPicture.asset('assets/svgFiles/profile.svg',
            height: 24,
            // theme: const SvgTheme(currentColor: AppColor.primary),
            // color: AppColor.primary,
            colorFilter: ColorFilter.mode(AppColor.primary, BlendMode.srcIn)),
      ),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeScreenViewModel>(context);

    final Screens = [
      DateSuggestionView(),
      SavedPlansView(),
      UserProfileView(),
    ];

    return Scaffold(
      extendBody: true,
      body: Screens[model.currentScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: model.currentScreenIndex,
        onTap: model.updateIndex,
        items: navbarItems,
        selectedItemColor: AppColor.black,
        selectedLabelStyle: const TextStyle(
          height: 1.14,
          fontSize: 14,
          fontFamily: AppFonts.title,
          fontWeight: FontWeight.w500,
          color: AppColor.primary,
          letterSpacing: 0.21,
        ),
        unselectedLabelStyle: const TextStyle(
          height: 1.14,
          fontSize: 14,
          fontFamily: AppFonts.title,
          fontWeight: FontWeight.w500,
          color: AppColor.secondary,
          letterSpacing: 0.21,
        ),
      ),
    );
  }
}
