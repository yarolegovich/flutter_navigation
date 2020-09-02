
import 'package:flutter_navigation/base/pop_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_navigation/root/login/landing/landing_deps.dart';
import 'package:flutter_navigation/root/login/logged_out_deps.dart';
import 'package:flutter_navigation/widget/design.dart';
import 'loggedin/logged_in_flow_controller.dart';
import 'loggedin/home/profile/profile_deps.dart';
import 'login/logged_out_flow_controller.dart';

class RootPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => RootState();

}

class RootState extends State<RootPage>
    with PopScopeHost<RootPage>
    implements
        OnLoggedInListener<RootPage>,
        OnLoggedOutListener<RootPage>,
        LoggedOutFlowListener<RootPage>,
        PopScopeHost<RootPage> {

  bool _isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
            body: _isLoggedIn ?
              LoggedInFlowController() :
              LoggedOutFlowController()
        )
    );
  }

  @override
  void onLoggedIn() {
    _logIn();
  }

  @override
  void onLogInClicked() {
    _logIn();
  }

  @override
  void onLoggedOut() {
    setState(() {
      _isLoggedIn = false;
    });
  }

  void _logIn() {
    setState(() {
      _isLoggedIn = true;
    });
  }

}
