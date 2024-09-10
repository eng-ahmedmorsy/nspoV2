import 'package:nspo/Core/servies/sharedPerf.dart';

class CheckLogin {
  static Future<bool> isLoggedIn() async {
    Map? data = await SharedPreferencesService.retrieveMap('infoEmployee');

    return data!= null;
  }
}
