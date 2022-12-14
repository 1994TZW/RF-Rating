import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../helper/localization/app_translations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/language_model.dart';
import '../widget/local_text.dart';

Future<void> showMsgDialog(
    BuildContext context, String title, String msg) async {
  await showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text(
          title,
          style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
        ),
        content: Text(
          msg,
          style: const TextStyle(color: Colors.grey),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              "Close",
              style: TextStyle(color: Colors.black),
            ),
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
                          ? const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold)
                          : const TextStyle(
                              fontFamily: 'Pyidaungsu',
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
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
