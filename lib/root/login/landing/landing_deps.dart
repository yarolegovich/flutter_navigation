
import 'package:flutter/widgets.dart';

abstract class OnLoggedInListener<T extends StatefulWidget> implements State<T> {
  void onLogInClicked();
}

abstract class OnSignUpListener<T extends StatefulWidget> implements State<T> {
  void onSignUpClicked();
}