
import 'design.dart';

class DesignTextfieldWidget extends StatefulWidget {

  final bool autofocus;
  final String labelText;
  final String errorText;
  final String hintText;
  final TextInputType inputType;
  final bool hideInputText;
  final Color focusedBorderColor;
  final int maxLines;
  final TextEditingController controller;
  final Function(String) onTextChanged;
  final String descriptionText;
  final String actionText;
  final VoidCallback action;

  DesignTextfieldWidget({this.autofocus = false,
    this.labelText = "",
    this.errorText = "",
    this.hintText = "",
    this.descriptionText = "",
    this.actionText = "",
    this.action,
    this.inputType,
    this.maxLines,
    this.hideInputText = false,
    this.focusedBorderColor,
    this.controller,
    this.onTextChanged});

  @override
  State<StatefulWidget> createState() {
    return DesignTextfieldState();
  }
}

class DesignTextfieldState extends State<DesignTextfieldWidget> {

  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _createTopText(),
        _createTextfield()
      ],
    );
  }

  Widget _createTextfield() {
    return TextField(
      style: Design.textBodyLarge(color: Design.fontColorHighEmp),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(16, 12, 16, 12),
          filled: !_focusNode.hasFocus,
          fillColor: Design.colorNeutral.shade100,
          border: _createInputBorder(hasBorder: false),
          focusedBorder: _createInputBorder(color: Design.colorNeutral.shade900),
          hintStyle: Design.textBodyLarge(color: Design.fontColorMediumEmp),
          hintText: widget.hintText
      ),
      focusNode: _focusNode,
      autofocus: widget.autofocus,
      keyboardType: widget.inputType,
      obscureText: widget.hideInputText,
      controller: widget.controller,
      maxLines: widget.maxLines ?? 1,
      minLines: 1,
      onChanged: widget.onTextChanged,
    );
  }

  Widget _createTopText() {
    return Padding(
        padding: EdgeInsets.only(bottom: 4),
        child: Text(
            widget.labelText,
            style: Design.textCaption(color: Design.fontColorHighEmp)
        )
    );
  }

  OutlineInputBorder _createInputBorder({color, hasBorder: true}) {
    return OutlineInputBorder(
        borderSide: hasBorder ? BorderSide(
            color: widget.focusedBorderColor ?? color,
            width: 2
        ) : BorderSide.none,
        borderRadius: BorderRadius.circular(8)
    );
  }

}