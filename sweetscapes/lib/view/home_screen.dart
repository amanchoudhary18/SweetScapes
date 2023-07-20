import 'package:auto_route/annotations.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetscapes/view/bookings/bookings_view.dart';
import 'package:sweetscapes/view/date%20suggestions/date_suggestion_view.dart';
import 'package:sweetscapes/view/gifts/gift_suggestion_view.dart';
import 'package:sweetscapes/view/profile/user_profile_view.dart';
import 'package:sweetscapes/view_model/home_screen_view_model.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });

  final List<DotNavigationBarItem> navbarItems = [
    /// Home
    DotNavigationBarItem(
      icon: Icon(Icons.home),
      selectedColor: Colors.purple,
    ),

    /// Likes
    DotNavigationBarItem(
      icon: Icon(Icons.collections_bookmark_outlined),
      selectedColor: Colors.purple,
    ),

    /// Search
    DotNavigationBarItem(
      icon: Icon(Icons.wallet_giftcard_outlined),
      selectedColor: Colors.purple,
    ),

    /// Profile
    DotNavigationBarItem(
      icon: Icon(Icons.person),
      selectedColor: Colors.purple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeScreenViewModel>(context);

    final Screens = [
      DateSuggestionView(),
      BookingsView(),
      GiftSuggestionView(),
      UserProfileView(),
    ];

    return Scaffold(
      extendBody: true,
      body: Screens[model.currentScreenIndex],
      bottomNavigationBar: DotNavigationBar(
        marginR: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        borderRadius: 10,
        currentIndex: model.currentScreenIndex,
        onTap: model.updateIndex,
        dotIndicatorColor: Colors.purple,
        curve: Curves.linear,
        duration: const Duration(milliseconds: 5),
        boxShadow: const [
          BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 5))
        ],
        items: navbarItems,
      ),
    );
  }
}
