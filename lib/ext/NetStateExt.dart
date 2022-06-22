import 'package:connectivity_plus/connectivity_plus.dart';

isNetConnect(bool isNet) {
  (Connectivity().checkConnectivity()).then((value) {
    if (value == ConnectivityResult.none) {
      isNet = false;
    } else {
      isNet = true;
    }
  });
}
