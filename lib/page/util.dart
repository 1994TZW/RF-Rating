import 'package:car_service/vo/setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:car_service/model/main_model.dart';

import '../constants.dart';
import '../helper/localization/app_translations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../helper/theme.dart';
import '../model/language_model.dart';
import '../widget/local_text.dart';

heroTransition(BuildContext context, Widget page,
    {int durationMilliSec = 1000}) {
  Navigator.of(context).pushReplacement(
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: durationMilliSec),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return Align(
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    ),
  );
}

heroTransitionPush(BuildContext context, Widget page,
    {int durationMilliSec = 300}) async {
  await Navigator.of(context).push(
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: durationMilliSec),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return Align(
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    ),
  );
}

Future<void> showMsgDialog(
    BuildContext context, String title, String msg) async {
  await showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: new Text(title),
        content: new Text(msg),
        actions: <Widget>[
          new TextButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> showConfirmDialog(
    BuildContext context, String translationKey, ok(),
    {List<String>? translationVariables}) async {
  await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Center(
            child: LocalText(
              context,
              translationKey,
              translationVariables: translationVariables,
              color: Colors.grey,
            ),
          ),
          content: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextButton(
                    child: Text(
                      AppTranslations.of(context).text('btn.cancel'),
                      style: Provider.of<LanguageModel>(context).isEng
                          ? const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                          : const TextStyle(fontFamily: 'Pyidaungsu',color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                TextButton(
                    // color: primaryColor,
                    child: Text(AppTranslations.of(context).text('btn.ok'),
                        style: Provider.of<LanguageModel>(context).isEng
                            ? const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)
                            : const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pyidaungsu')),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await ok();
                    })
              ],
            ),
          ),
        );
      });
}

call(BuildContext context, String phone) {
  showConfirmDialog(context, "contact.phone.confim", () => launch("tel:$phone"),
      translationVariables: ["$phone"]);
}

String getLocalString(BuildContext context, String key,
    {List<String>? translationVaraibles}) {
  return AppTranslations.of(context)
      .text(key, translationVariables: translationVaraibles);
}



double scale(double input, double min, double max, double inMin, double inMax) {
  double percent = (input - inMin) / (inMax - inMin);
  return percent * (max - min) + min;
}

getInt(dynamic val) {
  return (val is int)
      ? val
      : (val is String)
          ? int.tryParse(val)
          : 0;
}

getDouble(dynamic val) {
  return (val is double)
      ? val
      : (val is int)
          ? double.tryParse(val.toString())
          : (val is String)
              ? double.tryParse(val)
              : 0.0;
}

getBool(dynamic val) {
  return (val is bool)
      ? val
      : (val is String)
          ? (val == 'true')
          : false;
}

var numberFormatter = NumberFormat("#,###");



var dateFormatter = DateFormat('dd MMM yyyy');
String date(DateTime? dateTime) {
  if (dateTime == null) return "";
  return dateFormatter.format(dateTime);
}
