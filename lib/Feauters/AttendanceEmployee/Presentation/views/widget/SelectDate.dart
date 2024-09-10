import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Core/extension/MediaQueryValues.dart';

import '../../../../../Core/Widgets/drop_down_custom.dart';
import '../../ViewModel/attendance_employee_cubit.dart';

class SelectDate extends StatelessWidget {
  const SelectDate({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AttendanceEmployeeCubit>();

    return         BlocBuilder<AttendanceEmployeeCubit, AttendanceEmployeeState>(
  builder: (context, state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
            width: context.width * 0.4,

            child: DroDownCustom(onTap: (String? value)=> cubit.changeMonth(value!), items: cubit.months.keys.toList(), labelDropDown: "", selectedValue: cubit.selectedMonth!, disable: false,))
        ,  const SizedBox(height: 16),
        SizedBox(
            width: context.width * 0.4,

            child: DroDownCustom(onTap: (String ? value)=> cubit.changeYear(int.parse(value!)), items: cubit.years, labelDropDown: "", selectedValue: cubit.selectedYear!, disable: false,))          ],
    );
  },
)
      ;
  }
}
