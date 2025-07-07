import 'package:flutter/widgets.dart';

extension SizeExtension on num {
  double get h => SizeConfig.setHeight(this);
  double get w => SizeConfig.setWidth(this);
}

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
  }

  static double setHeight(num inputHeight) {
    // 800 is the layout height used by the designer
    return (inputHeight / 800.0) * screenHeight;
  }

  static double setWidth(num inputWidth) {
    // 360 is the layout width used by the designer
    return (inputWidth / 360.0) * screenWidth;
  }
}
