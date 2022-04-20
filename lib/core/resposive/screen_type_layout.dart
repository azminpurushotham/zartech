import 'package:zartech/core/resposive/responsive_builder.dart';
import 'package:flutter/material.dart';

import '../util/utils.dart';
import 'device_screen_type.dart';

final String TAG = "ScreenTypeLayout";

class ScreenTypeLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ScreenTypeLayout(
      {Key? key,
      required this.mobile,
      required this.tablet,
      required this.desktop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
        log("mobile -->> ${sizingInformation.toString()}",TAG);
        return mobile;
      } else if (sizingInformation.deviceScreenType ==
          DeviceScreenType.Tablet) {
        log("tablet -->> ${sizingInformation.toString()}",TAG);
        return tablet;
      } else {
        log("desktop -->> ${sizingInformation.toString()}",TAG);
        return desktop;
      }
    });
  }
}
