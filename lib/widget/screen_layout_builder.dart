import 'package:flutter/material.dart';

import '../constants.dart';

enum RpgLayout { slim, wide, ultrawide }

typedef ScreenLayoutWidgetBuilder = Widget Function(
    BuildContext context, RpgLayout layout);
typedef ScreenBuilder = Widget Function(BuildContext context, bool isMobile);

class ScreenLayoutBuilder extends StatelessWidget {
  const ScreenLayoutBuilder({
    this.builder,
    this.screenBuilder,
    Key? key,
  })  : assert(builder != null || screenBuilder!=null),
        super(key: key);

  final ScreenLayoutWidgetBuilder? builder;
  final ScreenBuilder? screenBuilder;

  Widget _build(BuildContext context, BoxConstraints constraints) {
    var mediaWidth = MediaQuery.of(context).size.width;
    final RpgLayout layout = mediaWidth >= ultraWideLayoutThreshold
        ? RpgLayout.ultrawide
        : mediaWidth > wideLayoutThreshold
            ? RpgLayout.wide
            : RpgLayout.slim;
    return screenBuilder != null
        ? screenBuilder!(context, mediaWidth < wideLayoutThreshold)
        : builder != null
            ? builder!(context, layout)
            : Container();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: _build);
  }
}
