import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_system/config/Cache/cache_helper.dart';
import 'package:student_system/config/Network/dio_helper.dart';
import 'package:student_system/config/resources/cache_keys.dart';
import 'package:student_system/config/resources/constant.dart';
import 'package:student_system/features/home/models/pdf_model.dart';
import 'package:student_system/features/home/models/user_model.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  final userId = CacheHelper.getData(key: CacheKeys.id);
  NetworkHelper networkHelper = NetworkHelper();
  UserInfoModel? userModel;
  void getUserInfo(String id, String token) async {
    try {
      emit(GetUserLoading());
      final res = await networkHelper.get(
          path: '/users/user/info/$id',
          headers: {'Authorization': 'Bearer $token'});

      userModel = UserInfoModel.fromJson(res.data);
      if (CacheHelper.getData(key: CacheKeys.grade) == null) {
        CacheHelper.saveData(
            key: CacheKeys.grade, value: userModel!.user!.grade!);
      }
      await getSubjectPdf(userModel!.user!.grade!);
    } on DioError catch (e) {
      log(e.response!.data.toString());

      emit(GetUserError());
    }
  }

  PdfModel? pdfModel;
  getSubjectPdf(int grade) async {
    try {
      final res = await networkHelper
          .get(path: '/admin/subject', query: {'grade': grade});
      pdfModel = PdfModel.fromJson(res.data);
      emit(GetUserSuccess());
    } on DioError catch (e) {
      log(e.response!.data.toString());
      emit(GetSubjectError());
      rethrow;
    }
  }

  String getPdfPath(String path) {
    return 'http://${Constant.baseUrl}:8000/api/doctor/subject/pdf/$path.pdf';
  }

  deletePDf(int id) async {
    // /doctor/delete/pdf?id=8
    log(id.toString());
    emit(DeletePDFLoading());
    try {
      final res = await networkHelper
          .delete(path: '/doctor/delete/pdf', query: {'id': id});

      emit(DeletePDFSuccess(res.data!['message']));
    } on DioError catch (e) {
      emit(DeletePDFError(e.response!.data['message']));
      rethrow;
    }
  }

  uplaodPdfFile(int subId) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result == null) return;

    String? path = result.files.single.path;
    if (path == null) return;
    emit(UploadPDFLoading());
    try {
      String fileName = path.split('/').last;

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(path, filename: fileName),
      });
// /doctor/subject/add?subject_id=1&user_sub_id=1
      networkHelper.post(path: '/doctor/subject/add', data: formData, query: {
        'subject_id': subId,
        'user_sub_id': 0,
      });
      emit(UploadPDFSuccess());
    } on DioError catch (e) {
      emit(UploadPDFError(e.response!.data['message']));
      rethrow;
    }
  }

  void updateUserInfo({required String field, required String value}) async {
    emit(UpdateUserInfoLoading());
    try {
      final res =
          await networkHelper.put(path: '/user/update', data: {field: value});

      emit(UpdateUserInfoSuccess(res.data['message']));
    } on DioError catch (e) {
      log(e.response!.data.toString());
      rethrow;
    }
  }

  void updateUserPassword(
      {required String currentPassword, required String newPassword}) async {
    emit(UpdateUserInfoLoading());
    try {
      final res = await networkHelper.put(path: '/password/update', data: {
        "old_password": currentPassword,
        "password": newPassword,
        "password_confirmation": newPassword
      });

      emit(UpdateUserInfoSuccess(res.data['message']));
    } on DioError catch (e) {
      emit(UpdateUserInfoError(e.response?.data?['error'] ?? 'Unknown Error'));
      log(e.response!.data.toString());
      rethrow;
    }
  }

  deleteUser(int id) async {
    try {
      final res = await networkHelper.delete(path: '/users/delete/$id');
      emit(DeleteUserSuccess(res.data['message']));
    } on DioError catch (e) {
      emit(DeleteUserError(e.response!.data.toString()));
      rethrow;
    }
  }
}
