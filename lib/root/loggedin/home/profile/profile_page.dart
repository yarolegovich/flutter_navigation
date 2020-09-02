
import 'package:flutter_navigation/base/lifecycle_aware_state.dart';
import 'package:flutter_navigation/common/model.dart';
import 'package:flutter_navigation/common/user_repository.dart';
import 'package:flutter_navigation/root/loggedin/home/profile/profile_deps.dart';
import 'package:flutter_navigation/widget/design.dart';

class ProfilePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ProfilePageState();

}

class _ProfilePageState extends LifecycleAwareState<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: UiUtils.getWidth(context),
      child: _buildContent()
    );
  }

  Widget _buildContent() {
    final user = UserRepository.get().getUser();
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 56),
          Text(user.name, style: Design.textHeadline(), textAlign: TextAlign.center),
          Text(user.location.address,
              style: Design.textBody(color: Design.fontColorMediumEmp),
              textAlign: TextAlign.center
          ),
          _buildEditProfileButton(),
          SizedBox(height: 8),
          DesignHorizontalMargin(_buildSkillsView(user)),
          Spacer(),
          _buildLogOutButton(),
          SizedBox(height: 16)
        ]
    );
  }

  Widget _buildEditProfileButton() {
    return DesignClickableText(
        text: 'Edit profile',
        onPressed: () => _editClickListener().onEditProfileClicked(),
        textStyle: Design.textCaption(color: Design.colorPrimary.shade900, bold: true),
        padding: EdgeInsets.all(8)
    );
  }

  Widget _buildSkillsView(User user) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      children: user.hobbies
          .map((hobby) => _buildChip(hobby.name))
          .toList(),
    );
  }

  Widget _buildChip(String text) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
            color: Design.colorWhite,
            border: Border.all(color: Design.colorNeutral.shade300),
            borderRadius: BorderRadius.circular(100),
            shape: BoxShape.rectangle
        ),
        child: Text(text, style: Design.textCaption())
    );
  }

  Widget _buildLogOutButton() {
    return DesignHorizontalMargin(DesignDangerButton(
        text: 'Log out',
        onPressed: () => _logOutListener().onLoggedOut()
    ));
  }

  @override
  void onPaused() {
    //NOP
  }

  @override
  void onResumed() {
    setState(() {});
  }

  OnLoggedOutListener _logOutListener() {
    return context.findAncestorStateOfType<OnLoggedOutListener>();
  }

  OnEditProfileClickedListener _editClickListener() {
    return context.findAncestorStateOfType<OnEditProfileClickedListener>();
  }
}
