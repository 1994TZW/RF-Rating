import 'package:flutter/material.dart';

import '../helper/theme.dart';
import 'local_text.dart';

class SigninInput extends StatelessWidget {
  final String? labelTextKey;

  final IconData? iconData;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final int maxLines;
  final TextInputType? textInputType;
  final bool autoFocus;
  final TextAlign textAlign;
  final bool enabled;
  final bool obscureText;
  final String? hintText;
  final bool readOnly;

  const SigninInput(
      {Key? key,
      this.labelTextKey,
      this.iconData,
      this.controller,
      this.validator,
      this.maxLines = 1,
      this.autoFocus = false,
      this.textInputType,
      this.enabled = true,
      this.textAlign = TextAlign.start,
      this.obscureText = false,
      this.readOnly = false,
      this.hintText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          LocalText(context, labelTextKey!,
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
          const SizedBox(height: 10),
          TextFormField(
              cursorColor: Colors.black54,
              controller: controller,
              obscureText: obscureText,
              autofocus: autoFocus,
              readOnly: readOnly,
              keyboardType: textInputType,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: inputBoxColor, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: inputBoxColor, width: 1.0),
                ),
                 errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: inputBoxColor, width: 1.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: inputBoxColor, width: 1.0),
                ),
                hintText: hintText ?? "",
                hintStyle: TextStyle(color: inputBoxColor)
              ),
              validator: validator)
        ],
      ),
    );
  }
}
