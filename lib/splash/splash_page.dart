import 'dart:async';

import 'package:zartech/core/util/utils.dart';
import 'package:zartech/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

final String tag = 'SplashPage';
var count = 0;

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    goHomePage(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          width: 10,
          child: Container(
              margin: const EdgeInsets.all(90),
              child:
                  Center(child: Image.asset('assets/images/logo_white.png'))),
        ),
      ),
    );
  }

  void goHomePage(BuildContext context) {
    print('** goHome');
    log('goHomePage', tag);
    if (count == 0) {
      Timer(const Duration(seconds: 3),
          () => AutoRouter.of(context).push(const LoginRoute()));
      // Timer(const Duration(seconds: 3),
      //      () => AutoRouter.of(context).push(const SignUpRoute()));
    }
    count++;
  }
}
