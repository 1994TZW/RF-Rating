import 'dart:async';

import 'package:logging/logging.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnectivity {
  final log = Logger('NetworkConnectivity');

  static final NetworkConnectivity instance = NetworkConnectivity._internal();

  NetworkConnectivity._internal() {
    _initialise();
  }

  Connectivity connectivity = Connectivity();

  final StreamController _controller = StreamController.broadcast();

  Stream get statusStream => _controller.stream;

  void _initialise() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    if (result == ConnectivityResult.none) {
      isOnline = false;
    } else {
      isOnline = true;
    }

    if (!_controller.isClosed) _controller.sink.add({"isOnline": isOnline});
  }

  void disposeStream() => _controller.close();
}
