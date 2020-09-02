import 'package:flutter_navigation/base/flow_controller.dart';
import 'package:flutter_navigation/common/model.dart';
import 'package:flutter_navigation/root/login/landing/landing_deps.dart';
import 'package:flutter_navigation/root/login/landing/landing_page.dart';
import 'package:flutter_navigation/root/login/logged_out_deps.dart';
import 'package:flutter_navigation/root/login/profilesetup/profile_setup_controller.dart';
import 'package:flutter_navigation/root/login/profilesetup/profile_setup_deps.dart';
import 'package:flutter_navigation/widget/design.dart';

class LoggedOutFlowController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoggedOutFlowControllerState();
}

class _LoggedOutFlowControllerState extends FlowControllerState<LoggedOutFlowController>
    implements
        OnSignUpListener<LoggedOutFlowController>,
        ProfileSetupFlowListener<LoggedOutFlowController> {

  @override
  AppPage createInitialPage() => AppPage(_PAGE_LANDING, LandingPage());

  @override
  void onSignUpClicked() {
    pushSimple(() => ProfileSetupController(), _PAGE_PROFILE_SETUP);
  }

  @override
  void onProfileSetupComplete(User user) {
    _listener().onLoggedIn();
  }

  LoggedOutFlowListener _listener() {
    return context.findAncestorStateOfType<LoggedOutFlowListener>();
  }

  static const String _PAGE_LANDING = 'landing';
  static const String _PAGE_PROFILE_SETUP = 'profile_setup';
}
