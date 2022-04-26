import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zartech/core/util/utils.dart';
import 'package:zartech/router.gr.dart';

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

  Future<void> goHomePage(BuildContext context) async {
    print('** goHome');
    log('goHomePage', tag);
    if (count == 0) {
      Timer(const Duration(seconds: 3), () async {
        var pref = await SharedPreferences.getInstance();
        var id = pref.getString('userid') ?? '';
        if (id.isEmpty) {
          await AutoRouter.of(context).push(LoginRoute());
        } else {
          await AutoRouter.of(context).push(HomeRoute());
        }
      });
    }
    count++;
  }
}
