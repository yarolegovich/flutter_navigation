

import 'package:flutter_navigation/common/model.dart';
import 'package:flutter_navigation/widget/design.dart';

abstract class LanguagesPageListener<T extends StatefulWidget> implements State<T> {

  void onLanguagesSelected(List<LanguageModel> languages);

}