import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nspo/Core/servies/GeoLactor.dart';
import 'package:nspo/Core/servies/sharedPerf.dart';
import 'package:nspo/Core/utils/app_router.dart';
import 'package:nspo/Feauters/MainScreenView/persentation/ViewModel/main_screen_cubit.dart';
import 'package:nspo/Feauters/RegAttendanceOnline/persentation/Data/Models/InfoMamouria.dart';
import 'package:nspo/Feauters/RegAttendanceOnline/persentation/Data/Repoistry/AttendanceRepoImpl.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

import '../../../../Core/servies/Biometrics.dart';
import '../../../../Core/servies/DeviceInfo.dart';
import '../../../../Core/servies/UpdateApp.dart';
import '../Data/Models/RegAttendaceModel.dart';

part 'main_screen_state.dart';

class RegAttendanceOnlineCubit extends Cubit<RegAttendanceOnlineState> {
  RegAttendanceOnlineCubit(this.mainScreenCubit)
      : super(RegAttendanceOnlineInitial());
  final MainScreenCubit mainScreenCubit;

  String timeString = "";
  AttendanceData? attendanceData;
  bool isMiddleDay = true;
  final shorebirdCodePush = ShorebirdCodePush();

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    timeString = formattedDateTime;

    emit(GetNewTime());
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(DateTime.now());
  }

  checkUpdate() async {
    final isShorebirdAvailable =
        await shorebirdCodePush.isNewPatchAvailableForDownload();
    if (isShorebirdAvailable) {
      await shorebirdCodePush.downloadUpdateIfAvailable().then((value) {
        emit(UpdatesAvailable());
      });
    }
  }

  handelTime() {
    timeString = _formatDateTime(DateTime.now());
    Timer.periodic(const Duration(minutes: 1), (Timer t) => _getTime());
  }

  Future handleLocationPermission() async {
    try {
      await GeoServices().handelPermissionAndServiceLocation();
    } catch (e) {
      emit(RegAttendanceEmpError(e.toString(), isLocation: true));
    }
  }

  Future<void> getAttendanceDataEmp() async {
    AttendanceRepoImpl attendanceRepoImpl = AttendanceRepoImpl();
    emit(GetAttendanceDataEmpLoading());
    Map<String, dynamic>? empData = await getDataAuthEmp();
    final result =
        await attendanceRepoImpl.getAttendanceDataEmp(data: empData!);
    result.fold((l) {
      emit(GetAttendanceDataEmpError(l));
    }, (r) {
      attendanceData = r;
      emit(GetAttendanceDataLoaded());
    });
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

  emitNewState() {
    emit(emitNewState());
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
      int count = mainScreenCubit.countUnsentAttendance;
      if (count > 0) {
        emit(RegAttendanceEmpError(
            "يوجد حضور offline لم يتم ارساله بعد برجاء ارسالها اولا"));
        return;
      }

      bool isAuthenticate = await BiometricsService.authenticate();
      if (!isAuthenticate) return;

      emit(RegAttendanceEmpLoading());
      AttendanceRepoImpl attendanceRepoImpl = AttendanceRepoImpl();
      RegAttendanceModel regAttendanceModel = RegAttendanceModel();
      regAttendanceModel.coordinates = await getCoordinates();

      int personalId = await getPersonalId();

      regAttendanceModel.personId = personalId;
      regAttendanceModel.deviceId = await getDeviceId();
      regAttendanceModel.isMiddleDay = isMiddleDay;

      final result =
          await attendanceRepoImpl.addAttendanceData(regAttendanceModel);
      result.fold((l) {
        emit(RegAttendanceEmpError(l));
      }, (r) async {
        emit(RegAttendanceEmpSuccess());
        await getAttendanceDataEmp();
      });
    } catch (e) {
      print(e);

      emit(RegAttendanceEmpError(e.toString(), isLocation: true));
    }
  }

  Future<void> checkVersion() async {
    UpdateApp updateApp = UpdateApp();
    bool isSameVersion = await updateApp.CheckVersion();
    if (!isSameVersion) {
      emit(UpdateAppState());
    }
  }

  initPage() async {
    await getAttendanceDataEmp();
    await handelTime();
    await checkVersion();
    await checkUpdate();
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
