

import 'package:flutter_navigation/root/loggedin/editprofile/edit/profile_edit_page_deps.dart';
import 'package:flutter_navigation/widget/design.dart';

class EditProfilePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _EditProfilePageState();

}

class _EditProfilePageState extends State<EditProfilePage> {

  @override
  Widget build(BuildContext context) {
    return DesignScaffold(
        appBarLeftButton: DesignAppBarLeftButton.BACK,
        title: 'Edit profile',
        expandedTitleStyle: Design.textTitle(),
        scrollableContent: _createScrollableContent(),
        addContentHorizontalMargin: false
    );
  }

  List<Widget> _createScrollableContent() {
    return [
      SizedBox(height: 16),
      _createEditable('Hobbies', () => _listener().onEditHobbiesClicked()),
      _createEditable('Location', () => _listener().onEditLocationClicked()),
      _createEditable('Languages', () => _listener().onEditLanguagesClicked(), drawDivider: false)
    ];
  }

  Widget _createEditable(String content, VoidCallback onPressed, {drawDivider: true}) {
    return DesignClickableListItem(
        text: content,
        onPressed: onPressed,
        drawBottomDivider: drawDivider
    );
  }

  EditProfileInteractionListener _listener() {
    return context.findAncestorStateOfType<EditProfileInteractionListener>();
  }
}