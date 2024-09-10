import 'package:nspo/Core/Widgets/loading.dart';
import 'package:nspo/Core/Widgets/my_snackBar.dart';
import 'package:nspo/Core/extension/MediaQueryValues.dart';
import 'package:nspo/Feauters/RegAttendanceOffline/persentation/Views/widgets/toogle_btn.dart';
import 'package:nspo/Feauters/RegAttendanceOffline/persentation/Views/widgets/BtnAttendance.dart';
import 'package:nspo/Core/Widgets/Dailog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/servies/ErrorLocateLocation.dart';
import '../ViewModel/RegAttendanceOfflineCubit.dart';
import 'widgets/AttenadnceDate.dart';
import 'widgets/TimeAndDATE.dart';

class RegAttendanceOfflineView extends StatefulWidget {
  const RegAttendanceOfflineView({super.key, });

  @override
  State<RegAttendanceOfflineView> createState() => _RegAttendanceOfflineViewState();
}

class _RegAttendanceOfflineViewState extends State<RegAttendanceOfflineView> {
  @override
  void initState() {
    context.read<RegAttendanceOfflineCubit>().handelTime();
    context.read<RegAttendanceOfflineCubit>().getAttendanceDataEmp();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegAttendanceOfflineCubit, RegAttendanceOfflineState >(
      listener: (context, state) {
        if (state is GetAttendanceDataEmpError) {
          if (state.message == "LogoutNow") {
            context.read<RegAttendanceOfflineCubit>().Logout(context);
          } else {
            DailogError(context,
                message: state.message,
                nameBtn: "حاول مرة اخري", onPressed: () {
              context.read<RegAttendanceOfflineCubit>().getAttendanceDataEmp();
              Navigator.pop(context);
            });
          }

          // DailogError(
          //   context,
          //   barrierDismissible: false,
          //   message: state.message,
          //   nameBtn: "تسجيل خروج",
          //   onPressed: () {
          //     context.read<MainScreenCubit>().Logout(context);
          //     Navigator.pop(context);
          //   },
          // );
        } else if (state is RegAttendanceEmpError) {
          if (!state.isLocation) {
            DailogError(context, message: state.message);
          } else {
            ShowDailogErrorLocationAndAutoTime (context, state.message);
          }
        }
        if (state is RegAttendanceEmpSuccess) {
          // DailogError(context, message: "تم تسجيل حضورك بنجاح علي هاتف ولكن لم يرسل بعد لشركة برجاء عند توافر الانترنت قم برفع حضورك في اقرب وقت");
          mySnackBar(context,seconds: 10 ,message: "تم تسجيل حضورك بنجاح علي هاتف ولكن لم يرسل بعد لشركة برجاء عند توافر الانترنت قم برفع حضورك في اقرب وقت");

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
