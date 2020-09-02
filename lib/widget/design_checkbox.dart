import 'design.dart';

class DesignCheckboxGroup<T> extends StatefulWidget {

  final List<T> checkedItems;
  final VoidCallback onItemsUpdated;
  final WidgetBuilder builder;

  DesignCheckboxGroup({@required this.checkedItems,
    @required this.onItemsUpdated,
    @required this.builder});

  @override
  State<StatefulWidget> createState() => DesignCheckboxGroupState();

}

class DesignCheckboxGroupState<T> extends State<DesignCheckboxGroup<T>> {

  @override
  Widget build(BuildContext context) => widget.builder(context);

  void onItemCheckedChanged(T item, bool checked) {
    setState(() {
      if (checked) {
        widget.checkedItems.add(item);
      } else {
        widget.checkedItems.remove(item);
      }
      widget.onItemsUpdated();
    });
  }
}