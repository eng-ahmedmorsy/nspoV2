import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../Core/constance/url.dart';
import '../../../../Core/servies/api_services.dart';
import 'UploadImageFaceRepo.dart';

class UploadImageFaceRepoImpl implements UploadImageFaceRepo {
  @override
  Future<Either<String, String>> uploadImageFace(
      String imagePath, int id) async {
    try {
      ApiService apiService = ApiService();

      MultipartFile imageFile = await getImageMultipart(imagePath);

      FormData formData = FormData.fromMap({
        'image': imageFile,
        'id': id,
      });

      await apiService.postData(
        path: UrlEndpoint.uploadImage(),
        data: formData,
      );

      return Right('Success');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<MultipartFile> getImageMultipart(String imagePath) async {
    return await MultipartFile.fromFile(imagePath,
        contentType: DioMediaType('image', 'jpg'));
  }
}
