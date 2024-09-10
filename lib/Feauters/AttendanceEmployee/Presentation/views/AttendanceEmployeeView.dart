import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Feauters/AttendanceEmployee/Presentation/views/widget/ListCardAttendance.dart';
import 'package:nspo/Feauters/AttendanceEmployee/Presentation/views/widget/SelectDate.dart';


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
