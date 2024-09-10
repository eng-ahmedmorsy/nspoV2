import 'dart:io';

import 'package:nspo/Core/Widgets/loading.dart';
import 'package:nspo/Core/Widgets/my_snackBar.dart';
import 'package:nspo/Core/extension/MediaQueryValues.dart';
import 'package:nspo/Feauters/RegAttendanceOnline/persentation/Views/widgets/BtnAttendance.dart';
import 'package:nspo/Core/Widgets/Dailog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Feauters/RegAttendanceOnline/persentation/Views/widgets/toogle_btn.dart';

import '../../../../Core/servies/ErrorLocateLocation.dart';
import '../ViewModel/main_screen_cubit.dart';
import 'widgets/AttenadnceDate.dart';
import 'widgets/TimeAndDATE.dart';

class RegAttendanceOnlineView extends StatefulWidget {
  const RegAttendanceOnlineView({
    super.key,
  });

  @override
  State<RegAttendanceOnlineView> createState() =>
      _RegAttendanceOnlineViewState();
}

class _RegAttendanceOnlineViewState extends State<RegAttendanceOnlineView> {
  @override
  void initState() {
    context.read<RegAttendanceOnlineCubit>().initPage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<RegAttendanceOnlineCubit>();
    return BlocConsumer<RegAttendanceOnlineCubit, RegAttendanceOnlineState>(
      listener: (context, state) {
        if (state is UpdateAppState) {
          // DailogError(context,
          //     message:
          //         "يوجد تحديث جديد لقد تم ايقاف البرنامج برجاء تحميل التحديث الجديد من خلال تواصل مع فرع نظم علي واتس اب ",
          //     barrierDismissible: false,
          //     nameBtn: "خروج من تطبيق",
          //     onPressed: () => SystemNavigator.pop());
        }
        if (state is UpdatesAvailable) {
          DailogError(context,
              message:
                  " يوجد تحديث جديد برجاء ضغط علي زر تحديث ودخول علي تطبيق مرة اخري",
              barrierDismissible: false,
              nameBtn: "تحديث",
              onPressed: () => exit(0));
        }
        if (state is GetAttendanceDataEmpError) {
          if (state.message == "LogoutNow") {
            context.read<RegAttendanceOnlineCubit>().Logout(context);
          } else {
            DailogError(context,
                message: state.message,
                nameBtn: "حاول مرة اخري", onPressed: () {
              context.read<RegAttendanceOnlineCubit>().getAttendanceDataEmp();
              Navigator.pop(context);
            });
          }
        } else if (state is RegAttendanceEmpError) {
          if (!state.isLocation) {
            DailogError(context, message: state.message);
          } else {
            ShowDailogErrorLocationAndAutoTime(context, state.message);
          }
        } else if (state is RegAttendanceEmpSuccess) {
          mySnackBar(context,
              message: "تم تسجيلك بمكان المامورية بنجاح", color: Colors.green);
        }

        if (state is GetAttendanceDataLoaded) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      },
      builder: (context, state) {
        if (state is GetAttendanceDataEmpLoading ||
            state is RegAttendanceEmpLoading) {
          return const LoadingWidget();
        }
        if (state is GetAttendanceDataEmpError) {
          return const SizedBox();
        }
        if (cubit.attendanceData == null) {
          return const SizedBox();
        }

        return Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const TimeAndDate(),

                SizedBox(
                  height: context.height * 0.01,
                ),

                const BtnAttendance(),

                const ToggleBtn(),
                const SizedBox(
                  height: 20,
                ),

                const AttendanceDateEmpView()

                //CircleAvatar
              ],
            ),
          ),
        );
      },
    );
  }
}
