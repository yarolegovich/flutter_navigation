

import 'dart:math';

import 'package:flutter_navigation/widget/design.dart';

class AnyPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _AnyPageState();
}

class _AnyPageState extends State<AnyPage> with TickerProviderStateMixin {

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(seconds: 8),
        vsync: this
    );
    _controller.repeat(reverse: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: Center(child: Text('Use Imagination', style: Design.textBodyLarge())),
      builder: (ctx, child) {
        final angle = pi * 2 * _controller.value;
        return Transform.rotate(angle: angle, child: child);
      },
    );
  }
}