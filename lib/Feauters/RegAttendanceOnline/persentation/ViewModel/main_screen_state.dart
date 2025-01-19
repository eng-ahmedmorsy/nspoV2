part of 'main_screen_cubit.dart';

@immutable
sealed class RegAttendanceOnlineState {}

final class RegAttendanceOnlineInitial extends RegAttendanceOnlineState {}

final class GetNewTime extends RegAttendanceOnlineState {}

final class GetAttendanceDataEmpLoading extends RegAttendanceOnlineState {}
final class RegAttendanceEmpLoading extends RegAttendanceOnlineState {}
final class RegAttendanceEmpSuccess extends RegAttendanceOnlineState {}
final class emitNewState extends RegAttendanceOnlineState {}
final class ToggleMiddleDay extends RegAttendanceOnlineState {}
final class UpdateAppState extends RegAttendanceOnlineState {}
final class ChangePage extends RegAttendanceOnlineState {}
final class RegAttendanceEmpError extends RegAttendanceOnlineState {
  final String message;
final bool isLocation;
  RegAttendanceEmpError(this.message, {this.isLocation =false});
}


final class GetAttendanceDataLoaded extends RegAttendanceOnlineState {}
final class SuccessState extends RegAttendanceOnlineState {}
final class UpdatesAvailable extends RegAttendanceOnlineState {}

final class CaptureImageSFaceState extends RegAttendanceOnlineState {}
final class EnableFaceDetectState extends RegAttendanceOnlineState {}

final class GetAttendanceDataEmpError extends RegAttendanceOnlineState {
  final String message;

  GetAttendanceDataEmpError(this.message);
}

