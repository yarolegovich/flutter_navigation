
import 'package:flutter_navigation/base/flow_controller.dart';
import 'package:flutter_navigation/common/model.dart';
import 'package:flutter_navigation/common/user_repository.dart';
import 'package:flutter_navigation/root/loggedin/editprofile/edit/profile_edit_page.dart';
import 'package:flutter_navigation/root/loggedin/editprofile/edit/profile_edit_page_deps.dart';
import 'package:flutter_navigation/root/profile/interestcategory/profile_hobby_category_page.dart';
import 'package:flutter_navigation/root/profile/interestcategory/profile_hobby_category_page_deps.dart';
import 'package:flutter_navigation/root/profile/interests/profile_hobby_page.dart';
import 'package:flutter_navigation/root/profile/interests/profile_hobby_page_deps.dart';
import 'package:flutter_navigation/root/profile/languages/profile_languages_page.dart';
import 'package:flutter_navigation/root/profile/languages/profile_languages_page_deps.dart';
import 'package:flutter_navigation/root/profile/location/profile_location_page.dart';
import 'package:flutter_navigation/root/profile/location/profile_location_page_deps.dart';
import 'package:flutter_navigation/widget/design.dart';

class EditProfileFlowController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditProfileFlowControllerState();
}

class _EditProfileFlowControllerState extends FlowControllerState<EditProfileFlowController>
    implements
        HobbyCategoryPageListener<EditProfileFlowController>,
        HobbyPageListener<EditProfileFlowController>,
        LanguagesPageListener<EditProfileFlowController>,
        LocationPageListener<EditProfileFlowController>,
        EditProfileInteractionListener<EditProfileFlowController> {

  final UserRepository _userRepo = UserRepository.get();

  @override
  AppPage createInitialPage() => AppPage(_PAGE_EDIT, EditProfilePage());

  @override
  void onEditHobbiesClicked() {
    pushSimple(() => _createHobbyCategoryPage(), _PAGE_HOBBY_CATEGORY);
  }

  @override
  void onHobbyCategorySelected(HobbyCategory category) {
    pushSimple(() => _createHobbyPage(category), _PAGE_HOBBY);
  }

  @override
  void onEditLanguagesClicked() {
    pushSimple(() => _createLanguagesPage(), _PAGE_LANGUAGES);
  }

  @override
  void onEditLocationClicked() {
    pushSimple(() => _createLocationPage(), _PAGE_LOCATION);
  }

  @override
  void onHobbiesSelected(List<Hobby> hobbies) {
    _userRepo.updateHobbies(hobbies);
    _goBackToEdit();
  }

  @override
  void onLocationEntered(LocationModel location) {
    _userRepo.updateLocation(location);
    _goBackToEdit();
  }

  @override
  void onLanguagesSelected(List<LanguageModel> languages) {
    _userRepo.updateLanguages(languages);
    _goBackToEdit();
  }

  void _goBackToEdit() {
    popUntilFound(_PAGE_EDIT);
  }

  Widget _createHobbyCategoryPage() => SelectHobbyCategoryPage();

  Widget _createHobbyPage(HobbyCategory category) => SelectHobbyPage(
      category, _ACTION_SAVE,
      initialSelection: _userRepo.getUser().hobbies,
  );

  Widget _createLocationPage() => SelectLocationPage(
      _ACTION_SAVE,
      initialSelection: _userRepo.getUser().location,
  );

  Widget _createLanguagesPage() => SelectLanguagePage(
      _ACTION_SAVE,
      initialSelection: _userRepo.getUser().languages,
  );

  static const String _PAGE_EDIT = 'edit_profile';
  static const String _PAGE_HOBBY_CATEGORY = 'hobby_category';
  static const String _PAGE_HOBBY = 'hobby';
  static const String _PAGE_LOCATION = 'location';
  static const String _PAGE_LANGUAGES = 'languages';

  static const String _ACTION_SAVE = 'Save';
}
