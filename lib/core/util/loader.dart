import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularLoader extends StatelessWidget {
  const CircularLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: Center(
        child: CircularProgressIndicator(
      color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
