import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class GetUserLoading extends HomeState {}

class GetUserSuccess extends HomeState {}

class GetUserError extends HomeState {}

class GetSubjectSuccess extends HomeState {}

class GetSubjectError extends HomeState {}

class DeletePDFLoading extends HomeState {}

class DeletePDFSuccess extends HomeState {
  final String m;

  const DeletePDFSuccess(this.m);
}

class DeletePDFError extends HomeState {
  final String e;

  const DeletePDFError(this.e);
}

class UploadPDFLoading extends HomeState {}

class UploadPDFSuccess extends HomeState {}

class UploadPDFError extends HomeState {
  final String e;

  const UploadPDFError(this.e);
}

class UpdateUserInfoLoading extends HomeState {}

class UpdateUserInfoError extends HomeState {
  final String message;

  const UpdateUserInfoError(this.message);
}

class UpdateUserInfoSuccess extends HomeState {
  final String message;

  const UpdateUserInfoSuccess(this.message);
}

class DeleteUserError extends HomeState {
  final String message;

  const DeleteUserError(this.message);
}

class DeleteUserSuccess extends HomeState {
  final String message;

  const DeleteUserSuccess(this.message);
}
