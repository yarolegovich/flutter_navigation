

import 'package:flutter/widgets.dart';

abstract class BackPressHandler<T extends StatefulWidget> implements State<T> {

  void onBackPressed();

  bool handleBackPressed();

}

abstract class PopScopeHost<T extends StatefulWidget> implements State<T> {

  List<BackPressHandler> _backPressHandlers = [];

  Future<bool> onWillPop() async {
    for (int i = _backPressHandlers.length - 1; i >= 0; i--) {
      if (!_backPressHandlers[i].mounted) continue;
      if (_backPressHandlers[i].handleBackPressed()) {
        return false;
      }
    }
    return true;
  }

  void addBackPressHandler(BackPressHandler<StatefulWidget> handler) {
    _backPressHandlers.add(handler);
  }

  void removeBackPressHandler(BackPressHandler<StatefulWidget> handler) {
    _backPressHandlers.remove(handler);
  }

  static PopScopeHostSubscription subscribe(BuildContext ctx, BackPressHandler handler) {
    final host = ctx.findAncestorStateOfType<PopScopeHost>();
    host.addBackPressHandler(handler);
    return PopScopeHostSubscription(host, handler);
  }
}

class PopScopeHostSubscription {
  PopScopeHost _host;
  BackPressHandler _handler;

  PopScopeHostSubscription(this._host, this._handler);

  void dispose() {
    _host?.removeBackPressHandler(_handler);
    _host = null;
  }
}