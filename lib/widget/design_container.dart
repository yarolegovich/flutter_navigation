

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_navigation/base/pop_scope.dart';

import 'design.dart';

const double _appBarHeight = 56.0;

class DesignElevatedFooter extends StatelessWidget {

  final Widget child;

  DesignElevatedFooter({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: DesignHorizontalMargin.MARGIN),
        child: child,
        decoration: BoxDecoration(
            color: Design.colorWhite,
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(36, 0, 0, 0),
                  offset: Offset(0, 6),
                  blurRadius: 24
              )
            ]
        )
    );
  }
}

class DesignScaffold extends StatefulWidget {

  final DesignAppBarLeftButton appBarLeftButton;
  final VoidCallback onBackPressed;
  final Widget pinnedHeader;

  final String title;
  final TextStyle expandedTitleStyle;

  final IndexedWidgetBuilder scrollableContentBuilder;
  final List<Widget> scrollableContent;
  final bool addContentHorizontalMargin;

  final Widget bottomBar;

  DesignScaffold({@required this.appBarLeftButton,
    this.onBackPressed,
    this.pinnedHeader,
    this.title,
    this.expandedTitleStyle,
    this.scrollableContent,
    this.scrollableContentBuilder,
    this.addContentHorizontalMargin = false,
    this.bottomBar});

  @override
  State<StatefulWidget> createState() => _DesignScaffoldState();

}

class _DesignScaffoldState extends State<DesignScaffold> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Design.colorWhite,
        body: SafeArea(child: Column(children: _createContent()))
    );
  }

  List<Widget> _createContent() {
    if (widget.bottomBar != null) {
      return [_createScrollView(), widget.bottomBar];
    } else {
      return [_createScrollView()];
    }
  }

  Widget _createScrollView() {
    return Expanded(child: CustomScrollView(
        slivers: [
          _createPinnedAppBar(),
          SliverList(delegate: SliverChildBuilderDelegate(
              _createContentBuilder()
          ))
        ]
    ));
  }

  Widget _createPinnedAppBar() {
    return SliverPersistentHeader(
        delegate: _DesignPersistentAppBar(
            contextProvider: () => context,
            appBar: _DesignAppBar(
              leftButton: widget.appBarLeftButton,
              title: widget.title,
              onBackPressed: widget.onBackPressed,
            ),
            pinnedHeader: widget.pinnedHeader,
            expandedTitleStyle: widget.expandedTitleStyle
        ),
        pinned: true,
        floating: false
    );
  }

  Function(BuildContext, int) _createContentBuilder() {
    final builder = widget.scrollableContentBuilder ?? (context, index) {
      if (index < widget.scrollableContent.length) {
        return widget.scrollableContent[index];
      } else {
        return null;
      }
    };
    if (widget.addContentHorizontalMargin) {
      return (c, i) => DesignHorizontalMargin(builder(c, i));
    } else {
      return builder;
    }
  }
}

class _DesignAppBar extends StatefulWidget {

  final DesignAppBarLeftButton leftButton;
  final VoidCallback onBackPressed;

  final String title;
  final ValueListenable<bool> titleVisibility;

  _DesignAppBar({
    this.leftButton = DesignAppBarLeftButton.NONE,
    this.title,
    this.titleVisibility,
    this.onBackPressed});

  @override
  State<StatefulWidget> createState() => _DesignAppBarState();
}

class _DesignPersistentAppBar extends SliverPersistentHeaderDelegate {

  final BuildContext Function() contextProvider;
  final _DesignAppBar appBar;
  final Widget pinnedHeader;
  final TextStyle expandedTitleStyle;

  ValueNotifier<bool> _titleVisibility = ValueNotifier(false);

  double _expandedTitleHeight;

  _DesignPersistentAppBar({@required this.contextProvider,
    @required this.appBar,
    @required this.expandedTitleStyle,
    this.pinnedHeader});

  @override
  double get maxExtent => minExtent + _getExpandedTitleHeight();

