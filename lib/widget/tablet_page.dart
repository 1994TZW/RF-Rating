import 'package:flutter/material.dart';

class TabletPage extends StatelessWidget {
  final Widget leftWidget;
  final Widget rightWidget;

  const TabletPage(
      {Key? key, required this.leftWidget, required this.rightWidget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(flex: 4, child: leftWidget),
        Container(
            width: 1, height: double.maxFinite, color: Colors.grey.shade300),
        Flexible(flex: 6, child: rightWidget),
      ],
    );
  }
}
