

import 'package:flutter_navigation/common/model.dart';
import 'package:flutter_navigation/root/profile/interestcategory/profile_hobby_category_page_deps.dart';
import 'package:flutter_navigation/widget/design.dart';

class SelectHobbyCategoryPage extends StatefulWidget {

  final int progress;
  final int maxProgress;

  SelectHobbyCategoryPage({this.progress, this.maxProgress});

  @override
  State<StatefulWidget> createState() => _SelectHobbyCategoryState();
}

class _SelectHobbyCategoryState extends State<SelectHobbyCategoryPage> {

  @override
  Widget build(BuildContext context) {
    return DesignScaffold(
        appBarLeftButton: DesignAppBarLeftButton.BACK,
        title: 'What is your passion?',
        expandedTitleStyle: Design.textTitle(),
        pinnedHeader: _createProgressIfRequired(),
        scrollableContentBuilder: (ctx, index) {
          final list = _loadCategories();
          if (index >= list.length) return null;
          final model = list[index];
          return DesignClickableListItem(
              text: model.name,
              onPressed: () => _listener().onHobbyCategorySelected(model),
              drawBottomDivider: index != list.length - 1
          );
        }
    );
  }

  Widget _createProgressIfRequired() {
    if (widget.progress == null || widget.maxProgress == null) {
      return null;
    }
    return DesignFlowProgressIndicator(
        progress: widget.progress,
        maxProgress: widget.maxProgress
    );
  }

  HobbyCategoryPageListener _listener() {
    return context.findAncestorStateOfType<HobbyCategoryPageListener>();
  }

  List<HobbyCategory> _loadCategories() {
    return [
      HobbyCategory('Collecting', _toHobbies(['Antiques', 'Comic books', 'Dolls', 'Guns', 'Stamps'])),
      HobbyCategory('Arts & Crafts', _toHobbies(['Animation', 'Calligraphy', 'Pottery', 'Fashion', 'Origami', 'Photography'])),
      HobbyCategory('Games', _toHobbies(['Arcade games', 'Cards', 'Mah jong', 'Board games', 'Computer games'])),
      HobbyCategory('Sports', _toHobbies(['Archery', 'Bowling', 'Yoga'])),
      HobbyCategory('Food & drinks', _toHobbies(['Beer tasting', 'Coffee', 'Sushi making', 'Tea drinking', 'Wine tasting'])),
      HobbyCategory('Music', _toHobbies(['Compose music', 'DJ', 'Singing', 'Banjo']))
    ];
  }

  List<Hobby> _toHobbies(List<String> names) => names.map((e) => Hobby(e)).toList(growable: false);

}