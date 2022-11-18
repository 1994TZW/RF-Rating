import 'package:car_service/widget/local_text.dart';
import 'package:flutter/material.dart';
import 'package:progress/progress.dart';
import 'package:car_service/helper/theme.dart';

class RatingLocalProgress extends Progress {
  RatingLocalProgress(
      {Key? key,
      required bool inAsyncCall,
      required Widget child,
      required BuildContext context})
      : super(
            key: key,
            inAsyncCall: inAsyncCall,
            child: child,
            opacity: 0.9,
            progressIndicator: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  LocalText(context, "home.progress.instruction",
                      color: Colors.black, fontSize: 30),
                  const SizedBox(
                    height: 40,
                  ),
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ],
              ),
            ));

  @override
  Widget build(BuildContext context) {
    if (inAsyncCall) {
      // hide keyboard
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }
    return super.build(context);
  }
}
