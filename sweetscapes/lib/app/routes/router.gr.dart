// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:flutter/cupertino.dart' as _i18;
import 'package:flutter/material.dart' as _i19;
import 'package:sweetscapes/model/response/getAllPlans_response.dart' as _i17;
import 'package:sweetscapes/view/bookings/bookings_view.dart' as _i1;
import 'package:sweetscapes/view/date%20suggestions/date_details_view.dart'
    as _i2;
import 'package:sweetscapes/view/date%20suggestions/date_suggestion_view.dart'
    as _i3;
import 'package:sweetscapes/view/gifts/gift_suggestion_view.dart' as _i4;
import 'package:sweetscapes/view/home_screen.dart' as _i5;
import 'package:sweetscapes/view/onboarding/intro_screens/intro1.dart' as _i6;
import 'package:sweetscapes/view/onboarding/intro_screens/intro2.dart' as _i7;
import 'package:sweetscapes/view/onboarding/intro_screens/intro3.dart' as _i8;
import 'package:sweetscapes/view/onboarding/login_view.dart' as _i9;
import 'package:sweetscapes/view/onboarding/setupDetails_view.dart' as _i10;
import 'package:sweetscapes/view/onboarding/updateTags_view.dart' as _i11;
import 'package:sweetscapes/view/onboarding/verifyEmail_view.dart' as _i12;
import 'package:sweetscapes/view/onboarding/verifyOTP_view.dart' as _i13;
import 'package:sweetscapes/view/profile/user_profile_view.dart' as _i14;
import 'package:sweetscapes/view/splash_view.dart' as _i15;

