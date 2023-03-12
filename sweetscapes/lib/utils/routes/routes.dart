import 'package:flutter/material.dart';
import 'package:sweetscapes/utils/routes/routes_arguments.dart';
import 'package:sweetscapes/utils/routes/routes_name.dart';
import 'package:sweetscapes/view/home_screen.dart';
import 'package:sweetscapes/view/onboarding/login_view.dart';
import 'package:sweetscapes/view/onboarding/setPassword_view.dart';
import 'package:sweetscapes/view/onboarding/updateTags_view.dart';
import 'package:sweetscapes/view/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginView());

      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => SplashView());

      case RoutesName.setPassword:
        return MaterialPageRoute(
            builder: (BuildContext context) => SetupPasswordView());

      case RoutesName.updateTags:
        return MaterialPageRoute(
            builder: (BuildContext context) => UpdateTagsView());

      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text('No Existing Route'),
              ),
            );
          },
        );
    }
  }
}
