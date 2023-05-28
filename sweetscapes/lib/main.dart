import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetscapes/view/date%20suggestions/date_suggestion_viewmodel.dart';
import 'package:sweetscapes/view_model/onboarding/auth_view_model.dart';
import 'package:sweetscapes/view_model/onboarding/updateTags_viewmodel.dart';
import 'package:sweetscapes/view_model/home_screen_view_model.dart';
import 'package:sweetscapes/view_model/user_view_model.dart';

import 'app/routes/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => HomeScreenViewModel()),
        ChangeNotifierProvider(create: (_) => UpdateTagsViewModel()),
        ChangeNotifierProvider(create: (_) => DateSuggestionViewModel()),
      ],
      child: MaterialApp.router(
      title: 'SweetScapes',
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.config(),
      // initialRoute: RoutesName.splash,
      // onGenerateRoute: Routes.generateRoute,
    ),
    );
  }
}