  @override
  double get minExtent => _getToolbarSize() + _getPinnedHeaderSize();

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    _titleVisibility.value = shrinkOffset >= _getExpandedTitleHeight();

    final children = [
      Positioned(top: _getToolbarSize() - shrinkOffset, child: _createTitle(context)),
      Positioned(top: 0.0, child: _createToolbar(shrinkOffset))
    ];
    if (pinnedHeader != null) {
      final pinnedExpandedTop = _getToolbarSize() + _getExpandedTitleHeight();
      final pinnedTop = max(pinnedExpandedTop - shrinkOffset, _getToolbarSize());
      children.add(Positioned(top: pinnedTop, child: pinnedHeader));
    }
    return Container(
        color: Design.colorWhite,
        child: Stack(children: children)
    );
  }

  Widget _createToolbar(double shrinkOffset) {
    return _DesignAppBar(
        leftButton: appBar.leftButton,
        title: appBar.title,
        titleVisibility: _titleVisibility,
        onBackPressed: appBar.onBackPressed
    );
  }

  Widget _createTitle(BuildContext context) {
    Text expandedTitle = Text(appBar.title, style: expandedTitleStyle);
    return Container(
        width: UiUtils.getWidth(context),
        child: DesignHorizontalMargin(expandedTitle)
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    if (oldDelegate is _DesignPersistentAppBar) {
      this._titleVisibility = oldDelegate._titleVisibility;
      return false;
    }
    return true;
  }

  double _getToolbarSize() => _appBarHeight;

  double _getPinnedHeaderSize() {
    if (pinnedHeader != null) {
      PreferredSizeWidget pinnedWidget = pinnedHeader;
      return pinnedWidget.preferredSize.height;
    }
    return 0;
  }

  double _getExpandedTitleHeight() {
    if (_expandedTitleHeight == null) {
      final context = contextProvider();
      _expandedTitleHeight = UiUtils.getTextHeight(
          context, appBar.title, expandedTitleStyle,
          horizontalPadding: DesignHorizontalMargin.MARGIN * 2
      );
    }
    return _expandedTitleHeight;
  }

}

class _DesignAppBarState extends State<_DesignAppBar> {

  bool _isTitleVisible = false;

  @override
  void initState() {
    super.initState();
    if (widget.titleVisibility != null) {
      widget.titleVisibility.addListener(onTitleVisibilityChanged);
      _isTitleVisible = widget.titleVisibility.value;
    } else {
      _isTitleVisible = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.titleVisibility != null) {
      widget.titleVisibility.removeListener(onTitleVisibilityChanged);
    }
  }

  void onTitleVisibilityChanged() {
    setState(() {
      _isTitleVisible = widget.titleVisibility.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double padding = 0;
    List<Widget> children = [];
    if (widget.leftButton != DesignAppBarLeftButton.NONE) {
      padding = 48.0;
      children.add(Align(
          alignment: Alignment.centerLeft,
          child: _buildBackButton()
      ));
    }
    if (widget.title != null) {
      children.add(Container(
          margin: EdgeInsets.symmetric(horizontal: padding),
          alignment: Alignment.center,
          child: _buildTitle(widget.title)
      ));
    }
    return SizedBox(
        width: UiUtils.getWidth(context),
        height: _appBarHeight,
        child: Material(
            color: Design.colorWhite,
            child: Stack(
                alignment: Alignment.center,
                children: children
            )
        )
    );
  }

  Widget _buildBackButton() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: IconButton(
            icon: Icon(Icons.arrow_back, size: 24.0, color: Design.colorNeutral.shade900),
            onPressed: () {
              BackPressHandler handler = context.findAncestorStateOfType<BackPressHandler>();
              handler.onBackPressed();
            }
        )
    );
  }

  Widget _buildTitle(String title) {
    return AnimatedOpacity(
        opacity: _isTitleVisible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 200),
        child: Text(
            widget.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Design.textBodyLarge(bold: true)
        )
    );
  }
}

enum DesignAppBarLeftButton {
  NONE,
  BACK
}

