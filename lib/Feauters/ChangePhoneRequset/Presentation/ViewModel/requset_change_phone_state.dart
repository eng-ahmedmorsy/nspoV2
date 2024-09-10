part of 'requset_change_phone_cubit.dart';

@immutable
sealed class RequestChangePhoneState {}

final class RequestChangePhoneInitial extends RequestChangePhoneState {}
final class RequestChangePhoneLoading extends RequestChangePhoneState {}
final class RequestChangePhoneError extends RequestChangePhoneState {
  final String error;

  RequestChangePhoneError(this.error);
}
final class RequestChangePhoneLoaded extends RequestChangePhoneState {
}final class AddRequestChangePhoneLoading extends RequestChangePhoneState {
}
final class AddRequestChangePhoneError extends RequestChangePhoneState {
  final String error;

  AddRequestChangePhoneError(this.error);
}
final class AddRequestChangePhoneLoaded extends RequestChangePhoneState {
}final class DeleteRequestChangePhoneLoading extends RequestChangePhoneState {
}
final class DeleteRequestChangePhoneError extends RequestChangePhoneState {
  final String error;

  DeleteRequestChangePhoneError(this.error);
}
final class DeleteRequestChangePhoneLoaded extends RequestChangePhoneState {}

