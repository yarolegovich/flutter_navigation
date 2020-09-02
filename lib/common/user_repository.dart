

import 'model.dart';

class UserRepository {

  User _user = User(_USER_NAME, [], LocationModel('Void'), []);

  User getUser() => _user;

  User createNewUser(List<Hobby> hobbies, LocationModel location, List<LanguageModel> languages) {
    _user = User(_USER_NAME, hobbies, location, languages);
    return _user;
  }

  void updateLocation(LocationModel location) {
    _user = _user.copy(newLocation: location);
  }

  void updateLanguages(List<LanguageModel> languages) {
    _user = _user.copy(newLanguages: languages);
  }

  void updateHobbies(List<Hobby> hobbies) {
    _user = _user.copy(newHobbies: hobbies);
  }

  static final UserRepository _instance = UserRepository();

  static UserRepository get() => _instance;

  static const String _USER_NAME = 'John Galt';
}