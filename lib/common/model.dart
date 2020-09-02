

class Hobby {
  final String name;
  Hobby(this.name);

  @override
  bool operator ==(Object other) => identical(this, other) || other is Hobby && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;
}

class HobbyCategory {
  final String name;
  final List<Hobby> hobbies;

  HobbyCategory(this.name, this.hobbies);

  @override
  bool operator ==(Object other) => identical(this, other) || other is HobbyCategory && runtimeType == other.runtimeType && name == other.name && hobbies == other.hobbies;

  @override
  int get hashCode => name.hashCode ^ hobbies.hashCode;
}

class LocationModel {
  final String address;

  LocationModel(this.address);

  @override
  bool operator ==(Object other) => identical(this, other) || other is LocationModel && runtimeType == other.runtimeType && address == other.address;

  @override
  int get hashCode => address.hashCode;
}

class LanguageModel {
  final String name;
  final String languageCode;

  LanguageModel(this.name, this.languageCode);

  @override
  bool operator ==(Object other) => identical(this, other) || other is LanguageModel && runtimeType == other.runtimeType && name == other.name && languageCode == other.languageCode;

  @override
  int get hashCode => name.hashCode ^ languageCode.hashCode;
}

class User {
  final String name;
  final List<Hobby> hobbies;
  final LocationModel location;
  final List<LanguageModel> languages;

  User(this.name, this.hobbies, this.location, this.languages);

  User copy({LocationModel newLocation,
    List<Hobby> newHobbies,
    List<LanguageModel> newLanguages}) {
    return User(
        name,
        newHobbies ?? hobbies,
        newLocation ?? location,
        newLanguages ?? languages
    );
  }
}