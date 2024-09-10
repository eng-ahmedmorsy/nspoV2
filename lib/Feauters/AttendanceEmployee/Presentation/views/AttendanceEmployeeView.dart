import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Core/extension/MediaQueryValues.dart';
import 'package:nspo/Feauters/AttendanceEmployee/Presentation/views/widget/CardAttendance.dart';
import 'package:nspo/Feauters/AttendanceEmployee/Presentation/views/widget/ListCardAttendance.dart';
import 'package:nspo/Feauters/AttendanceEmployee/Presentation/views/widget/MiddleDayCount.dart';
import 'package:nspo/Feauters/AttendanceEmployee/Presentation/views/widget/SelectDate.dart';
import 'package:nspo/Feauters/AttendanceEmployee/Presentation/views/widget/TitleDate.dart';
import 'package:nspo/Feauters/AttendanceEmployee/Presentation/views/widget/attendanceAndLeave.dart';

import '../../../../Core/Widgets/drop_down_custom.dart';
import '../../../../Core/constance/colors.dart';
import '../ViewModel/attendance_employee_cubit.dart';

class AttendanceEmployeeView extends StatefulWidget {
  const AttendanceEmployeeView({super.key});

  @override
  State<AttendanceEmployeeView> createState() => _AttendanceEmployeeViewState();
}

class _AttendanceEmployeeViewState extends State<AttendanceEmployeeView> {
  @override
  void initState() {
    context.read<AttendanceEmployeeCubit>().getMonthYear();
    context.read<AttendanceEmployeeCubit>().getAttendanceEmployee();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SelectDate(),
        SizedBox(
          height: 20,
        ),
        ListCardAttendance(),
      ],
    );
  }
}
