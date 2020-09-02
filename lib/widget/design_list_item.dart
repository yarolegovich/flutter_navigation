

import 'design.dart';

class DesignListDivider extends BoxDecoration {

  DesignListDivider() : super(border: Border(
      bottom: BorderSide(color: Design.colorNeutral.shade200, width: 1)
  ));
}

class DesignClickableListItem extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final bool drawBottomDivider;

  DesignClickableListItem({@required this.text,
    @required this.onPressed,
    this.drawBottomDivider = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(left: DesignHorizontalMargin.MARGIN),
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: drawBottomDivider ? DesignListDivider() : null,
        child: Row(
          children: <Widget>[
            Expanded(child: Text(text, style: Design.textBodyLarge())),
            SizedBox(width: 8),
            Icon(Icons.chevron_right, color: Design.colorNeutral.shade400),
            SizedBox(width: DesignHorizontalMargin.MARGIN)
          ],
        ),
      ),
    );
  }

}

class DesignCheckboxListItem<T> extends StatelessWidget {

  final T value;
  final String title;
  final bool isSelected;
  final Function(T, bool) onSelectionChanged;
  final bool drawBottomDivider;
  final String rightValue;

  DesignCheckboxListItem({@required this.value,
    @required this.title,
    @required this.isSelected,
    this.onSelectionChanged,
    this.rightValue,
    this.drawBottomDivider = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
            margin: EdgeInsets.only(left: DesignHorizontalMargin.MARGIN),
            padding: EdgeInsets.fromLTRB(0, 12, 12, 12),
            child: _createContent(),
            decoration: drawBottomDivider ? DesignListDivider() : null
        ),
        onTap: () {
          bool newIsChecked = !isSelected;
          if (onSelectionChanged != null) {
            onSelectionChanged(value, newIsChecked);
          }
          DesignCheckboxGroupState group = context.findAncestorStateOfType<DesignCheckboxGroupState>();
          if (group != null) {
            group.onItemCheckedChanged(value, newIsChecked);
          }
        }
    );
  }

  Widget _createContent() {
    List<Widget> items = [
      Expanded(child: Text(title, style: Design.textBodyLarge()))
    ];
    if (rightValue != null) {
      items.add(Text(rightValue, style: Design.textBodyLarge()));
      items.add(SizedBox(width: 16));
    }
    items.add(Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: isSelected,
        onChanged: (o) {}
    ));
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: items
    );
  }

}