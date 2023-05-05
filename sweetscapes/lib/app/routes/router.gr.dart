// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/cupertino.dart' as _i11;
import 'package:flutter/material.dart' as _i12;
import 'package:sweetscapes/view/bookings/bookings_view.dart' as _i1;
import 'package:sweetscapes/view/date%20suggestions/date_suggestion_view.dart'
    as _i2;
import 'package:sweetscapes/view/gifts/gift_suggestion_view.dart' as _i3;
import 'package:sweetscapes/view/home_screen.dart' as _i4;
import 'package:sweetscapes/view/onboarding/login_view.dart' as _i5;
import 'package:sweetscapes/view/onboarding/setPassword_view.dart' as _i6;
import 'package:sweetscapes/view/onboarding/updateTags_view.dart' as _i7;
import 'package:sweetscapes/view/profile/user_profile_view.dart' as _i8;
import 'package:sweetscapes/view/splash_view.dart' as _i9;

abstract class $AppRouter extends _i10.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    BookingsViewRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.BookingsView(),
      );
    },
    DateSuggestionViewRoute.name: (routeData) {
      final args = routeData.argsAs<DateSuggestionViewRouteArgs>(
          orElse: () => const DateSuggestionViewRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.DateSuggestionView(key: args.key),
      );
    },
    GiftSuggestionViewRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.GiftSuggestionView(),
      );
    },
    HomeScreenRoute.name: (routeData) {
      final args = routeData.argsAs<HomeScreenRouteArgs>(
          orElse: () => const HomeScreenRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.HomeScreen(key: args.key),
      );
    },
    LoginViewRoute.name: (routeData) {
      final args = routeData.argsAs<LoginViewRouteArgs>(
          orElse: () => const LoginViewRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.LoginView(key: args.key),
      );
    },
    SetupPasswordViewRoute.name: (routeData) {
      final args = routeData.argsAs<SetupPasswordViewRouteArgs>(
          orElse: () => const SetupPasswordViewRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.SetupPasswordView(key: args.key),
      );
    },
    UpdateTagsViewRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateTagsViewRouteArgs>(
          orElse: () => const UpdateTagsViewRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.UpdateTagsView(key: args.key),
      );
    },
    UserProfileViewRoute.name: (routeData) {
      final args = routeData.argsAs<UserProfileViewRouteArgs>(
          orElse: () => const UserProfileViewRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.UserProfileView(key: args.key),
      );
    },
    SplashViewRoute.name: (routeData) {
      final args = routeData.argsAs<SplashViewRouteArgs>(
          orElse: () => const SplashViewRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.SplashView(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.BookingsView]
class BookingsViewRoute extends _i10.PageRouteInfo<void> {
  const BookingsViewRoute({List<_i10.PageRouteInfo>? children})
      : super(
          BookingsViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'BookingsViewRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i2.DateSuggestionView]
class DateSuggestionViewRoute
    extends _i10.PageRouteInfo<DateSuggestionViewRouteArgs> {
  DateSuggestionViewRoute({
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          DateSuggestionViewRoute.name,
          args: DateSuggestionViewRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'DateSuggestionViewRoute';

  static const _i10.PageInfo<DateSuggestionViewRouteArgs> page =
      _i10.PageInfo<DateSuggestionViewRouteArgs>(name);
}

class DateSuggestionViewRouteArgs {
  const DateSuggestionViewRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'DateSuggestionViewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.GiftSuggestionView]
class GiftSuggestionViewRoute extends _i10.PageRouteInfo<void> {
  const GiftSuggestionViewRoute({List<_i10.PageRouteInfo>? children})
      : super(
          GiftSuggestionViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'GiftSuggestionViewRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomeScreen]
class HomeScreenRoute extends _i10.PageRouteInfo<HomeScreenRouteArgs> {
  HomeScreenRoute({
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          HomeScreenRoute.name,
          args: HomeScreenRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HomeScreenRoute';

  static const _i10.PageInfo<HomeScreenRouteArgs> page =
      _i10.PageInfo<HomeScreenRouteArgs>(name);
}

class HomeScreenRouteArgs {
  const HomeScreenRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'HomeScreenRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.LoginView]
class LoginViewRoute extends _i10.PageRouteInfo<LoginViewRouteArgs> {
  LoginViewRoute({
    _i12.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          LoginViewRoute.name,
          args: LoginViewRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginViewRoute';

  static const _i10.PageInfo<LoginViewRouteArgs> page =
      _i10.PageInfo<LoginViewRouteArgs>(name);
}

class LoginViewRouteArgs {
  const LoginViewRouteArgs({this.key});

  final _i12.Key? key;

  @override
  String toString() {
    return 'LoginViewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.SetupPasswordView]
class SetupPasswordViewRoute
    extends _i10.PageRouteInfo<SetupPasswordViewRouteArgs> {
  SetupPasswordViewRoute({
    _i12.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          SetupPasswordViewRoute.name,
          args: SetupPasswordViewRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SetupPasswordViewRoute';

  static const _i10.PageInfo<SetupPasswordViewRouteArgs> page =
      _i10.PageInfo<SetupPasswordViewRouteArgs>(name);
}

class SetupPasswordViewRouteArgs {
  const SetupPasswordViewRouteArgs({this.key});

  final _i12.Key? key;

  @override
  String toString() {
    return 'SetupPasswordViewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.UpdateTagsView]
class UpdateTagsViewRoute extends _i10.PageRouteInfo<UpdateTagsViewRouteArgs> {
  UpdateTagsViewRoute({
    _i12.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          UpdateTagsViewRoute.name,
          args: UpdateTagsViewRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'UpdateTagsViewRoute';

  static const _i10.PageInfo<UpdateTagsViewRouteArgs> page =
      _i10.PageInfo<UpdateTagsViewRouteArgs>(name);
}

class UpdateTagsViewRouteArgs {
  const UpdateTagsViewRouteArgs({this.key});

  final _i12.Key? key;

  @override
  String toString() {
    return 'UpdateTagsViewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.UserProfileView]
class UserProfileViewRoute
    extends _i10.PageRouteInfo<UserProfileViewRouteArgs> {
  UserProfileViewRoute({
    _i12.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          UserProfileViewRoute.name,
          args: UserProfileViewRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'UserProfileViewRoute';

  static const _i10.PageInfo<UserProfileViewRouteArgs> page =
      _i10.PageInfo<UserProfileViewRouteArgs>(name);
}

class UserProfileViewRouteArgs {
  const UserProfileViewRouteArgs({this.key});

  final _i12.Key? key;

  @override
  String toString() {
    return 'UserProfileViewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i9.SplashView]
class SplashViewRoute extends _i10.PageRouteInfo<SplashViewRouteArgs> {
  SplashViewRoute({
    _i12.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          SplashViewRoute.name,
          args: SplashViewRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SplashViewRoute';

  static const _i10.PageInfo<SplashViewRouteArgs> page =
      _i10.PageInfo<SplashViewRouteArgs>(name);
}

class SplashViewRouteArgs {
  const SplashViewRouteArgs({this.key});

  final _i12.Key? key;

  @override
  String toString() {
    return 'SplashViewRouteArgs{key: $key}';
  }
}
