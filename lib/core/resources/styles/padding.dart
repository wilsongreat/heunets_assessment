import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPadding {
  AppPadding._();

  static double horizontal = 20.w;
  static double vertical = 22.h;

  static EdgeInsetsGeometry get defaultPadding {
    return EdgeInsets.symmetric(
      horizontal: horizontal,
      vertical: vertical,
    );
  }

  static EdgeInsetsGeometry get symmetricHorizontalOnly {
    return EdgeInsets.symmetric(horizontal: horizontal);
  }

  static EdgeInsetsGeometry get symmetricVerticalOnly {
    return EdgeInsets.symmetric(vertical: vertical);
  }
}
