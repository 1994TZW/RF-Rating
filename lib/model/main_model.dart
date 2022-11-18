import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:car_service/helper/network_connectivity.dart';
import 'package:car_service/helper/shared_pref.dart';
import 'package:car_service/vo/setting.dart';
import 'package:car_service/vo/user.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../constants.dart';
import 'base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainModel extends ChangeNotifier {
  List<BaseModel> models = [];

  String? messagingToken;
  User? user;
  PackageInfo? packageInfo;

  set setMessaginToken(token) {
    messagingToken = token;
  }

  Setting? setting;
  bool isLoaded = true;
  bool isOnline = false;

  MainModel() {
    NetworkConnectivity.instance.statusStream.listen((data) {
      bool _isOnline = data["isOnline"];
      if (_isOnline && !isOnline) {
        _init();
      }
      isOnline = _isOnline;
      notifyListeners();
    });
  }
  bool isLogin() {
    return user != null;
  }

  bool isCustomer() {
    return false;
  }

  StreamSubscription<User?>? userListener;

  _init() async {
    await _listenSetting();
    packageInfo = await PackageInfo.fromPlatform();

    userListener?.cancel();
    // userListener =
    //     Services.instance.authService.getUserStream().listen((_user) async {
    //   if (_user != null) {
    //     for (final m in models) {
    //       m.initUser(_user);
    //     }
    //     // call diffPrivileges if privilege changed or first time login
    //     if (user == null || _user.diffPrivileges(user!)) {
    //       for (final m in models) {
    //         m.privilegeChanged();
    //       }
    //     }
    //     if (user == null) {
    //       await uploadMsgToken();
    //     }

    //   } else {
    //     if (user != null) {
    //       for (final m in models) {
    //         m.logout();
    //       }
    //     }
    //   }
    //   user = _user;
    //   isLoaded = true;
    //   notifyListeners();
    // }) as StreamSubscription<User?>?;
  }

  void addModel(BaseModel model) {
    models.add(model);
  }

  Future<void> _listenSetting() async {
    try {
      getSettings().listen((event) { 
        setting = event;
        for (final m in models) {
          m.initSetting(event);
        }
        notifyListeners();
      });
    } finally {}
  }

  Stream<Setting> getSettings() async* {
    Stream<DocumentSnapshot> snapshot = FirebaseFirestore.instance
        .collection(config_collection)
        .doc(setting_doc_id)
        .snapshots();

    await for (var snap in snapshot) {
      Setting setting = Setting.fromMap(snap.data() as Map<String, dynamic>);
      yield setting;
    }
  }

  bool isSupport() {
    if (packageInfo == null || setting == null) return false;
    return (int.tryParse(packageInfo!.buildNumber) ?? 0) >=
        setting!.supportBuildNum;
  }

  signinWithEmail(String email, String password) {
    user = User(id: "1", email: email, password: password);
    notifyListeners();
  }
}
