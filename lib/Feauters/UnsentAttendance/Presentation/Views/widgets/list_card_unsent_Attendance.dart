import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Core/Widgets/Dailog.dart';
import 'package:nspo/Core/Widgets/loading.dart';
import 'package:nspo/Core/Widgets/my_snackBar.dart';
import 'package:nspo/Feauters/UnsentAttendance/Presentation/ViewModel/unsent_attendance_cubit.dart';

import 'card_unSent_attendance.dart';

class ListCardUnsentAttendance extends StatefulWidget {
  const ListCardUnsentAttendance({super.key});

  @override
  State<ListCardUnsentAttendance> createState() => _ListCardUnsentAttendanceState();
}

class _ListCardUnsentAttendanceState extends State<ListCardUnsentAttendance> {
  @override
  void initState() {
    context.read<UnsentAttendanceCubit>().getUnsentAttendance();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<UnsentAttendanceCubit>();
    return BlocConsumer<UnsentAttendanceCubit, UnsentAttendanceState>(
      listener: (context, state) {
        if (state is UnsentAttendanceError) {
          DailogError(context, message: state.error);
        }
        if (state is SendAttendanceError) {
          DailogError(context, message: state.error);
        }
        if(state is SendAttendanceLoaded){
          cubit.getUnsentAttendance();
          mySnackBar(context, message: "تم ارسال البيانات الحضور بنجاح", color: Colors.green);

        }

      },
      builder: (context, state) {
        if (state is UnsentAttendanceLoading || state is SendAttendanceLoading) {
          return const Center(
            child: LoadingWidget(),
          );
        }
        return ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10),
            itemCount: cubit.allUnsentAttendance.length,
            itemBuilder: (context, index) {
              return  CardUnsentAttendance( attendanceRecord: cubit.allUnsentAttendance[index]);
            });
      },
    );
  }
}
