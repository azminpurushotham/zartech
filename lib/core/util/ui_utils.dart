import 'package:zartech/core/util/utils.dart';
import 'package:flutter/material.dart';

import '../resposive/device_screen_type.dart';

DeviceScreenType getDeviceScreenType(MediaQueryData mediaQuery){
  final String TAG = "DeviceScreenType";
  var orientation  = mediaQuery.orientation;
  double deviceWidth = 0;

  /*if(orientation==Orientation.landscape){
    deviceWidth = mediaQuery.size.height;
  }else{
    deviceWidth = mediaQuery.size.width;
  }*/

  deviceWidth = mediaQuery.size.width;

  log("Oriantation -->> $orientation",TAG);
  log("deviceWidth -->> $deviceWidth",TAG);

  if(deviceWidth>950){
    return DeviceScreenType.Desktop;
  }
  if(deviceWidth>600){
    return DeviceScreenType.Tablet;
  }

  return DeviceScreenType.Mobile;

}