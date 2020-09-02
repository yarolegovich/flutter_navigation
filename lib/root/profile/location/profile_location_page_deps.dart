
import 'package:flutter_navigation/common/model.dart';
import 'package:flutter_navigation/widget/design.dart';

abstract class LocationPageListener<T extends StatefulWidget> implements State<T> {

  void onLocationEntered(LocationModel location);

}