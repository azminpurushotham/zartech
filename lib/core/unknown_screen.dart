import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '404!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 100,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'We are sorry, the page you requested could not be found,'
              '\n Please go back to home page or contact us at suppor@mowe.com ',
              style: TextStyle(
                  color: Color(0xFFC7C7C7),
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
