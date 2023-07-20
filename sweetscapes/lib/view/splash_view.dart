import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:sweetscapes/view_model/services/splash_services.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServices.checkAuthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                      height: 75,
                      child: Image.asset(
                        'assets/images/logo_whitebg.png',
                        fit: BoxFit.cover,
                      ),
                    ),
              Text(
                'SweetScapes',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'GeneralSans',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                'Simplify Your Escapes',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'SpaceGrotesk',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
