part of 'upload_face_cubit.dart';

@immutable
sealed class UploadFaceState {}

final class UploadFaceInitial extends UploadFaceState {}

final class ChangeAcceptedState extends UploadFaceState {}

final class ShowImageState extends UploadFaceState {}

final class RepeatTakeImageState extends UploadFaceState {}

final class ShowImageLoadingState extends UploadFaceState {}

final class SendImageLoadingState extends UploadFaceState {}

final class SendImageErrorState extends UploadFaceState {}

final class SendImageSuccessState extends UploadFaceState {}

