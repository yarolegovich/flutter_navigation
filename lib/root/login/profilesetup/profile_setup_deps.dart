
import 'package:flutter_navigation/common/model.dart';
import 'package:flutter_navigation/widget/design.dart';

abstract class ProfileSetupFlowListener<T extends StatefulWidget> implements State<T> {
  void onProfileSetupComplete(User user);
}