import 'package:nspo/Core/extension/MediaQueryValues.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../ViewModel/RegAttendanceOfflineCubit.dart';

class TimeAndDate extends StatelessWidget {
  const TimeAndDate({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<RegAttendanceOfflineCubit>();
    return Column(
      children: [
        BlocBuilder<RegAttendanceOfflineCubit, RegAttendanceOfflineState>(
          builder: (context, state) {
            return Text(
              cubit.timeString,
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
              fontSize: context.getResponsiveFontSize(25),
              fontWeight: FontWeight.w400,
            )),
      ],
    );
  }
}
