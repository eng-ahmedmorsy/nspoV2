import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notes extends StatelessWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Align(
            alignment: Alignment.centerRight,
            child: Text(" : ملاحظات",style: TextStyle(fontSize: 30, color: Colors.grey),)),

        Text("يجب تقديم طلب من قلب المشروع الجديد , لكي نستطيع اخذ الاحدثيات بدقة ",textAlign: TextAlign.center,style: TextStyle(fontSize: 20, color: Colors.grey),),
      ],
    );
  }
}
