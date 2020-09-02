

import 'package:flutter_navigation/common/model.dart';
import 'package:flutter_navigation/root/profile/location/profile_location_page_deps.dart';
import 'package:flutter_navigation/widget/design.dart';

class SelectLocationPage extends StatefulWidget {

  final LocationModel initialSelection;
  final String actionText;
  final int progress;
  final int maxProgress;

  SelectLocationPage(this.actionText,
      {this.initialSelection,
        this.progress,
        this.maxProgress});

  @override
  State<StatefulWidget> createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {

  TextEditingController _controller;
  ValueNotifier<bool> _isContinueEnabled;

  @override
  void initState() {
    super.initState();
    _isContinueEnabled = ValueNotifier(widget.initialSelection?.address?.isNotEmpty ?? false);
    _controller = TextEditingController(text: widget.initialSelection?.address);
    _controller.addListener(onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void onTextChanged() {
    _isContinueEnabled.value = _controller.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return DesignScaffold(
        appBarLeftButton: DesignAppBarLeftButton.BACK,
        title: 'Where are you?',
        expandedTitleStyle: Design.textTitle(),
        pinnedHeader: _createProgressIfRequired(),
        scrollableContent: _createScrollableContent(),
        bottomBar: _createActionButton()
    );
  }

  Widget _createProgressIfRequired() {
    if (widget.progress == null || widget.maxProgress == null) {
      return null;
    }
    return DesignFlowProgressIndicator(
        progress: widget.progress,
        maxProgress: widget.maxProgress
    );
  }

  List<Widget> _createScrollableContent() {
    return [
      DesignHorizontalMargin(DesignTextfieldWidget(
          autofocus: true,
          controller: _controller
      )),
      SizedBox(height: 8),
      _createExampleText()
    ];
  }

  Widget _createExampleText() {
    return DesignHorizontalMargin(Text('e.g. Tallinn, Harjumaa',
        style: Design.textCaption(color: Design.fontColorMediumEmp)
    ));
  }

  Widget _createActionButton() {
    return DesignElevatedFooter(
        child: DesignPrimaryButton(
            text: widget.actionText,
            isEnabled: _isContinueEnabled,
            widthMode: DesignButtonWidth.MATCH_PARENT,
            onPressed: () {
              final location = LocationModel(_controller.text);
              _listener().onLocationEntered(location);
            }
        )
    );
  }

  LocationPageListener _listener() {
    return context.findAncestorStateOfType<LocationPageListener>();
  }

}