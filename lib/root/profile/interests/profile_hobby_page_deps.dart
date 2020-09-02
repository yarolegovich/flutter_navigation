

import 'package:flutter_navigation/common/model.dart';
import 'package:flutter_navigation/widget/design.dart';

abstract class HobbyPageListener<T extends StatefulWidget> implements State<T> {

  void onHobbiesSelected(List<Hobby> hobbies);

}