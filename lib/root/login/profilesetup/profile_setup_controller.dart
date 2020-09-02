

import 'package:flutter_navigation/base/flow_controller.dart';
import 'package:flutter_navigation/common/model.dart';
import 'package:flutter_navigation/common/user_repository.dart';
import 'package:flutter_navigation/root/login/profilesetup/profile_setup_deps.dart';
import 'package:flutter_navigation/root/profile/interestcategory/profile_hobby_category_page.dart';
import 'package:flutter_navigation/root/profile/interestcategory/profile_hobby_category_page_deps.dart';
import 'package:flutter_navigation/root/profile/interests/profile_hobby_page.dart';
import 'package:flutter_navigation/root/profile/interests/profile_hobby_page_deps.dart';
import 'package:flutter_navigation/root/profile/languages/profile_languages_page.dart';
import 'package:flutter_navigation/root/profile/languages/profile_languages_page_deps.dart';
import 'package:flutter_navigation/root/profile/location/profile_location_page.dart';
import 'package:flutter_navigation/root/profile/location/profile_location_page_deps.dart';
import 'package:flutter_navigation/widget/design.dart';

class ProfileSetupController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileSetupControllerState();
}

class _ProfileSetupControllerState extends FlowControllerState<ProfileSetupController> 
    implements 
        HobbyCategoryPageListener<ProfileSetupController>, 
        HobbyPageListener<ProfileSetupController>, 
        LanguagesPageListener<ProfileSetupController>, 
        LocationPageListener<ProfileSetupController> {
  
  List<Hobby> _selectedHobbies;
  LocationModel _enteredLocation;

  @override
  AppPage createInitialPage() => AppPage(_PAGE_HOBBY_CATEGORY, _createHobbyCategoryPage());

  @override
  void onHobbyCategorySelected(HobbyCategory category) {
    pushSimple(() => _createHobbyPage(category), _PAGE_HOBBY);
  }

  @override
  void onHobbiesSelected(List<Hobby> hobbies) {
    _selectedHobbies = hobbies;
    pushSimple(() => _createLocationPage(), _PAGE_LOCATION);
  }

  @override
  void onLocationEntered(LocationModel location) {
    _enteredLocation = location;
    pushSimple(() => _createLanguagesPage(), _PAGE_LANGUAGES);
  }

  @override
  void onLanguagesSelected(List<LanguageModel> languages) {
    final repo = UserRepository.get();
    final user = repo.createNewUser(_selectedHobbies, _enteredLocation, languages);
    _listener().onProfileSetupComplete(user);
  }

  Widget _createHobbyCategoryPage() => SelectHobbyCategoryPage(
      progress: _PROGRESS_HOBBY_CATEGORY,
      maxProgress: _MAX_PROGRESS
  );

  Widget _createHobbyPage(HobbyCategory category) => SelectHobbyPage(
      category, _ACTION_CONTINUE,
      progress: _PROGRESS_HOBBY,
      maxProgress: _MAX_PROGRESS
  );

  Widget _createLocationPage() => SelectLocationPage(
      _ACTION_CONTINUE,
      progress: _PROGRESS_LOCATION,
      maxProgress: _MAX_PROGRESS
  );

  Widget _createLanguagesPage() => SelectLanguagePage(
      _ACTION_CREATE_ACCOUNT,
      progress: _PROGRESS_LANGUAGES,
      maxProgress: _MAX_PROGRESS
  );


  ProfileSetupFlowListener _listener() {
    return context.findAncestorStateOfType<ProfileSetupFlowListener>();
  }

  static const String _PAGE_HOBBY_CATEGORY = 'hobby_category';
  static const String _PAGE_HOBBY = 'hobby';
  static const String _PAGE_LOCATION = 'location';
  static const String _PAGE_LANGUAGES = 'languages';

  static const String _ACTION_CONTINUE = 'Continue';
  static const String _ACTION_CREATE_ACCOUNT = 'Finish';

  static const int _PROGRESS_HOBBY_CATEGORY = 1;
  static const int _PROGRESS_HOBBY = 2;
  static const int _PROGRESS_LOCATION = 3;
  static const int _PROGRESS_LANGUAGES = 4;
  static const int _MAX_PROGRESS = 4;
}
