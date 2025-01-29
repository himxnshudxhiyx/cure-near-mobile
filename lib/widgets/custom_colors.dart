import 'dart:ui';

class CustomColors {
  static Color appMainColor = HexColor('#A4CFC3');
  static Color containerBorderColor = HexColor('#93C19E');
  static Color fontColor = HexColor('#1C2A3A');
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
