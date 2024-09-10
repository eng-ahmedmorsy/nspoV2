import 'package:dartz/dartz.dart';
import 'package:nspo/Feauters/profile/features/Data/Models/reset_password.dart';

abstract class ResetPasswordRepo {
 Future<Either<String, String>> resetPassword({required ResetPasswordModel resetPasswordModel});
}