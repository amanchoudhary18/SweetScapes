import 'package:flutter/material.dart';
import 'package:sweetscapes/utils/routes/routes_arguments.dart';
import 'package:sweetscapes/utils/routes/routes_name.dart';
import 'package:sweetscapes/view/home_screen.dart';
import 'package:sweetscapes/view/login_view.dart';
import 'package:sweetscapes/view/setPassword_view.dart';
import 'package:sweetscapes/view/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        final args = settings.arguments as HomeScreenArguments;
        return MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen(
                  showInitialDialog: args.showInitialDialogBox,
                ));

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginView());

      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => SplashView());

      case RoutesName.setPassword:
        return MaterialPageRoute(
            builder: (BuildContext context) => SetupPasswordView());

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
