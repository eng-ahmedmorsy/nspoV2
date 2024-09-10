import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:nspo/Core/Widgets/Dailog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Feauters/MainScreenView/persentation/Views/widget/appBarCustom.dart';


import '../ViewModel/main_screen_cubit.dart';

class MainScreenView extends StatefulWidget {
  const MainScreenView({super.key});

  @override
  State<MainScreenView> createState() => _MainScreenViewState();
}

class _MainScreenViewState extends State<MainScreenView> {
  @override
  void initState() {
    context.read<MainScreenCubit>().getCountUnsentAttendance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<MainScreenCubit>();

    return BlocConsumer<MainScreenCubit, MainScreenState>(
      listener: (context, state) {
        if(state is UpdateAppState){
          DailogError(context, message: "بوجد تحديث جديد لقد تم ايقاف البرنامج برجاء تحميل التحديث الجديد من خلال تواصل مع فرع نظم علي واتس اب ",barrierDismissible: false);
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: const CustomAppBar(),
            bottomNavigationBar: CurvedNavigationBar(
              items: cubit.iconsNavBars,
              index: cubit.currentIndex,

              color: cubit.color,
              buttonBackgroundColor: Colors.teal.shade300,
              backgroundColor: Colors.transparent,
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 600),
              onTap: (int index) => cubit.changePage(index),
            ),
            body: cubit.pages[cubit.currentIndex]


        );
      },
    );
  }
}
