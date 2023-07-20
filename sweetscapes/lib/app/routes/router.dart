import 'package:auto_route/auto_route.dart';
import 'package:sweetscapes/app/routes/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.custom(
    transitionsBuilder: TransitionsBuilders.noTransition,
  );

  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(page: SplashViewRoute.page, path: '/'),
        AutoRoute(page: HomeScreenRoute.page),
        AutoRoute(page: BookingsViewRoute.page),
        AutoRoute(page: DateSuggestionViewRoute.page),
        AutoRoute(page: GiftSuggestionViewRoute.page),
        AutoRoute(page: LoginViewRoute.page),
        AutoRoute(page: SetUpDetailsViewRoute.page),
        AutoRoute(page: UpdateTagsViewRoute.page),
        AutoRoute(page: UserProfileViewRoute.page),
        AutoRoute(page: DateDetailsViewRoute.page),
        AutoRoute(page: IntroScreen1Route.page),
        AutoRoute(page: IntroScreen2Route.page),
        AutoRoute(page: IntroScreen3Route.page),
        AutoRoute(page: VerifyEmailViewRoute.page),
        AutoRoute(page: VerifyOTPViewRoute.page),
      ];
}
