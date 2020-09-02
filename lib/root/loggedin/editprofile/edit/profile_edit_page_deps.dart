

import 'package:flutter_navigation/widget/design.dart';

abstract class EditProfileInteractionListener<T extends StatefulWidget> implements State<T> {
  void onEditHobbiesClicked();

  void onEditLanguagesClicked();

  void onEditLocationClicked();
}