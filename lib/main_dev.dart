
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';
import 'config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Config(
  //     flavor: Flavor.DEV,
  //     color: Colors.blue,
     
  //     // apiURL: "http://192.168.100.7:7771",
  //     apiURL: "https://asia-northeast1-sme-dev1.cloudfunctions.net/API3",
  //     level: Level.ALL);
  runApp(App());
}
