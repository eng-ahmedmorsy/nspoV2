import 'package:app_settings/app_settings.dart';
import 'package:datetime_setting/datetime_setting.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

ShowDailogErrorLocationAndAutoTime(context, String messageError) {
  showDialog(
      context: context,
      builder: (context) {
        if (messageError == "location_permissions_denied") {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: const Text(
                "تحذير",
                style: TextStyle(color: Colors.red, fontSize: 30),
              ),
              content: const Text(
                "لم يتم تفعيل الصلاحيات الخاصة بالموقع اضغط علي زر تفعيل بالاسفل",
                style: TextStyle(fontSize: 18),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    AppSettings.openAppSettings();
                    context.pop();
                  },
                  child: const Text(" تفعيل "),
                ),
              ],
            ),
          );
        } else if (messageError == "location_services_denied") {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: const Text(
                "تحذير",
                style: TextStyle(color: Colors.red, fontSize: 30),
              ),
              content: const Text(
                "لم يتم تفعيل خدمات الموقع اضغط علي زر تفعيل بالاسفل",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: ()async {
                    await Geolocator.openLocationSettings();},
                  child: const Text(
                    "تفعيل",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          );
        }else if (messageError == "Mock_Location") {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: const Text(
                "تحذير",
                style: TextStyle(color: Colors.red, fontSize: 30),
              ),
              content: const Text(
                "ممنوع استخدام برامج الموقع الوهمي",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text(
                    "ربنا يسامحك",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          );
        } else if (messageError == "No_Auto_Time") {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: const Text(
                "تحذير",
                style: TextStyle(color: Colors.red),
              ),
              content: const Text(
                " برجاء تفعيل الوقت والتاريخ والمنطقة الزمنية التلقائي اضغط علي زر تفعيل بالاسفل",
                style: TextStyle(fontSize: 18),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    DatetimeSetting.openSetting();

                    context.pop();
                  },
                  child: const Text(" تفعيل "),
                ),
              ],
            ),
          );
        } else {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: const Text(
                "تحذير",
                style: TextStyle(color: Colors.red),
              ),
              content:  Text(
              messageError,
                style: TextStyle(color: Colors.red),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        }
      });
}
