import 'package:dartz/dartz.dart';
import 'package:nspo/Feauters/ChangePhoneRequset/Data/models/RequsetChangePhone.dart';
import 'package:nspo/Feauters/RegNewLocationRequest/Presention/Views/reg_new_location_request.dart';

import '../models/RegNewLocationModel.dart';

abstract class RegNewLocationRepo {

  Future<Either<String, RegNewLocationRequestModel>> getLastRegNewLocation(int personId);
 Future< Either<String,String>> addNewLocationRequestRequest(RegNewLocationRequestModel regNewLocationRequest);
 Future< Either<String,String>> Delete(int id);


}