import 'package:flutter/material.dart';

void DailogError(BuildContext context,
    {required String message, String? nameBtn, void Function()? onPressed,bool barrierDismissible = true}) {
  showDialog(
      context: context,
      barrierDismissible: barrierDismissible,

      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: const Text(
              "تحذير",
              style: TextStyle(color: Colors.red, fontSize: 30),
            ),
            content: Text(
              message,
              style: const TextStyle(fontSize: 20),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: onPressed ??
                    () {
                      Navigator.of(context).pop();
                    },
                child: Text(nameBtn ?? "OK"),
              ),
            ],
          ),
        );
      });
}
