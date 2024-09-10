import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Core/extension/MediaQueryValues.dart';

import '../../ViewModel/main_screen_cubit.dart';

class ToggleBtn extends StatelessWidget {
  const ToggleBtn({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<RegAttendanceOnlineCubit>();
    return BlocBuilder<RegAttendanceOnlineCubit, RegAttendanceOnlineState>(
      builder: (context, state) {
        if (cubit.attendanceData!.attendanceEmpToday!.timeIn != "--:--" &&
            cubit.attendanceData!.attendanceEmpToday!.timeOut == "--:--") {
          return Column(
            children: [
              SizedBox(
                height: context.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => cubit.toggleMiddleDay(),
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        gradient: cubit.isMiddleDay
                            ? const LinearGradient(
                                colors: [
                                  Color.fromRGBO(51, 139, 147, 1.0),
                                  Color.fromRGBO(182, 244, 146, 1.0),
                                ],
                              )
                            : null,
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(5),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "بصمة تواجد",
                          style: TextStyle(
                            fontSize: 18,
                            color:
                                cubit.isMiddleDay ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  GestureDetector(
                    onTap: () => cubit.toggleMiddleDay(),
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(5),
                        ),
                        gradient: !cubit.isMiddleDay
                            ? const LinearGradient(
                                colors: [
                                  Color.fromRGBO(182, 244, 146, 1.0),
                                  Color.fromRGBO(51, 139, 147, 1.0)
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              )
                            : null,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "الانصراف",
                          style: TextStyle(
                            fontSize: 18,
                            color:
                                cubit.isMiddleDay ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