abstract class $AppRouter extends _i16.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i16.PageFactory> pagesMap = {
    BookingsViewRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.BookingsView(),
      );
    },
    DateDetailsViewRoute.name: (routeData) {
      final args = routeData.argsAs<DateDetailsViewRouteArgs>();
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.DateDetailsView(args.plan),
      );
    },
    DateSuggestionViewRoute.name: (routeData) {
      final args = routeData.argsAs<DateSuggestionViewRouteArgs>(
          orElse: () => const DateSuggestionViewRouteArgs());
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.DateSuggestionView(key: args.key),
      );
    },
    GiftSuggestionViewRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.GiftSuggestionView(),
      );
    },
    HomeScreenRoute.name: (routeData) {
      final args = routeData.argsAs<HomeScreenRouteArgs>(
          orElse: () => const HomeScreenRouteArgs());
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.HomeScreen(key: args.key),
      );
    },
    IntroScreen1Route.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.IntroScreen1(),
      );
    },
    IntroScreen2Route.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.IntroScreen2(),
      );
    },
    IntroScreen3Route.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.IntroScreen3(),
      );
    },
    LoginViewRoute.name: (routeData) {
      final args = routeData.argsAs<LoginViewRouteArgs>(
          orElse: () => const LoginViewRouteArgs());
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.LoginView(key: args.key),
      );
    },
    SetUpDetailsViewRoute.name: (routeData) {
      final args = routeData.argsAs<SetUpDetailsViewRouteArgs>(
          orElse: () => const SetUpDetailsViewRouteArgs());
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.SetUpDetailsView(key: args.key),
      );
    },
    UpdateTagsViewRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateTagsViewRouteArgs>(
          orElse: () => const UpdateTagsViewRouteArgs());
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.UpdateTagsView(key: args.key),
      );
    },
    VerifyEmailViewRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyEmailViewRouteArgs>(
          orElse: () => const VerifyEmailViewRouteArgs());
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.VerifyEmailView(key: args.key),
      );
    },
    VerifyOTPViewRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyOTPViewRouteArgs>(
          orElse: () => const VerifyOTPViewRouteArgs());
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.VerifyOTPView(key: args.key),
      );
    },
    UserProfileViewRoute.name: (routeData) {
      final args = routeData.argsAs<UserProfileViewRouteArgs>(
          orElse: () => const UserProfileViewRouteArgs());
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.UserProfileView(key: args.key),
      );
    },
    SplashViewRoute.name: (routeData) {
      final args = routeData.argsAs<SplashViewRouteArgs>(
          orElse: () => const SplashViewRouteArgs());
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.SplashView(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.BookingsView]
class BookingsViewRoute extends _i16.PageRouteInfo<void> {
  const BookingsViewRoute({List<_i16.PageRouteInfo>? children})
      : super(
          BookingsViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'BookingsViewRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i2.DateDetailsView]
class DateDetailsViewRoute
    extends _i16.PageRouteInfo<DateDetailsViewRouteArgs> {
  DateDetailsViewRoute({
    required _i17.CompletedAllPlans plan,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          DateDetailsViewRoute.name,
          args: DateDetailsViewRouteArgs(plan: plan),
          initialChildren: children,
        );

  static const String name = 'DateDetailsViewRoute';

  static const _i16.PageInfo<DateDetailsViewRouteArgs> page =
      _i16.PageInfo<DateDetailsViewRouteArgs>(name);
}

class DateDetailsViewRouteArgs {
  const DateDetailsViewRouteArgs({required this.plan});

  final _i17.CompletedAllPlans plan;

  @override
  String toString() {
    return 'DateDetailsViewRouteArgs{plan: $plan}';
  }
}

/// generated route for
/// [_i3.DateSuggestionView]
class DateSuggestionViewRoute
    extends _i16.PageRouteInfo<DateSuggestionViewRouteArgs> {
  DateSuggestionViewRoute({
    _i18.Key? key,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          DateSuggestionViewRoute.name,
          args: DateSuggestionViewRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'DateSuggestionViewRoute';

  static const _i16.PageInfo<DateSuggestionViewRouteArgs> page =
      _i16.PageInfo<DateSuggestionViewRouteArgs>(name);
}

class DateSuggestionViewRouteArgs {
  const DateSuggestionViewRouteArgs({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return 'DateSuggestionViewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.GiftSuggestionView]
class GiftSuggestionViewRoute extends _i16.PageRouteInfo<void> {
  const GiftSuggestionViewRoute({List<_i16.PageRouteInfo>? children})
      : super(
          GiftSuggestionViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'GiftSuggestionViewRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i5.HomeScreen]
class HomeScreenRoute extends _i16.PageRouteInfo<HomeScreenRouteArgs> {
  HomeScreenRoute({
    _i19.Key? key,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          HomeScreenRoute.name,
          args: HomeScreenRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HomeScreenRoute';

  static const _i16.PageInfo<HomeScreenRouteArgs> page =
      _i16.PageInfo<HomeScreenRouteArgs>(name);
}

class HomeScreenRouteArgs {
  const HomeScreenRouteArgs({this.key});

  final _i19.Key? key;

  @override
  String toString() {
    return 'HomeScreenRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.IntroScreen1]
class IntroScreen1Route extends _i16.PageRouteInfo<void> {
  const IntroScreen1Route({List<_i16.PageRouteInfo>? children})
      : super(
          IntroScreen1Route.name,
          initialChildren: children,
        );

  static const String name = 'IntroScreen1Route';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i7.IntroScreen2]
class IntroScreen2Route extends _i16.PageRouteInfo<void> {
  const IntroScreen2Route({List<_i16.PageRouteInfo>? children})
      : super(
          IntroScreen2Route.name,
          initialChildren: children,
        );

  static const String name = 'IntroScreen2Route';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i8.IntroScreen3]
class IntroScreen3Route extends _i16.PageRouteInfo<void> {
  const IntroScreen3Route({List<_i16.PageRouteInfo>? children})
      : super(
          IntroScreen3Route.name,
          initialChildren: children,
        );

  static const String name = 'IntroScreen3Route';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i9.LoginView]
class LoginViewRoute extends _i16.PageRouteInfo<LoginViewRouteArgs> {
  LoginViewRoute({
    _i19.Key? key,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          LoginViewRoute.name,
          args: LoginViewRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginViewRoute';

  static const _i16.PageInfo<LoginViewRouteArgs> page =
      _i16.PageInfo<LoginViewRouteArgs>(name);
}

class LoginViewRouteArgs {
  const LoginViewRouteArgs({this.key});

  final _i19.Key? key;

  @override
  String toString() {
    return 'LoginViewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i10.SetUpDetailsView]
class SetUpDetailsViewRoute
    extends _i16.PageRouteInfo<SetUpDetailsViewRouteArgs> {
  SetUpDetailsViewRoute({
    _i19.Key? key,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          SetUpDetailsViewRoute.name,
          args: SetUpDetailsViewRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SetUpDetailsViewRoute';

  static const _i16.PageInfo<SetUpDetailsViewRouteArgs> page =
      _i16.PageInfo<SetUpDetailsViewRouteArgs>(name);
}

class SetUpDetailsViewRouteArgs {
  const SetUpDetailsViewRouteArgs({this.key});

  final _i19.Key? key;

  @override
  String toString() {
    return 'SetUpDetailsViewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i11.UpdateTagsView]
class UpdateTagsViewRoute extends _i16.PageRouteInfo<UpdateTagsViewRouteArgs> {
  UpdateTagsViewRoute({
    _i18.Key? key,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          UpdateTagsViewRoute.name,
          args: UpdateTagsViewRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'UpdateTagsViewRoute';

  static const _i16.PageInfo<UpdateTagsViewRouteArgs> page =
      _i16.PageInfo<UpdateTagsViewRouteArgs>(name);
}

class UpdateTagsViewRouteArgs {
  const UpdateTagsViewRouteArgs({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return 'UpdateTagsViewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i12.VerifyEmailView]
class VerifyEmailViewRoute
    extends _i16.PageRouteInfo<VerifyEmailViewRouteArgs> {
  VerifyEmailViewRoute({
    _i19.Key? key,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          VerifyEmailViewRoute.name,
          args: VerifyEmailViewRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'VerifyEmailViewRoute';

  static const _i16.PageInfo<VerifyEmailViewRouteArgs> page =
      _i16.PageInfo<VerifyEmailViewRouteArgs>(name);
}

class VerifyEmailViewRouteArgs {
  const VerifyEmailViewRouteArgs({this.key});

  final _i19.Key? key;

  @override
  String toString() {
    return 'VerifyEmailViewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i13.VerifyOTPView]
class VerifyOTPViewRoute extends _i16.PageRouteInfo<VerifyOTPViewRouteArgs> {
  VerifyOTPViewRoute({
    _i19.Key? key,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          VerifyOTPViewRoute.name,
          args: VerifyOTPViewRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'VerifyOTPViewRoute';

  static const _i16.PageInfo<VerifyOTPViewRouteArgs> page =
      _i16.PageInfo<VerifyOTPViewRouteArgs>(name);
}

class VerifyOTPViewRouteArgs {
  const VerifyOTPViewRouteArgs({this.key});

  final _i19.Key? key;

  @override
  String toString() {
    return 'VerifyOTPViewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i14.UserProfileView]
class UserProfileViewRoute
    extends _i16.PageRouteInfo<UserProfileViewRouteArgs> {
  UserProfileViewRoute({
    _i19.Key? key,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          UserProfileViewRoute.name,
          args: UserProfileViewRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'UserProfileViewRoute';

  static const _i16.PageInfo<UserProfileViewRouteArgs> page =
      _i16.PageInfo<UserProfileViewRouteArgs>(name);
}

class UserProfileViewRouteArgs {
  const UserProfileViewRouteArgs({this.key});

  final _i19.Key? key;

  @override
  String toString() {
    return 'UserProfileViewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i15.SplashView]
class SplashViewRoute extends _i16.PageRouteInfo<SplashViewRouteArgs> {
  SplashViewRoute({
    _i19.Key? key,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          SplashViewRoute.name,
          args: SplashViewRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SplashViewRoute';

  static const _i16.PageInfo<SplashViewRouteArgs> page =
      _i16.PageInfo<SplashViewRouteArgs>(name);
}

class SplashViewRouteArgs {
  const SplashViewRouteArgs({this.key});

  final _i19.Key? key;

  @override
  String toString() {
    return 'SplashViewRouteArgs{key: $key}';
  }
}
