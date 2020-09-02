
import 'package:flutter/foundation.dart';

import 'design.dart';

enum DesignButtonWidth {
  MATCH_PARENT,
  WRAP_CONTENT
}

class DesignClickableText extends StatelessWidget {

  final String text;
  final EdgeInsets padding;
  final TextStyle textStyle;
  final VoidCallback onPressed;


  DesignClickableText({@required this.text,
    @required this.onPressed,
    this.textStyle,
    this.padding});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Container(
            padding: padding,
            child: Text(text, style: textStyle)
        )
    );
  }

}

class DesignPrimaryButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final DesignButtonWidth widthMode;
  final ValueListenable<bool> isEnabled;

  DesignPrimaryButton({@required this.text,
    @required this.onPressed,
    this.widthMode = DesignButtonWidth.MATCH_PARENT,
    this.isEnabled});

  @override
  Widget build(BuildContext context) => _DesignButton(
    text: text,
    onPressed: onPressed,
    textColor: Design.fontColorWhite,
    bgColor:  Design.colorPrimary.shade500,
    widthMode: widthMode,
    isEnabled: isEnabled,
  );

}

class DesignSecondaryButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final DesignButtonWidth widthMode;
  final ValueListenable<bool> isEnabled;

  DesignSecondaryButton({@required this.text,
    @required this.onPressed,
    this.widthMode = DesignButtonWidth.MATCH_PARENT,
    this.isEnabled});

  @override
  Widget build(BuildContext context) => _DesignButton(
    text: text,
    onPressed: onPressed,
    textColor: Design.fontColorHighEmp,
    bgColor:  Design.colorWhite,
    widthMode: widthMode,
    isEnabled: isEnabled,
  );

}

class DesignDangerButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final DesignButtonWidth widthMode;
  final ValueListenable<bool> isEnabled;

  DesignDangerButton({@required this.text,
    @required this.onPressed,
    this.widthMode = DesignButtonWidth.MATCH_PARENT,
    this.isEnabled});

  @override
  Widget build(BuildContext context) => _DesignButton(
    text: text,
    onPressed: onPressed,
    textColor: Design.fontColorWhite,
    bgColor:  Design.accentRed.shade600,
    widthMode: widthMode,
    isEnabled: isEnabled,
  );

}

class _DesignButton extends StatefulWidget {

  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final Color bgColor;
  final DesignButtonWidth widthMode;
  final ValueListenable<bool> isEnabled;

  _DesignButton({@required this.text,
    @required this.onPressed,
    @required this.bgColor,
    @required this.textColor,
    this.widthMode = DesignButtonWidth.MATCH_PARENT,
    this.isEnabled});

  @override
  State<StatefulWidget> createState() => _DesignButtonState();

}

class _DesignButtonState extends State<_DesignButton> {

  bool _isEnabled;

  @override
  void initState() {
    super.initState();
    if (widget.isEnabled != null) {
      widget.isEnabled.addListener(onEnabledStateChanged);
      _isEnabled = widget.isEnabled.value;
    } else {
      _isEnabled = true;
    }
  }

  @override
  void dispose() {
    widget.isEnabled?.removeListener(onEnabledStateChanged);
    super.dispose();
  }

  void onEnabledStateChanged() {
    setState(() {
      _isEnabled = widget.isEnabled.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget button = RaisedButton(
        child: Text(
          widget.text,
          style: Design.textBodyLarge(
              color: widget.textColor,
              isEnabled: _isEnabled,
              bold: true
          ),
        ),
        onPressed: _isEnabled ? widget.onPressed : null,
        textColor: widget.textColor,
        color: widget.bgColor,
        hoverColor: Design.colorPrimary.shade600,
        disabledColor: Design.colorPrimary.shade400,
        disabledTextColor: Design.toTextColor(widget.textColor, _isEnabled),
        disabledElevation: 0,
        elevation: 1,
        padding: EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
    );
    if (widget.widthMode != DesignButtonWidth.WRAP_CONTENT) {
      return Container(width: double.infinity, child: button);
    } else {
      return button;
    }
  }
}