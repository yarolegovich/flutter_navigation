
import 'package:flutter/widgets.dart';


abstract class LoggedOutFlowListener<T extends StatefulWidget> implements State<T> {
  void onLoggedIn();
}