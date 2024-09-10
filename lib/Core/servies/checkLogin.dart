import 'package:nspo/Core/servies/sharedPerf.dart';
import 'package:nspo/Feauters/Login/Presentation/View/loginMainView.dart';
import 'package:flutter/cupertino.dart';

class CheckLogin {
  static Future<bool> isLoggedIn() async {
    Map? data = await SharedPreferencesService.retrieveMap('infoEmployee');

    return data!= null;
  }
}
