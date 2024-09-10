import 'package:dartz/dartz.dart';


import '../models/RegNewLocationModel.dart';

abstract class RegNewLocationRepo {

  Future<Either<String, RegNewLocationRequestModel>> getLastRegNewLocation(int personId);
 Future< Either<String,String>> addNewLocationRequestRequest(RegNewLocationRequestModel regNewLocationRequest);
 Future< Either<String,String>> Delete(int id);


}