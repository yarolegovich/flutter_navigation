import 'design.dart';

const _indicatorHeight = 8.0;

class DesignFlowProgressIndicator extends StatelessWidget implements PreferredSizeWidget {

  final int progress;
  final int maxProgress;

  DesignFlowProgressIndicator({this.progress, this.maxProgress});

  @override
  Widget build(BuildContext context) {
    return _createIndicator(context);
  }

  Widget _createIndicator(BuildContext context) {
    return Container(
        width: UiUtils.getWidth(context),
        padding: _getPadding(),
        child: Row(
            children: [
              Expanded(child: _buildProgress(context)),
              SizedBox(width: 8),
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: 32),
                child: Text(
                  '$progress / $maxProgress',
                  textAlign: TextAlign.end,
                  style: Design.textCaption(),
                ),
              )
            ]
        )
    );
  }

  Widget _buildProgress(BuildContext context) {
    double progressValue = progress / maxProgress.toDouble();
    return Container(
        height: _indicatorHeight,
        width: UiUtils.getWidth(context),
        child: CustomPaint(painter: _LinearPainter(progressValue))
    );
  }

  @override
  Size get preferredSize {
    final padding = _getPadding();
    final height = _indicatorHeight + padding.top + padding.bottom;
    return Size.fromHeight(height);
  }

  EdgeInsets _getPadding() => EdgeInsets.fromLTRB(
      DesignHorizontalMargin.MARGIN, 12,
      DesignHorizontalMargin.MARGIN, 24
  );
}


class _LinearPainter extends CustomPainter {

  final Paint _paintBackground = new Paint();
  final Paint _paintLine = new Paint();

  final double _progress;

  _LinearPainter(this._progress) {
    _paintBackground.color = Design.colorNeutral.shade100;
    _paintBackground.style = PaintingStyle.fill;

    _paintLine.color = Design.colorPrimary.shade500;
    _paintLine.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final left = 2.0;
    final radius = Radius.circular(height / 2);
    final viewport = RRect.fromLTRBR(left, 0.0, width, height, radius);

    double lineWidth = viewport.width * _progress;
    RRect progressRect = RRect.fromLTRBR(left, 0.0, lineWidth, height, radius);
    Rect bgRect = Rect.fromLTRB(left, 0.0, width, height);

    canvas.save();
    canvas.clipRRect(viewport);
    canvas.drawRect(bgRect, _paintBackground);
    canvas.drawRRect(progressRect, _paintLine);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}
