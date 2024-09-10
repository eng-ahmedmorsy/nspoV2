part of 'reg_new_location_request_cubit.dart';

@immutable
sealed class RegNewLocationRequestState {}

final class RegNewLocationRequesteInitial extends RegNewLocationRequestState {}
final class RegNewLocationRequestLoading extends RegNewLocationRequestState {}
final class ErrorLocationState extends RegNewLocationRequestState {
  final String message;
  ErrorLocationState(this.message);
}
final class RegNewLocationRequestError extends RegNewLocationRequestState {
  final String error;

  RegNewLocationRequestError(this.error);
}
final class RegNewLocationRequestLoaded extends RegNewLocationRequestState {
}final class AddRegNewLocationRequestLoading extends RegNewLocationRequestState {
}
final class AddRegNewLocationRequestError extends RegNewLocationRequestState {
  final String error;

  AddRegNewLocationRequestError(this.error);
}
final class AddRegNewLocationRequestLoaded extends RegNewLocationRequestState {
}final class DeleteRegNewLocationRequestLoading extends RegNewLocationRequestState {
}
final class DeleteRegNewLocationRequestError extends RegNewLocationRequestState {
  final String error;

  DeleteRegNewLocationRequestError(this.error);
}
final class DeleteRegNewLocationRequestLoaded extends RegNewLocationRequestState {}



