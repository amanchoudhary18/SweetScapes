import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:sweetscapes/model/response/getRecentPlans_response.dart';
import 'package:sweetscapes/model/response/getUpcomingPlans_response.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/components/noPlansPlaceHolder.dart';
import 'package:sweetscapes/res/components/recentPlansTile.dart';
import 'package:sweetscapes/res/components/upcomingPlanTile.dart';
import 'package:sweetscapes/res/fonts.dart';
import 'package:sweetscapes/view/savedPlans/savedPlans_viewmodel.dart';
import 'package:sweetscapes/view_model/home_screen_view_model.dart';

@RoutePage()
class SavedPlansView extends StatelessWidget {
  const SavedPlansView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SavedPlansViewModel(),
      builder: (context, model, child) => DefaultTabController(
        length: 3,
        child: Scaffold(
          body: SafeArea(
            child: Container(
              // color: AppColor.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      child: const TabBar(
                        indicatorColor: Colors.transparent,
                        unselectedLabelColor: AppColor.grey4oo,
                        labelColor: AppColor.black,
                        tabs: [
                          Tab(
                            icon: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Recent',
                                style: TextStyle(
                                  fontFamily: AppFonts.title,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  height: 1.33,
                                  letterSpacing: -0.408,
                                ),
                              ),
                            ),
                          ),
                          Tab(
                            icon: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Saved',
                                style: TextStyle(
                                  fontFamily: AppFonts.title,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  height: 1.33,
                                  letterSpacing: -0.408,
                                ),
                              ),
                            ),
                          ),
                          Tab(
                            icon: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Upcoming',
                                style: TextStyle(
                                  fontFamily: AppFonts.title,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  height: 1.33,
                                  letterSpacing: -0.408,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: TabBarView(
                          children: [
                            (model.recentPlans.isEmpty)
                                ? FutureBuilder(
                                    future: model.fetchRecentPlans(context),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator(
                                            color: AppColor.primary,
                                            ));
                                      } else if (snapshot.hasData) {
                                        List<UserRecentPlans> plans =
                                            snapshot.data!;
                                        return RefreshIndicator(
                                          color: AppColor.primary,
                                          onRefresh: () async {
                                            List<UserRecentPlans>
                                                refreshedPlans = await model
                                                    .fetchRecentPlans(context);
                                            model.refreshRecentPlans(
                                                refreshedPlans);
                                          },
                                          child: ListView.builder(
                                            itemCount: plans.length,
                                            itemBuilder: (context, index) =>
                                                RecentPlansTile(
                                              plan: plans[index],
                                            ),
                                          ),
                                        );
                                      }
                                      return NoPlansPlaceHolder(
                                        title: 'No Recent Plans',
                                        content:
                                            'Your recently visited plans will be shown here',
                                        btnTitle: 'Explore',
                                        onPress: () {
                                          Provider.of<HomeScreenViewModel>(
                                                  context,
                                                  listen: false)
                                              .updateIndex(0);
                                        },
                                      );
                                    },
                                  )
                                : RefreshIndicator(
                                    onRefresh: () async {
                                      List<UserRecentPlans> refreshedPlans =
                                          await model.fetchRecentPlans(context);
                                      model.refreshRecentPlans(refreshedPlans);
                                    },
                                    child: ListView.builder(
                                      itemCount: model.recentPlans.length,
                                      itemBuilder: (context, index) =>
                                          RecentPlansTile(
                                        plan: model.recentPlans[index],
                                      ),
                                    ),
                                  ),
                            NoPlansPlaceHolder(
                              title: 'No Saved Plans',
                              content: 'Your saved plans will be shown here',
                              btnTitle: 'Explore',
                              onPress: () {
                                Provider.of<HomeScreenViewModel>(context,
                                        listen: false)
                                    .updateIndex(0);
                              },
                            ),
                            (model.upcomingPlans.isEmpty)
                                ? FutureBuilder(
                                    future: model.fetchUpcomingPlans(context),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator(
                                            color: AppColor.primary,
                                            ));
                                      } else if (snapshot.hasData) {
                                        List<UserUpcomingPlans> plans =
                                            snapshot.data!;
                                        return RefreshIndicator(
                                          color: AppColor.primary,
                                          onRefresh: () async {
                                            List<UserUpcomingPlans>
                                                refreshedPlans =
                                                await model.fetchUpcomingPlans(
                                                    context);
                                            model.refreshUpcomingPlans(
                                                refreshedPlans);
                                          },
                                          child: ListView.builder(
                                            itemCount: plans.length,
                                            itemBuilder: (context, index) =>
                                                UpcomingPlanTile(
                                              plan: plans[index],
                                            ),
                                          ),
                                        );
                                      }
                                      return NoPlansPlaceHolder(
                                        title: 'No Upcoming Plans',
                                        content:
                                            'Your upcoming plans will be shown here',
                                        btnTitle: 'Explore',
                                        onPress: () {
                                          Provider.of<HomeScreenViewModel>(
                                                  context,
                                                  listen: false)
                                              .updateIndex(0);
                                        },
                                      );
                                    },
                                  )
                                : RefreshIndicator(
                                    color: AppColor.primary,
                                    onRefresh: () async {
                                      List<UserUpcomingPlans> refreshedPlans =
                                          await model
                                              .fetchUpcomingPlans(context);
                                      model
                                          .refreshUpcomingPlans(refreshedPlans);
                                    },
                                    child: ListView.builder(
                                      itemCount: model.upcomingPlans.length,
                                      itemBuilder: (context, index) =>
                                          UpcomingPlanTile(
                                        plan: model.upcomingPlans[index],
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
