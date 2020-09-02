import 'package:flutter_navigation/base/flow_controller.dart';
import 'package:flutter_navigation/root/loggedin/editprofile/profile_edit_flow_controller.dart';
import 'package:flutter_navigation/root/loggedin/home/home_page.dart';
import 'package:flutter_navigation/root/loggedin/home/profile/profile_deps.dart';
import 'package:flutter_navigation/widget/design.dart';

class LoggedInFlowController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoggedInFlowControllerState();
}

class _LoggedInFlowControllerState extends FlowControllerState<LoggedInFlowController>
  implements
    OnEditProfileClickedListener<LoggedInFlowController> {

  @override
  AppPage createInitialPage() => AppPage(_PAGE_HOME, HomePage());

  @override
  void onEditProfileClicked() {
    pushSimple(() => EditProfileFlowController(), _PAGE_EDIT_PROFILE);
  }

  static const String _PAGE_HOME = 'home';
  static const String _PAGE_EDIT_PROFILE = 'edit_profile';
}
