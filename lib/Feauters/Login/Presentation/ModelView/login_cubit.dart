import 'package:nspo/Core/servies/DeviceInfo.dart';
import 'package:nspo/Core/servies/sharedPerf.dart';
import 'package:nspo/Feauters/Login/Data/Repository/LoginRepo.dart';
import 'package:nspo/Feauters/Login/Data/Repository/LoginRepoImpl.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

import '../../Data/Models/LoginData.dart';
import '../../Data/Models/infoEmployee.dart';

part 'login_state.dart';


class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final shorebirdCodePush = ShorebirdCodePush();


  Future<void> loginEmployee() async {
    LoginRepoImpl loginRepo = LoginRepoImpl();
    emit(LoginLoading());
    String deviceId = await getDeviceId() ?? "";
    print(deviceId);
    if (deviceId.isEmpty) {
      emit(LoginErrorMessage("حدث خطأ ما"));
      return;
    }
    LoginData loginData = LoginData(
        userName: userNameController.text,
        password: passwordController.text,
        deviceId: deviceId);

    final result = await loginRepo.loginEmployee(loginData: loginData);
    result.fold((error) => emit(LoginErrorMessage(error)), (data) async {
      Map<String, dynamic> infoEmployee = {
        "id": data["idPerson"],
        "name": data["name"],
        "userName": loginData.userName,
        "password": loginData.password,
      };
      await storeInfoEmployee(infoEmployee);
      // userNameController.clear();
      // passwordController.clear();

      emit(LoginSuccess());
    });
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

  Future<void> storeInfoEmployee(Map<String, dynamic> infoEmployee) async {
    await SharedPreferencesService.storeMap('infoEmployee', infoEmployee);
  }

  Future<void> getInfoEmployee() async {
    Map<String, dynamic>? data = await SharedPreferencesService.retrieveMap(
      'infoEmployee',
    );
  }

  Future<String?> getDeviceId() async {
    return await DeviceInfoService.getDeviceId();
  }
}
