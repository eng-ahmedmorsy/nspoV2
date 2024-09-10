part of 'main_screen_cubit.dart';

@immutable
sealed class MainScreenState {}

final class MainScreenInitial extends MainScreenState {}

final class GetNewTime extends MainScreenState {}

final class GetAttendanceDataEmpLoading extends MainScreenState {}
final class RegAttendanceEmpLoading extends MainScreenState {}
final class RegAttendanceEmpSuccess extends MainScreenState {}
final class ToggleMiddleDay extends MainScreenState {}
final class ChangePage extends MainScreenState {}
final class GetNameEmployee extends MainScreenState {}
final class GetCountUnsentAttendance extends MainScreenState {}
final class UpdateAppState extends MainScreenState {}
final class RegAttendanceEmpError extends MainScreenState {
  final String message;
final bool isLocation;
  RegAttendanceEmpError(this.message, {this.isLocation =false});
}


final class GetAttendanceDataLoaded extends MainScreenState {}

final class GetAttendanceDataEmpError extends MainScreenState {
  final String message;

  GetAttendanceDataEmpError(this.message);
}

