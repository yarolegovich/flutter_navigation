

import 'package:flutter_navigation/base/flow_controller.dart';
import 'package:flutter/widgets.dart';

abstract class LifecycleAwareState<T extends StatefulWidget> extends State<T> with WidgetsBindingObserver, RouteAware {

  bool _isResumed;
  bool _isAppInFg;
  bool _isCovered;

  RouteObserver _routeObserver;

  void onResumed();

  void onPaused();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _isResumed = true;
    _isAppInFg = true;
    _isCovered = false;
    onResumed();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _unsubscribeFromStates();
    _routeObserver = _flowController()?.routeObserver();
    _routeObserver?.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    super.dispose();

    _unsubscribeFromStates();
    WidgetsBinding.instance.removeObserver(this);

    if (_isResumed) {
      onPaused();
      _isResumed = false;
    }
  }

  void _unsubscribeFromStates() {
    _routeObserver?.unsubscribe(this);
    _routeObserver = null;
  }

  @override
  void didPushNext() {
    _isCovered = true;
    _notifyStateChanged();
  }

  @override
  void didPopNext() {
    _isCovered = false;
    _notifyStateChanged();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _isAppInFg = state == AppLifecycleState.resumed;
    _notifyStateChanged();
  }

  void _notifyStateChanged() {
    bool isResumed = _isAppInFg && !_isCovered && mounted;
    if (isResumed != _isResumed) {
      if (isResumed) {
        onResumed();
      } else {
        onPaused();
      }
      _isResumed = isResumed;
    }
  }

  FlowControllerState _flowController() => context.findAncestorStateOfType<FlowControllerState>();
}