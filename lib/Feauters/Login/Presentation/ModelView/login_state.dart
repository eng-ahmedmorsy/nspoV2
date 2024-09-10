part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}
final class UpdatesAvailable extends LoginState {}

final class LoginErrorMessage extends LoginState {
  final String error;

  LoginErrorMessage(this.error);
}
