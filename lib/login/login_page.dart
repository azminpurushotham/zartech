import 'package:zartech/core/util/utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../router.gr.dart';

final tag = 'LoginPage';
String client_id =
    '329562797258-ilv5skmmlej6ehhkvl14u3o6o2ra79fa.apps.googleusercontent.com';
GoogleSignIn? _googleSignIn;

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initSignIn();
    log('build', tag);

    return Material(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Container(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Expanded(
                        child: Image.asset(
                      'assets/images/logo_white.png',
                      width: 150,
                    )),
                  ),
                  InkWell(
                    onTap: () {
                      googleSignIn(context);
                    },
                    child: Container(
                      width: 169,
                      height: 37,
                      decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 35,
                            margin: const EdgeInsets.all(4),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                            child: Image.asset(
                              'assets/images/google_logo.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          const Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('Google',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'Gilroy-Medium')),
                            ),
                          ),
                          const SizedBox(
                            width: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: (){
                      AutoRouter.of(context).push(HomeRoute());
                    },
                    child: Container(
                      width: 169,
                      height: 37,
                      decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 35,
                            margin: const EdgeInsets.all(4),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          const Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('Phone',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'Gilroy-Medium')),
                            ),
                          ),
                          const SizedBox(
                            width: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void initSignIn() {
    try {
      _googleSignIn ??= GoogleSignIn(
        clientId: client_id,
        scopes: <String>[
          'email',
          'openid',
        ],
      );
    } catch (e) {
      print(e);
    }
  }

  void googleSignIn(BuildContext context) {
    _googleSignIn?.signIn().then((result) {
      log(' googleSignIn -->> ${result.toString()}', tag);
      result?.authentication.then((value) {
        log(' googleSignIn accessToken -->> ${value.accessToken}', tag);
        log(' googleSignIn idToken -->> ${value.idToken}', tag);
        if ((value.idToken ?? '').isNotEmpty) {}
      }).onError((error, stackTrace) {
        print(error);
        print(stackTrace);
      });
    }).onError((error, stackTrace) {
      print('ERROR');
      print(error);
      print(stackTrace);
    });
  }
}
