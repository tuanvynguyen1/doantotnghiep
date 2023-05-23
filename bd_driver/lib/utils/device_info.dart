import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo{
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static Future<String?> getDeviceName() async{
    if(Platform.isAndroid){
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      return androidInfo.model;

    }
    else{
      IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      return iosDeviceInfo.utsname.machine;
    }
  }
}