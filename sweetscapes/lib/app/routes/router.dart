import 'package:auto_route/auto_route.dart';
import 'package:sweetscapes/app/routes/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(page: SplashViewRoute.page, path: '/'),
        AutoRoute(page: HomeScreenRoute.page),
        AutoRoute(page: BookingsViewRoute.page),
        AutoRoute(page: DateSuggestionViewRoute.page),
        AutoRoute(page: GiftSuggestionViewRoute.page),
        AutoRoute(page: LoginViewRoute.page),
        AutoRoute(page: SetupPasswordViewRoute.page),
        AutoRoute(page: UpdateTagsViewRoute.page),
        AutoRoute(page: UserProfileViewRoute.page),
      ];
}
