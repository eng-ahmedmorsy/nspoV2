import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nspo/Core/servies/ErrorLocateLocation.dart';
import 'package:nspo/Core/utils/app_router.dart';

import '../../../../../Core/Widgets/icon_counter.dart';
import '../../../../../Core/servies/DbHelper.dart';
import '../../../../profile/features/presentation/views/profile_main_view.dart';
import '../../ViewModel/main_screen_cubit.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<MainScreenCubit>();
    return BlocBuilder<MainScreenCubit, MainScreenState>(
      builder: (context, state) {
        return AppBar(
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => cubit.changePage(4),
            child: IconWithCounter(
              icon: Icons.notifications,
              counter: cubit.countUnsentAttendance,
              size: 30,
              color: Colors.teal.shade300,
            ),
          ),
          title: Text(cubit.titles[cubit.currentIndex],
              style: const TextStyle(color: Colors.black,fontSize:18 )),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileMainView()),
                );

              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.teal.shade300,
                    child: const Icon(Icons.person,
                        size: 30, color: Colors.white)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
