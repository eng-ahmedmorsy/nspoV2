import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:nspo/Core/servies/DeviceInfo.dart';
import 'package:nspo/Feauters/ChangePhoneRequset/Data/Repo/RequsetChangePhoneRepo.dart';
import 'package:nspo/Feauters/ChangePhoneRequset/Data/models/RequsetChangePhone.dart';

import '../../../../../Core/servies/GeoLactor.dart';
import '../../../../../Core/servies/sharedPerf.dart';
import '../../../Data/Repo/RequestChangePhoneRepoImpl.dart';
import '../../../Data/models/RegNewLocationModel.dart';
import '../reg_new_location_request.dart';

part 'reg_new_location_request_state.dart';

class RegNewLocationRequestCubit extends Cubit<RegNewLocationRequestState> {
  RegNewLocationRequestCubit() : super(RegNewLocationRequesteInitial());
  TextEditingController noteController = TextEditingController();
  RegNewLocationRequestModel RegNewLocationRequest = RegNewLocationRequestModel();
  TextEditingController nameProjectController = TextEditingController();


  getLastRequest() async {
    emit(RegNewLocationRequestLoading());
    RegNewLocationRepoImpl RegNewLocationRequestRepo = RegNewLocationRepoImpl();
    int? personId = await getPersonalId();
    final result =
        await RegNewLocationRequestRepo.getLastRegNewLocation(personId);
    result.fold((l) => emit(RegNewLocationRequestError(l)), (r) {
      RegNewLocationRequest = r;
      emit(RegNewLocationRequestLoaded());
    });
  }

  addRequest() async {
  try {
    if (nameProjectController.text.isEmpty) {
      emit(AddRegNewLocationRequestError("الرجاء ادخال اسم المشروع"));
      return;
    }
    if (noteController.text.isEmpty) {
      emit(AddRegNewLocationRequestError("الرجاء ادخال السبب"));
      return;
    }
    if (noteController.text.length < 10) {
      emit(AddRegNewLocationRequestError("الرجاء ادخال سبب اكثر من 10 حروف"));
      return;
    }
    if (RegNewLocationRequest.status == null &&
        RegNewLocationRequest.notets != null) {
      emit(AddRegNewLocationRequestError("لديك طلب قيد الانتظار"));
      return;
    }
    RegNewLocationRequestModel request = RegNewLocationRequestModel();
    request.coord = await getCoordinates();



    emit(AddRegNewLocationRequestLoading());
    RegNewLocationRepoImpl RegNewLocationRequestRepo = RegNewLocationRepoImpl();
    request.notets = noteController.text;
    request.nameProject = nameProjectController.text;
    request.personId = await getPersonalId();

    final result =
    await RegNewLocationRequestRepo.addNewLocationRequestRequest(request);
    result.fold((l) => emit(AddRegNewLocationRequestError(l)), (r) {
      emit(AddRegNewLocationRequestLoaded());
      getLastRequest();
    });
  }catch(e){
    emit(ErrorLocationState(e.toString()));
  }}


  Future<int> getPersonalId() async {
    Map<String, dynamic>? data =
        await SharedPreferencesService.retrieveMap("infoEmployee");

    return data!["id"];
  }
  Future getCoordinates() async {
    Position? position = await GeoServices.getCurrentLocation();

    return "${position.latitude},${position.longitude}";
  }
  deleteRequest( int id) async {
    print(id);
    print(id);
    print(id);
    print(id);
    print(id);
    print(id);
    print(id);
    print(id);
    print(id);
    print(id);
    print(id);
    print(id);

    emit(DeleteRegNewLocationRequestLoading());
    RegNewLocationRepoImpl RegNewLocationRequestRepo = RegNewLocationRepoImpl();
    final result = await RegNewLocationRequestRepo.Delete(id);
    result.fold((l) => emit(DeleteRegNewLocationRequestError(l)), (r) {
      emit(DeleteRegNewLocationRequestLoaded());
      getLastRequest();
    });
  }

}
