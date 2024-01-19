import 'package:flutter/material.dart';

class DeviceInfo {
  static double setDeviceHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  static double setDeviceWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double setDeviceTopPadding(BuildContext context) {
    return MediaQuery.paddingOf(context).top;
  }

  static double setDeviceBottomPadding(BuildContext context) {
    return MediaQuery.paddingOf(context).bottom;
  }

  static double setDeviceLeftPadding(BuildContext context) {
    return MediaQuery.paddingOf(context).left;
  }

  static double setDeviceRightPadding(BuildContext context) {
    return MediaQuery.paddingOf(context).right;
  }
}
