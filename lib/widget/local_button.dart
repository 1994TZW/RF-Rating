import 'package:flutter/material.dart';

import '../helper/theme.dart';
import 'local_text.dart';

class LocalButton extends StatefulWidget {
  final String textKey;
  final GestureTapCallback? onTap;
  final Color? color;
  final IconData? iconData;
  final double width;

  const LocalButton(
      {Key? key,
      required this.textKey,
      this.onTap,
      this.color = primaryColor,
      this.width = 250,
      this.iconData})
      : super(key: key);

  @override
  State<LocalButton> createState() => _LocalButtonState();
}

class _LocalButtonState extends State<LocalButton> {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Center(
            child: SizedBox(
          width: widget.width,
          height: 40,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: widget.color,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.iconData == null
                    ? Container()
                    : Icon(
                        widget.iconData,
                        color: Colors.black,
                      ),
                const SizedBox(
                  width: 15,
                ),
                LocalText(context, widget.textKey,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ],
            ),
            onPressed: () {
              if (widget.onTap != null) widget.onTap!();
            },
          ),
        )));
  }
}
