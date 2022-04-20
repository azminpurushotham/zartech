import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorInfo extends StatelessWidget {
  final String message;
  final Function onTap;

  ErrorInfo({required this.message, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
            child: InkWell(
                onTap: (){onTap();},
                child: Container(
                    child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red, fontSize: 20),
                )))));
  }

  void _test() {
    log('Test');
  }
}
