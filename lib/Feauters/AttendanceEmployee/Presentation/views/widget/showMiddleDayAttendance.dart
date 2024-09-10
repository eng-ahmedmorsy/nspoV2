import 'package:flutter/material.dart';

void showMiddleDayAttendance(BuildContext context,List<String> attendance) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('بصمات تواجد خلال يوم العمل'),
        content: SizedBox(
          width: double.maxFinite,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView.builder(
              itemCount: attendance.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.all(Radius.circular(5)),),
                    child: Text( "بصمة تواجد ${attendance[index]}",textAlign:TextAlign.center,style: const TextStyle(fontSize: 20,color: Colors.white,)));
              },
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}
