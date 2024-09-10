import 'package:nspo/Core/servies/remoteConfig.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UpdateApp {


  static Future<String> getVersionApp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;

    return version;
  }
  CheckVersion() async {
    String  Version = RemoteConfigService.instance.version;
    String versionApp = await getVersionApp();
    if (versionApp != Version) {
      return true;
    } else {
      return false;
    }
  }


}