import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Core/Widgets/Dailog.dart';
import 'package:nspo/Core/Widgets/loading.dart';
import 'package:nspo/Feauters/AttendanceEmployee/Data/Repo/attenadanceEmployeeRepo.dart';
import 'package:nspo/Feauters/AttendanceEmployee/Data/Repo/attenadanceEmployeeRepoImpl.dart';
import 'package:nspo/Feauters/AttendanceEmployee/Presentation/ViewModel/attendance_employee_cubit.dart';
import 'package:nspo/Feauters/AttendanceEmployee/Presentation/views/widget/CardAttendance.dart';

import '../../../Data/Model/attendance.dart';

class ListCardAttendance extends StatelessWidget {
  const ListCardAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    List<AttendanceEmployee> attendanceEmployee =
        context.watch<AttendanceEmployeeCubit>().attendancesEmployee;
    return BlocConsumer<AttendanceEmployeeCubit, AttendanceEmployeeState>(
      listener: (context, state) {
        if (state is ErrorGetAttendanceState) {
          DailogError(context, message: state.error, nameBtn: "حاول مرة اخري",
              onPressed: () {
            context.read<AttendanceEmployeeCubit>().getAttendanceEmployee();
            Navigator.pop(context);
          });
        }
         if (state is ChangeMonthState|| state is ChangeYearState) {
           context.read<AttendanceEmployeeCubit>().getAttendanceEmployee();
         }
      },
      builder: (context, state) {
        if (state is LoadingGetAttendanceState) {
          return const Center(
            child: LoadingWidget(),
          );
        }

        return Expanded(
          child: ListView.builder(
              itemCount: attendanceEmployee.length,
              padding: const EdgeInsets.only(top: 20),
              itemBuilder: (context, index) {
                return CardAttendance(
                    attendanceEmployee: attendanceEmployee[index]);
              }),
        );
      },
    );
  }
}
