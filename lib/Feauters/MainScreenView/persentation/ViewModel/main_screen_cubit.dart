
import 'package:flutter/services.dart';
import 'package:nspo/Core/servies/DbHelper.dart';

import 'package:nspo/Core/servies/sharedPerf.dart';
import 'package:nspo/Core/utils/app_router.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';
import 'package:nspo/Feauters/UnsentAttendance/Presentation/Views/unSentAttendance.dart';


import '../../../AttendanceEmployee/Presentation/views/AttendanceEmployeeView.dart';
import '../../../ChangePhoneRequset/Presentation/views/ChangePhoneRequset.dart';
import '../../../RegAttendanceOffline/persentation/Views/RegAttendanceOnlineView.dart';
import '../../../RegAttendanceOnline/persentation/Views/RegAttendanceOnlineView.dart';
import '../../../RegNewLocationRequest/Presention/Views/reg_new_location_request.dart';

part 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(MainScreenInitial());

  List<Widget> iconsNavBars = const <Widget>[
    Icon(Icons.description_outlined, size: 30, color: Colors.white),
    Icon(Icons.save_as, size: 30, color: Colors.white),
    Icon(Icons.fingerprint, size: 30, color: Colors.white),
     Icon(Icons.wifi_off, size: 30, color: Colors.white),
    Icon(Icons.near_me, size: 30, color: Colors.white),
    Icon(Icons.edit_location_alt_rounded, size: 30, color: Colors.white),
  ];
  List<String> titles = const <String>[
    "تقرير الحضور والانصراف",
    "طلب تغيير الهاتف",
    "تسجيل الحضور والانصراف اونلاين",
    "تسجيل الحضور والانصراف اوفلاين",
    "الحضور والانصراف غير المرسل",
    "طلب تسجيل موقع جديد",
  ];



  int countUnsentAttendance = 0;
  Color color = Colors.teal.shade300;

  int currentIndex = 2;
  List pages = [
    const AttendanceEmployeeView(),
    const ChangePhoneRequset(),
    const RegAttendanceOnlineView(),
    const RegAttendanceOfflineView(),
    const UnsentAttendance(),
    const RegNewLocationRequest(),
  ];
  String nameEmp = "";

  void changePage(int index) {
    if(index==3){
      color = Colors.grey;
    }else{
      color = Colors.teal.shade300;
    }
    currentIndex = index;
    emit(ChangePage());
  }

  void Logout(BuildContext context) async {
    await SharedPreferencesService.delete("infoEmployee");
    context.pushReplacement(AppRouter.mainScreenView);
  }

  getIdEmployee() async {
    Map<String, dynamic>? data =
        await SharedPreferencesService.retrieveMap("infoEmployee");

   return  data!["id"];
  }





  getCountUnsentAttendance() async {

    int personId = await getIdEmployee();
    countUnsentAttendance = await DatabaseHelper().getCountIsNotSent(personId);
    emit(GetCountUnsentAttendance());

}}
