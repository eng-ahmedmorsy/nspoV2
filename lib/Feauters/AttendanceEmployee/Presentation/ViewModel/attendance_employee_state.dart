part of 'attendance_employee_cubit.dart';

@immutable
sealed class AttendanceEmployeeState {}

final class AttendanceEmployeeInitial extends AttendanceEmployeeState {}

final class ChangeMonthState extends AttendanceEmployeeState {}

final class ChangeYearState extends AttendanceEmployeeState {}

final class LoadingGetAttendanceState extends AttendanceEmployeeState {}

final class ErrorGetAttendanceState extends AttendanceEmployeeState {
  final String error;

  ErrorGetAttendanceState(this.error);
}

final class SuccessState extends AttendanceEmployeeState {}
