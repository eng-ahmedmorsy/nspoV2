import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:nspo/Core/servies/DeviceInfo.dart';
import 'package:nspo/Feauters/ChangePhoneRequset/Data/Repo/RequestChangePhoneRepoImpl.dart';
import 'package:nspo/Feauters/ChangePhoneRequset/Data/Repo/RequsetChangePhoneRepo.dart';
import 'package:nspo/Feauters/ChangePhoneRequset/Data/models/RequsetChangePhone.dart';

import '../../../../Core/servies/sharedPerf.dart';

part 'requset_change_phone_state.dart';

class RequestChangePhoneCubit extends Cubit<RequestChangePhoneState> {
  RequestChangePhoneCubit() : super(RequestChangePhoneInitial());
  TextEditingController noteController = TextEditingController();

  RequestChangePhone requestChangePhone = RequestChangePhone();

  getLastRequest() async {
    emit(RequestChangePhoneLoading());
    RequestChangePhoneRepoImpl requestChangePhoneRepo =
        RequestChangePhoneRepoImpl();
    int? personId = await getPersonalId();
    final result = await requestChangePhoneRepo.getLastChangePhoneRequest(personId);
    result.fold((l) => emit(RequestChangePhoneError(l)), (r) {
      requestChangePhone = r;
      emit(RequestChangePhoneLoaded());
    });
  }

  addRequest() async {
    if(noteController.text.isEmpty){
      emit(AddRequestChangePhoneError("الرجاء ادخال السبب"));
      return;
    }
    if(noteController.text.length < 10){
      emit(AddRequestChangePhoneError("الرجاء ادخال سبب اكثر من 10 حروف"));
      return;
    }
    if(requestChangePhone.isAccepted == null && requestChangePhone.notes != null){
      emit(AddRequestChangePhoneError("لديك طلب قيد الانتظار"));
      return;
    }
    emit(AddRequestChangePhoneLoading());
    RequestChangePhoneRepoImpl requestChangePhoneRepo =
        RequestChangePhoneRepoImpl();
    RequestChangePhone request = RequestChangePhone();
    request.notes = noteController.text;
    request.newDeviceId = await getDeviceId();
    request.personId = await getPersonalId();

    final result = await requestChangePhoneRepo.addChangePhoneRequest(request);
    result.fold((l) => emit(AddRequestChangePhoneError(l)), (r) {

      emit(AddRequestChangePhoneLoaded());
          getLastRequest();
    });
  }

  getDeviceId() async {
    return await DeviceInfoService.getDeviceId();
  }

  Future<int> getPersonalId() async {
    Map<String, dynamic>? data =
        await SharedPreferencesService.retrieveMap("infoEmployee");

    return data!["id"];
  }
  deleteRequest() async {
    print("s"*900);
    emit(DeleteRequestChangePhoneLoading());
    RequestChangePhoneRepoImpl requestChangePhoneRepo =
        RequestChangePhoneRepoImpl();
    final result = await requestChangePhoneRepo.delete(requestChangePhone.id!);
    result.fold((l) => emit(DeleteRequestChangePhoneError(l)), (r) {
      emit(DeleteRequestChangePhoneLoaded());
      getLastRequest();
    });
  }
}
