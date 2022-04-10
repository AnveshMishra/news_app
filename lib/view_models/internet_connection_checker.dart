
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectionCheckerProvider extends ChangeNotifier{

  InternetConnectionCheckerProvider(){
    _addInternetConnectionListener();
  }

  var isDeviceConnected = true;

  _addInternetConnectionListener(){
    var listener = InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          isDeviceConnected = true;
          notifyListeners();
          break;
        case InternetConnectionStatus.disconnected:
          isDeviceConnected = false;
          notifyListeners();
          break;
      }
    });
  }

}