import 'design.dart';

abstract class Design {

  static const MaterialColor colorPrimary = MaterialColor(
    0xFF0f4c81,
    <int, Color>{
      50: Color(0xFFcfdbe6),
      100: Color(0xFF9fb7cd),
      200: Color(0xFF6f94b3),
      300: Color(0xFF3f709a),
      400: Color(0xFF275e8e),
      500: Color(0xFF0f4c81),
      600: Color(0xFF0e4474),
      700: Color(0xFF0c3d67),
      800: Color(0xFF0b355a),
      900: Color(0xFF092e4d),
    },
  );

  static const MaterialColor colorNeutral = MaterialColor(
    0xFF213345,
    <int, Color>{
      100: Color(0xFFF3F5F7),
      200: Color(0xFFE9EEF2),
      300: Color(0xFFDCE3EA),
      400: Color(0xFFC2CCD6),
      500: Color(0xFF213345),
      600: Color(0xFF8294A6),
      700: Color(0xFF62788D),
      800: Color(0xFF3B5268),
      900: Color(0xFF213345),
    },
  );

  static const MaterialColor accentRed = MaterialColor(
    0xFFEC3713,
    <int, Color>{
      50: Color(0xFFFFF1F0),
      100: Color(0xFFFFF1F0),
      200: Color(0xFFFEE0DC),
      300: Color(0xFFFAAA9E),
      400: Color(0xFFF56B56),
      500: Color(0xFFEC3713),
      600: Color(0xFFCD280E),
      700: Color(0xFFB31D09),
      800: Color(0xFF931206),
      900: Color(0xFF700700),
    },
  );

  static final colorWhite = Colors.white;

  static final fontColorHighEmp = colorNeutral.shade900;
  static final fontColorMediumEmp = colorNeutral.shade700;
  static final fontColorWhite = colorWhite.withOpacity(0.92);

  static TextStyle textHeadline() {
    return TextStyle(
        color: fontColorHighEmp,
        fontSize: 24,
        height: 1.25,
        fontWeight: FontWeight.w500
    );
  }

  static TextStyle textTitle({Color color}) {
    return TextStyle(
        color: toTextColor(color, true),
        fontSize: 36,
        height: 1.11,
        fontWeight: _toFontWeight(true)
    );
  }

  static TextStyle textBodyBold({Color color}) => textBody(
      color: color,
      bold: true
  );

  static TextStyle textBody({Color color, bool bold = false}) {
    return TextStyle(
        color: toTextColor(color, true),
        fontSize: 16,
        height: 1.37,
        fontWeight: _toFontWeight(bold)
    );
  }

  static TextStyle textBodyLarge({Color color, bold = false, isEnabled = true}) {
    return TextStyle(
        color: toTextColor(color, isEnabled),
        fontSize: 18,
        height: 1.33,
        fontWeight: _toFontWeight(bold)
    );
  }

  static TextStyle textCaption({Color color, bold = false}) {
    return TextStyle(
        color: toTextColor(color, true),
        fontSize: 14,
        height: 1.29,
        letterSpacing: 0.02,
        fontWeight: _toFontWeight(bold)
    );
  }

  static Color toTextColor(Color textColor, isEnabled) {
    final color = textColor ?? fontColorHighEmp;
    return isEnabled ? color : color.withOpacity(0.44);
  }

  static FontWeight _toFontWeight(bool isBold) {
    return isBold ? FontWeight.w500 : FontWeight.normal;
  }
}