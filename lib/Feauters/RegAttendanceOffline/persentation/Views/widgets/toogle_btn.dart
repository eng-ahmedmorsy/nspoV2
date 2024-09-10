import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Core/extension/MediaQueryValues.dart';

import '../../ViewModel/RegAttendanceOfflineCubit.dart';

class ToggleBtn extends StatelessWidget {
  const ToggleBtn({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<RegAttendanceOfflineCubit>();
    return BlocBuilder<RegAttendanceOfflineCubit, RegAttendanceOfflineState>(
      builder: (context, state) {
        if (cubit.attendanceData!.timeIn != "--:--" &&
            cubit.attendanceData!.timeOut == "--:--") {
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
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromRGBO(202, 204, 227, 1),
                                  Color.fromRGBO(89, 89, 99, 1)
                                ],
                                stops: [0.112, 1.002],

                                transform: GradientRotation(109.6 *
                                    3.1415926535897932 /
                                    180),
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
                                begin: Alignment.topLeft,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color.fromRGBO(202, 204, 227, 1),
                                  Color.fromRGBO(89, 89, 99, 1)
                                ],
                                stops: [0.112, 1.002],
                                transform: GradientRotation(109.6 *
                                    3.1415926535897932 /
                                    180),
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
          return const SizedBox();
        }
      },
    );
  }
}
