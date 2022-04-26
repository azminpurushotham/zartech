import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zartech/core/util/utils.dart';

import '../router.gr.dart';

final tag = 'LoginPage';
String client_id =
    '329562797258-ilv5skmmlej6ehhkvl14u3o6o2ra79fa.apps.googleusercontent.com';
GoogleSignIn? _googleSignIn;

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

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
                      googleSignIn(context, _prefs);
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
                    onTap: () {
                      AutoRouter.of(context).push(HomeRoute());
                    },
                    child: Container(
                      width: 169,
                      height: 37,
                      decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Gilroy-Medium')),
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

  void googleSignIn(BuildContext context, Future<SharedPreferences> prefs) {
    _googleSignIn?.signIn().then((result) async {
      var prefs = await _prefs;
      log(' googleSignIn -->> ${result.toString()}', tag);
      print(' googleSignIn -->> ${result.toString()} $tag');
      await result?.authentication.then((value) {
        log(' googleSignIn accessToken -->> ${value.accessToken}', tag);
        print(' googleSignIn accessToken -->> ${value.accessToken} $tag');
        log(' googleSignIn idToken -->> ${value.idToken}', tag);
        print(' googleSignIn idToken -->> ${value.idToken} $tag');
        if ((value.idToken ?? '').isNotEmpty) {
          prefs
            ..setString('name', result?.displayName ?? 'User Name')
            ..setString('email', result?.email ?? 'User Email Id')
            ..setString('userid', result.id!)
            ..setString('image', result?.photoUrl??'');
          AutoRouter.of(context).push(HomeRoute());
        }
      }).onError((error, stackTrace) {
        print(error);
        print(stackTrace);
        showFailureDialog(
            context, 'Google Authentication failed, Please try again later');
      });
    }).onError((error, stackTrace) {
      print('ERROR');
      print(error);
      print(stackTrace);
      showFailureDialog(
          context, 'Google Authentication failed, Please try again later');
    });
  }
}

Future<void> showFailureDialog(BuildContext _context, String message) async {
  return showDialog<void>(
    context: _context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Message'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              print('close dialogue');
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
