import 'package:flutter/material.dart';
import '../helper/theme.dart';
import 'local_text.dart';

typedef CallBack = void Function();

class SigninButton extends StatelessWidget {
  final CallBack callBack;
  final IconData? iconData;
  final String textKey;
  final Color color;

  const SigninButton({
    Key? key,
    required this.callBack,
    required this.textKey,
    this.iconData,
    this.color = primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: () {
        callBack();
      },
      child: Container(
        height: 45,
        alignment: Alignment.center,
        child: LocalText(
          context,
          textKey,
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
      ),
    );
  }
}
