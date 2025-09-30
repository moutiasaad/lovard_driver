import 'package:flutter/material.dart';
import 'package:lovard_delivery_app/view/layout/driver_home_layout.dart';
import 'package:lovard_delivery_app/view/login/login_layout.dart';

import '../shared/local/secure_cash_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Future<Widget> initialData() async {
    //return const LoginLayout();
    String token = await SecureCashHelper.getToken();
    if (token.isEmpty) {
      return const LoginLayout();
    } else {
      return DriverHomeLayout();
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      initialData().then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => value),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/animation/splash1.gif',
          height: height,
          width: width,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
