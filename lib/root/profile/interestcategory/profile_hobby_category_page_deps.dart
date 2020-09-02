
import 'package:flutter_navigation/common/model.dart';
import 'package:flutter_navigation/widget/design.dart';

abstract class HobbyCategoryPageListener<T extends StatefulWidget> implements State<T> {

  void onHobbyCategorySelected(HobbyCategory category);

}