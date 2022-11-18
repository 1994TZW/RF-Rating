import 'package:flutter/foundation.dart';
import 'package:car_service/helper/api_helper.dart';
import 'package:car_service/vo/setting.dart';
import 'package:car_service/vo/user.dart';

import 'main_model.dart';

abstract class BaseModel extends ChangeNotifier {
  User? user;
  Setting? setting;
  late MainModel mainModel;

  void initUser(User user) async {
    this.user = user;
  }

  void privilegeChanged() {}

  void initSetting(Setting setting) async {
    this.setting = setting;
  }

  void logout() {}

// request makes http request
// if token is null
  dynamic request(
    String path,
    method, {
    dynamic payload,
    String? token,
    String? url,
  }) async {
    return await requestAPI(path, method,
        payload: payload, token: token, url: url);
  }
}
