import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
class DeviceInfoService {
 static Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return  "${androidDeviceInfo.manufacturer}-${androidDeviceInfo.model}-${androidDeviceInfo.device}-${androidDeviceInfo.bootloader}-${androidDeviceInfo.id}";
    }
    return null;
  }

}