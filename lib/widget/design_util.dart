
import 'package:flutter/rendering.dart';
import 'package:flutter_navigation/widget/design.dart';

class DesignHorizontalMargin extends StatelessWidget {

  final Widget content;

  DesignHorizontalMargin(this.content);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MARGIN),
      child: content
    );
  }

  static const MARGIN = 24.0;
}

abstract class UiUtils {

  static double getTextHeight(
      BuildContext context,
      String text,
      TextStyle style,
      {double horizontalPadding = 0, double availableWidth}) {
    MediaQueryData mqd = MediaQuery.of(context);
    var rp = RenderParagraph(
      new TextSpan(
          style: style,
          text: text,
          children: null,
          recognizer: null
      ),
      textScaleFactor: mqd.textScaleFactor,
      textDirection: TextDirection.ltr,
    );
    var width = availableWidth ?? mqd.size.width;
    var ret = rp.computeMinIntrinsicHeight(width - horizontalPadding);
    return ret;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery
        .of(context)
        .size
        .width;
  }

}