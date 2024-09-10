part of 'unsent_attendance_cubit.dart';

@immutable
sealed class UnsentAttendanceState {}

final class UnsentAttendanceInitial extends UnsentAttendanceState {}
final class SendAttendanceLoading extends UnsentAttendanceState {}
final class SendAttendanceLoaded extends UnsentAttendanceState {}
final class DeleteAttendState extends UnsentAttendanceState {}
final class SendAttendanceError extends UnsentAttendanceState {
  final String error;
  SendAttendanceError(this.error);
}
final class UnsentAttendanceLoading extends UnsentAttendanceState {}
final class UnsentAttendanceLoaded extends UnsentAttendanceState {

}
final class UnsentAttendanceError extends UnsentAttendanceState {
  final String error;
  UnsentAttendanceError(this.error);
}
