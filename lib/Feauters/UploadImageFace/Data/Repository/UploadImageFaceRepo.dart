import 'package:dartz/dartz.dart';

abstract class UploadImageFaceRepo {
  Future<Either<String, String>> uploadImageFace(String imagePath, int id);
}
