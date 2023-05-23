import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoadGovern extends LoginState {}

class LoadGovernSuccess extends LoginState {}

class GetSubjectSuccess extends LoginState {}

class GetSubjectError extends LoginState {}

class RegisterLoading extends LoginState {}

class RegisterSuccess extends LoginState {
  final String token;

  const RegisterSuccess(this.token);
}

class RegisterError extends LoginState {
  final String? error;

  const RegisterError(this.error);
}
