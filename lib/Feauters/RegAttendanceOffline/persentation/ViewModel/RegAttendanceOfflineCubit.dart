import 'dart:async';
import 'dart:io';

import 'package:datetime_setting/datetime_setting.dart';

import 'package:geolocator/geolocator.dart';
import 'package:nspo/Core/servies/GeoLactor.dart';
import 'package:nspo/Core/servies/sharedPerf.dart';
import 'package:nspo/Core/utils/app_router.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:nspo/Feauters/MainScreenView/persentation/ViewModel/main_screen_cubit.dart';


import '../../../../Core/models/AttendanceRecord.dart';
import '../../../../Core/servies/DeviceInfo.dart';
import '../Data/Models/InfoMamouria.dart';
import '../Data/Repoistry/AttendanceRepoImpl.dart';

part 'RegAttendanceOfflineState.dart';

class RegAttendanceOfflineCubit extends Cubit<RegAttendanceOfflineState> {
  RegAttendanceOfflineCubit(this.mainScreenCubit) : super(RegAttendanceOfflineInitial());
  final MainScreenCubit? mainScreenCubit;


  String timeString = "";
  AttendanceEmpToday? attendanceData;
  bool isMiddleDay = true;

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    timeString = formattedDateTime;

    emit(GetNewTime());
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(DateTime.now());
  }

  handelTime() {
    timeString = _formatDateTime(DateTime.now());
    Timer.periodic(const Duration(minutes: 1), (Timer t) => _getTime());
  }

  Future<void> getAttendanceDataEmp() async {
    emit(GetAttendanceDataEmpLoading());
    AttendanceOfflineRepoImpl attendanceRepoImpl = AttendanceOfflineRepoImpl();

    int personalId = await getPersonalId();

    attendanceRepoImpl.getAttendanceToday(personalId).then((value) {
      value.fold((l) {
        emit(GetAttendanceDataEmpError(l));
      }, (r) {
        attendanceData = r;
        emit(GetAttendanceDataLoaded());
      });
    });

    // AttendanceORepoImpl attendanceRepoImpl = AttendanceRepoImpl();
    // emit(GetAttendanceDataEmpLoading());
    // Map<String, dynamic>? empData = await getDataAuthEmp();
    // final result =
    //     await attendanceRepoImpl.getAttendanceDataEmp(data: empData!);
    // result.fold((l) {
    //   emit(GetAttendanceDataEmpError(l));
    // }, (r) {
    //   attendanceData = r;
    //   emit(GetAttendanceDataLoaded());
    // });
  }

  Future<Map<String, dynamic>?> getDataAuthEmp() async {
    Map<String, dynamic>? data =
        await SharedPreferencesService.retrieveMap("infoEmployee");

    return data;
  }

  Future<int> getPersonalId() async {
    Map<String, dynamic>? data =
        await SharedPreferencesService.retrieveMap("infoEmployee");

    return data!["id"];
  }

  Future<String?> getDeviceId() async {
    return await DeviceInfoService.getDeviceId();
  }

  Future getCoordinates() async {
    Position? position = await GeoServices.getCurrentLocation();

    return Coordinates(
        latitude: position.longitude, longitude: position.latitude);
  }

  // Future<List<String>> getAllCardsInPhone() async {
  //   List<String> cards = [];
  //   var status = await Permission.phone.status;
  //
  //   if (!status.isGranted) {
  //     bool isGranted = await Permission.phone.request().isGranted;
  //     if (!isGranted) throw 'Sim_Permission_Denied';
  //   }
  //   SimData simData = await SimDataPlugin.getSimData();
  //   cards = simData.cards.map((e) => e.serialNumber).toList();
  //
  //   return cards;
  // }

  Future<void> regAttendanceEmp(BuildContext context) async {
    try {
      // bool isAuthenticate = await BiometricsService.authenticate();
      // if (!isAuthenticate) return;
      emit(RegAttendanceEmpLoading());


      if( Platform.isAndroid) {
        bool timeAuto = await DatetimeSetting.timeIsAuto();
        bool timezoneAuto = await DatetimeSetting.timeZoneIsAuto();
        if (!timeAuto || !timezoneAuto) {
          throw "No_Auto_Time";
        }
      }

      AttendanceOfflineRepoImpl attendanceRepoImpl =
          AttendanceOfflineRepoImpl();
      AttendanceRecord regAttendanceModel = AttendanceRecord();
      regAttendanceModel.coordinates = await getCoordinates();



      int personalId = await getPersonalId();

      regAttendanceModel.personId = personalId;
      regAttendanceModel.deviceId = await getDeviceId();
      regAttendanceModel.isMiddleDay = isMiddleDay;
      regAttendanceModel.attDate = DateTime.now().toString();
      // regAttendanceModel.onlyDate = DateTime.now().toString().split(" ")[0];
      if ( attendanceData!.timeIn != "--:--" && attendanceData!.timeOut == "--:--" && isMiddleDay == true)   {
        regAttendanceModel.inOut = 2;
      } else if ( attendanceData!.timeIn != "--:--") {
        regAttendanceModel.inOut = 1;
      } else {
        regAttendanceModel.inOut = 0;
      }

      final result =
          await attendanceRepoImpl.addAttendanceData(regAttendanceModel);
      result.fold((l) {
        emit(RegAttendanceEmpError(l));
      }, (r) async {
        emit(RegAttendanceEmpSuccess());
        mainScreenCubit!.getCountUnsentAttendance();
        await getAttendanceDataEmp();
      });
    } catch (e) {

      emit(RegAttendanceEmpError(e.toString(), isLocation: true));
    }
  }

  void Logout(BuildContext context) async {
    await SharedPreferencesService.delete("infoEmployee");
    attendanceData = null;
    context.pushReplacement(AppRouter.mainScreenView);
  }

  void toggleMiddleDay() {
    isMiddleDay = !isMiddleDay;
    emit(ToggleMiddleDay());
  }

// Future<bool> checkFakeLocation(BuildContext context) async {
//   bool isMockLocation = await SafeDevice.isMockLocation;
//   return isMockLocation;
//  }
}
