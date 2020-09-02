
import 'package:flutter_navigation/common/model.dart';
import 'package:flutter_navigation/root/profile/interests/profile_hobby_page_deps.dart';
import 'package:flutter_navigation/widget/design.dart';

class SelectHobbyPage extends StatefulWidget {

  final HobbyCategory hobbyCategory;
  final List<Hobby> initialSelection;

  final String actionText;
  final int progress;
  final int maxProgress;

  SelectHobbyPage(this.hobbyCategory,
      this.actionText,
      {this.progress, this.maxProgress, this.initialSelection});

  @override
  State<StatefulWidget> createState() => _SelectHobbyPageState();
}

class _SelectHobbyPageState extends State<SelectHobbyPage> {

  List<Hobby> _checkedHobbies;
  ValueNotifier<bool> _isContinueEnabled;

  @override
  void initState() {
    super.initState();
    _checkedHobbies = [];
    _checkedHobbies.addAll(widget.initialSelection ?? []);
    _isContinueEnabled = ValueNotifier(_checkedHobbies.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return DesignCheckboxGroup(
      checkedItems: _checkedHobbies,
      onItemsUpdated: () => _isContinueEnabled.value = _checkedHobbies.isNotEmpty,
      builder: (c) =>
          DesignScaffold(
              appBarLeftButton: DesignAppBarLeftButton.BACK,
              title: widget.hobbyCategory.name,
              expandedTitleStyle: Design.textTitle(),
              pinnedHeader: _createProgressIfRequired(),
              bottomBar: _createPinnedContinue(),
              scrollableContentBuilder: (ctx, index) {
                final list = widget.hobbyCategory.hobbies;
                if (index >= list.length) return null;
                final model = list[index];
                return DesignCheckboxListItem(
                    value: model,
                    title: model.name,
                    isSelected: _checkedHobbies.contains(model),
                    drawBottomDivider: index != list.length - 1
                );
              }
          ),
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

  Widget _createPinnedContinue() {
    return DesignElevatedFooter(
      child: DesignPrimaryButton(
        text: widget.actionText,
        onPressed: () => _listener().onHobbiesSelected(_checkedHobbies),
        widthMode: DesignButtonWidth.MATCH_PARENT,
        isEnabled: _isContinueEnabled,
      ),
    );
  }

  HobbyPageListener _listener() {
    return context.findAncestorStateOfType<HobbyPageListener>();
  }

}