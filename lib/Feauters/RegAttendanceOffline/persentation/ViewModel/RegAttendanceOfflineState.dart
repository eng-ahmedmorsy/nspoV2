part of 'RegAttendanceOfflineCubit.dart';

@immutable
sealed class RegAttendanceOfflineState {}

final class RegAttendanceOfflineInitial extends RegAttendanceOfflineState {}

final class GetNewTime extends RegAttendanceOfflineState {}

final class GetAttendanceDataEmpLoading extends RegAttendanceOfflineState {}
final class RegAttendanceEmpLoading extends RegAttendanceOfflineState {}
final class RegAttendanceEmpSuccess extends RegAttendanceOfflineState {}
final class ToggleMiddleDay extends RegAttendanceOfflineState {}
final class ChangePage extends RegAttendanceOfflineState {}
final class RegAttendanceEmpError extends RegAttendanceOfflineState {
  final String message;
final bool isLocation;
  RegAttendanceEmpError(this.message, {this.isLocation =false});
}


final class GetAttendanceDataLoaded extends RegAttendanceOfflineState {}

final class GetAttendanceDataEmpError extends RegAttendanceOfflineState {
  final String message;

  GetAttendanceDataEmpError(this.message);
}

