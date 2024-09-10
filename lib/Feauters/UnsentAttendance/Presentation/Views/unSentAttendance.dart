import 'package:flutter/material.dart';
import 'package:nspo/Feauters/UnsentAttendance/Presentation/Views/widgets/Title.dart';
import 'package:nspo/Feauters/UnsentAttendance/Presentation/Views/widgets/list_card_unsent_Attendance.dart';

class UnsentAttendance extends StatelessWidget {
  const UnsentAttendance({super.key});

  @override
  Widget build(BuildContext context) {

    return const SingleChildScrollView(
      child: Column(
        children: [

          TitlePage(),
          SizedBox(
            height: 20,
          ),
          ListCardUnsentAttendance(),

      
        ],
      ),
    );
  }
}
