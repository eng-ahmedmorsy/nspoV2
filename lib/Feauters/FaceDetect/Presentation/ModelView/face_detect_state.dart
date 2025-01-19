part of 'face_detect_cubit.dart';

@immutable
sealed class FaceDetectState {}

final class FaceDetectInitial extends FaceDetectState {}
final class FaceDetectedChangeState extends FaceDetectState {}
final class ChangeCustomPaintState extends FaceDetectState {}
final class CaptureImageState extends FaceDetectState {}
final class CameraInitState extends FaceDetectState {}
