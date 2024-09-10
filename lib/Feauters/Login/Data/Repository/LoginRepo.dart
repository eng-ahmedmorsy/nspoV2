import 'package:nspo/Feauters/Login/Data/Models/LoginData.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepo {
  Future<Either<String, Map>> loginEmployee({required LoginData loginData});
}