import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sweetscapes/utils/routes/routes_name.dart';
import 'package:sweetscapes/utils/utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Utils.goFlushBar('Flush', context);
            Utils.goToast('Moving On');
            // Navigator.pushNamed(context, RoutesName.home);
          },
          child: Text('Press'),
        ),
      ),
    );
  }
}
