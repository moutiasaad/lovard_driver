import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:lovard_delivery_app/view/layout/driver_home_layout.dart';
import 'package:lovard_delivery_app/view/login/second_login_screen.dart';

import '../../models/register_model.dart';
import '../../shared/components/appBar/LoginAppBar.dart';
import 'first_login_screen.dart';

class LoginLayout extends StatefulWidget {
  const LoginLayout({
    super.key,
  });

  @override
  State<LoginLayout> createState() => _LoginLayoutState();
}

class _LoginLayoutState extends State<LoginLayout> {
  RegisterModel data = RegisterModel();
  PageController? signUpController = PageController(initialPage: 0);
  int index = 0;
  bool loading = false;
  double solde = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 10),
              child: index == 0 ? SizedBox(height: 30,) :loginAppBar(
                  icon: index == 0 ? CupertinoIcons.xmark : Icons.arrow_back,
                  context: context,
                  back: () {
                    if (index == 0) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DriverHomeLayout(),
                          ));
                    } else {
                      signUpController!.animateToPage(
                        signUpController!.page!.toInt() - 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                      setState(() {
                        index -= 1;
                      });
                    }
                  }),
            ),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: signUpController,
                children: [
                  FirstLoginScreen(
                    data: data,
                    forword: () {
                      signUpController!.animateToPage(
                        signUpController!.page!.toInt() + 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                      setState(() {
                        index += 1;
                      });
                    },
                  ),
                  SecondLoginScreen(
                    data: data,
                    forword: () {
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DriverHomeLayout(),));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
