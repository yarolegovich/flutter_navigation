
import 'package:flutter/material.dart';
import 'package:flutter_navigation/root/login/landing/landing_deps.dart';
import 'package:flutter_navigation/widget/design.dart';

class LandingPage extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() => LandingPageState();

}

class LandingPageState extends State<LandingPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildBackground(),
      child: SafeArea(child: DesignHorizontalMargin(_buildContent()))
    );
  }

  Decoration _buildBackground() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [Design.colorPrimary.shade600, Design.colorPrimary.shade300]
      )
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacer(),
        _createLogo(),
        Spacer(),
        _createLogInButton(),
        SizedBox(height: 24),
        _createSignUpButton(),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _createLogo() {
    return Text(
      'ownawp',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 60,
          color: Design.fontColorWhite,
          letterSpacing: -0.02,
          fontWeight: FontWeight.w600
      ),
    );
  }


  Widget _createSignUpButton() {
    return DesignSecondaryButton(
        text: 'Sign up',
        onPressed: () => _signUpListener().onSignUpClicked()
    );
  }

  Widget _createLogInButton() {
    return GestureDetector(
          onTap: () => _loggedInListener().onLogInClicked(),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: 'Already have an account? ', style: Design.textBody(color: Design.fontColorWhite)),
                TextSpan(text: 'Log in', style: Design.textBodyBold(color: Design.fontColorWhite)),
              ],
            ),
          )
    );
  }


  OnLoggedInListener _loggedInListener() {
    return context.findAncestorStateOfType<OnLoggedInListener>();
  }

  OnSignUpListener _signUpListener() {
    return context.findAncestorStateOfType<OnSignUpListener>();
  }
}