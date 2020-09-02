

import 'package:flutter_navigation/common/model.dart';
import 'package:flutter_navigation/root/profile/languages/profile_languages_page_deps.dart';
import 'package:flutter_navigation/widget/design.dart';

class SelectLanguagePage extends StatefulWidget {

  final String actionText;
  final List<LanguageModel> initialSelection;
  final int progress;
  final int maxProgress;

  SelectLanguagePage(this.actionText,
      {this.progress,
        this.maxProgress,
        this.initialSelection});

  @override
  State<StatefulWidget> createState() => _SelectLanguagePageState();
}

class _SelectLanguagePageState extends State<SelectLanguagePage> {

  List<LanguageModel> _checkedLanguages;
  ValueNotifier<bool> _isContinueEnabled;

  @override
  void initState() {
    super.initState();
    _checkedLanguages = [];
    _checkedLanguages.addAll(widget.initialSelection ?? []);
    _isContinueEnabled = ValueNotifier(_checkedLanguages.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    final languages = _loadLanguages();
    return DesignCheckboxGroup(
      checkedItems: _checkedLanguages,
      onItemsUpdated: () => _isContinueEnabled.value = _checkedLanguages.isNotEmpty,
      builder: (c) =>
          DesignScaffold(
              appBarLeftButton: DesignAppBarLeftButton.BACK,
              title: 'What languages do you speak?',
              expandedTitleStyle: Design.textTitle(),
              pinnedHeader: _createProgressIfRequired(),
              bottomBar: _createPinnedContinue(),
              scrollableContentBuilder: (ctx, index) {
                if (index >= languages.length) return null;
                final model = languages[index];
                return DesignCheckboxListItem(
                    value: model,
                    title: model.name,
                    isSelected: _checkedLanguages.contains(model),
                    drawBottomDivider: index != languages.length - 1
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
        onPressed: () => _listener().onLanguagesSelected(_checkedLanguages),
        widthMode: DesignButtonWidth.MATCH_PARENT,
        isEnabled: _isContinueEnabled,
      ),
    );
  }

  List<LanguageModel> _loadLanguages() {
    return [
      LanguageModel('Elvish', 'elv'),
      LanguageModel('Klingon', 'kng'),
      LanguageModel('Dothraki', 'dtk'),
      LanguageModel('Dart', 'drt'),
      LanguageModel('Esperanto', 'esp')
    ];
  }

  LanguagesPageListener _listener() {
    return context.findAncestorStateOfType<LanguagesPageListener>();
  }
}