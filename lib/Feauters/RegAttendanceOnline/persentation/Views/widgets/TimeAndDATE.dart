import 'package:nspo/Core/extension/MediaQueryValues.dart';
import 'package:nspo/Feauters/RegAttendanceOnline/persentation/Data/Models/InfoMamouria.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../ViewModel/main_screen_cubit.dart';

class TimeAndDate extends StatelessWidget {
  const TimeAndDate({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<RegAttendanceOnlineCubit>();
    return Column(
      children: [
        BlocBuilder<RegAttendanceOnlineCubit, RegAttendanceOnlineState>(
          builder: (context, state) {
            return Text(
              cubit.timeString,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.getResponsiveFontSize(40),
                fontWeight: FontWeight.w400,
              ),
            );
          },
        ),
        Text(DateFormat.yMMMMEEEEd().format(DateTime.now()),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.getResponsiveFontSize(22),
              fontWeight: FontWeight.w400,
            )),
      ],
    );
  }
}
