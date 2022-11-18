import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:car_service/helper/theme.dart';
import 'package:car_service/model/main_model.dart';

import 'package:car_service/widget/local_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../vo/setting.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String page = "/login";
  bool _loaded = false;
  bool _isSupport = true;
  bool _isOnline = true;
  late Timer timer;

  startTime() async {
    var _duration = const Duration(milliseconds: 3000);
    timer = Timer.periodic(_duration, navigationPage);
  }

  void navigationPage(Timer timer) async {
    if (_loaded && _isOnline && _isSupport) {
      timer.cancel();
      Navigator.of(context).pushReplacementNamed(page);
    }
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  void dispose() {
    super.dispose();
    if (timer.isActive) timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    MainModel mainModel = Provider.of<MainModel>(context);
    PackageInfo? packageInfo = mainModel.packageInfo;

    _isSupport = mainModel.isSupport();
    _isOnline = mainModel.isOnline;
  
    if (mainModel.isLoaded) {
      if (mainModel.isLogin()) {
        page = "/home";
      } else {
        page = "/login";
      }
      _loaded = mainModel.isLoaded && (mainModel.setting != null);
    }

    final upgradeAppButton = SizedBox(
      height: 50,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            onPrimary: primaryColor,
            backgroundColor: primaryColor,
            textStyle: const TextStyle(fontSize: 20, color: Colors.white),
            shadowColor: Colors.transparent),
        onPressed: () {
          _upgradeApp(
            context,
            int.tryParse(packageInfo?.buildNumber ?? "0") ?? 1,
          );
        },
        icon: const Icon(Feather.download, color: Colors.black),
        label: LocalText(
          context,
          "app.app_upgrade",
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: "logo",
                child: Image.asset(
                  "assets/logo.jpg",
                  height: 130,
                  filterQuality: FilterQuality.medium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Column(
            children: const <Widget>[
              Text(
                "Car Service Centre",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          _loaded && !_isOnline
              ? Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: <Widget>[
                      LocalText(context, "offline.status", color: Colors.black),
                    ],
                  ),
                )
              : Container(),
          _loaded && !_isSupport
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Version outdated, please update your app!",
                        style: TextStyle(
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    upgradeAppButton
                  ],
                )
              : Container()
        ],
      ),
    );
  }

  _upgradeApp(BuildContext context, int buildNum) async {
    MainModel mainModel = Provider.of<MainModel>(context, listen: false);
    Setting? setting = mainModel.setting;
    if (setting == null) return;
    if (setting.supportBuildNum > buildNum) {
      // ignore: deprecated_member_use
      await launch(setting.latestBuildUrl);
    }
  }
}
