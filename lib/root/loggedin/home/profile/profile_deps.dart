
import 'package:flutter/widgets.dart';

abstract class OnLoggedOutListener<T extends StatefulWidget> implements State<T> {

  void onLoggedOut();

}

abstract class OnEditProfileClickedListener<T extends StatefulWidget> implements State<T> {

  void onEditProfileClicked();

}