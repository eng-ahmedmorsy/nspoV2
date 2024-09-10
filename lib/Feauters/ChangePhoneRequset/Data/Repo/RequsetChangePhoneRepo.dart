import 'package:dartz/dartz.dart';
import 'package:nspo/Feauters/ChangePhoneRequset/Data/models/RequsetChangePhone.dart';

abstract class RequestChangePhoneRepo {

  Future<Either<String, RequestChangePhone>> getLastChangePhoneRequest(int personId);
 Future< Either<String,String>> addChangePhoneRequest(RequestChangePhone requestChangePhone);
 Future< Either<String,String>> delete(int id);

}