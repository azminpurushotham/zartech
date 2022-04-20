import 'package:zartech/core/resposive/device_screen_type.dart';
import 'package:flutter/material.dart';

class SizingInformation {
  final Orientation? orientation;
  final DeviceScreenType? deviceScreenType;
  final Size? screenSize;
  final Size? localWidgetSize;

  SizingInformation(
      {this.orientation,
      this.deviceScreenType,
      this.screenSize,
      this.localWidgetSize});

  @override
  String toString() {
    return 'SizingInformation{ \n\n\n orientation: $orientation, \n\n\n deviceScreenType: $deviceScreenType, \n\n\n screenSize: $screenSize, \n\n\n localWidgetSize: $localWidgetSize}';
  }

/*  @override
  String toString() {
    return 'Orientation:$orientation DeviceScreenType:$deviceScreenType ScreenSize:$screenSize LocaleWidgetSize:$localWidgetSize';
  }*/

}
