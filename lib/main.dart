import 'package:flutter_navigation/root/root.dart';
import 'package:flutter_navigation/widget/design_styles.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FlowControllerApp());
}

class FlowControllerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Design.colorPrimary), 
        home: RootPage()
    );
  }
}
