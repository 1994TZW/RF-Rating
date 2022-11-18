
import 'package:dio/dio.dart';
import 'package:car_service/config.dart';
import 'package:car_service/vo/dev_info.dart';
import 'package:car_service/vo/status.dart';
import 'package:logging/logging.dart';

final log = Logger('requestAPI');

// request makes http request
// if token is null
Future<dynamic> requestAPI(
  String path,
  method, {
  dynamic payload,
  String? token,
  String? url,
}) async {
  DevInfo devInfo = await DevInfo.getDevInfo();

  String deviceName = "${devInfo.model}(${devInfo.id})";
  log.info("device:${devInfo.deviceID},deviceName:$deviceName");

  Map<String, dynamic> headers = {};
  if (token != null) {
    headers["Token"] = token;
  }
  headers["Device"] = "${devInfo.deviceID}:$deviceName";

  BaseOptions options = BaseOptions(
    method: method,
    baseUrl: url ?? Config.instance.apiURL,
    connectTimeout: 10000,
    receiveTimeout: 10000,
    headers: headers,
  );
  log.info("token:$token");

  log.info("baseUrl:${options.baseUrl}, path:$path, method:$method");
  log.info("payload:$payload");
  try {
    Dio dio = Dio(options);
    Response response = await dio.request(
      path,
      data: payload,
    );
    var data = Status.fromJson(response.data);
    if (data.status == 'Ok') {
      return response.data["data"];
    } else {
      throw Exception(data.message);
    }
  } catch (e) {
    log.warning("path:$path, api:$e");
    rethrow;
  }
}
