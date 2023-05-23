import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_system/config/Network/dio_helper.dart';
import 'package:student_system/config/resources/cache_keys.dart';
import 'package:student_system/features/home/presentation/cubit/home_cubit.dart';

import '../../../../config/Cache/cache_helper.dart';
import '../../../../config/utils/components.dart';
import '../../models/address.dart';
import '../../models/subjects.dart';
import '../pages/login.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  RegExp phoneRegex = RegExp(r'^01[0-9]{9}$');

  List<City> city = [];
  List<Govern> govern = [];
  final NetworkHelper _networkHelper = NetworkHelper();
  loadJson([bool isGovern = true]) async {
    emit(LoadGovern());
    String path =
        isGovern ? 'assets/json/governorates.json' : 'assets/json/cities.json';
    try {
      String jsonString = await rootBundle.loadString(path);
      dynamic jsonList = json.decode(jsonString);

      for (var data in jsonList[2]['data']) {
        if (isGovern) {
          govern.add(Govern(
              governAR: data['governorate_name_ar'],
              governEn: data['governorate_name_en'],
              id: data['id']));
        } else {
          city.add(City(
              cityAR: data['city_name_ar'],
              cityEN: data['city_name_en'],
              id: data['governorate_id']));
        }
      }

      emit(LoadGovernSuccess());
    } catch (e) {
      rethrow;
    }
  }

  List<String> subjectsNames = [
    'Subjects',
  ];
  List<String> role = [
    'Role',
    'Doctor',
    'Admin',
    'Student',
  ];
  List<String> depart = [
    'Department',
    'CS',
    'IT',
    'IS',
  ];
  List<String> sub = [];
  Subjects? subjectModel;

  getSubjectWhenGrade(String grade) async {
    subjectModel = null;
    subjectsNames = [
      'Subjects',
    ];
    try {
      final res = await _networkHelper
          .get(path: '/admin/subject', query: {'grade': grade});
      subjectModel = Subjects.fromJson(res.data);
      for (var element in subjectModel!.result!) {
        subjectsNames.add(element.subjectName!);
      }
      emit(GetSubjectSuccess());
    } on DioError catch (e) {
      emit(GetSubjectError());
      log(e.response!.data.toString());
    }
  }

  void register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String role,
    required int grade,
    required AddressModel address,
  }) async {
    emit(RegisterLoading());
    try {
      final res = await _networkHelper.post(path: '/register', data: {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "role": role.toLowerCase(),
        "grade": grade,
        // "depart":""
        "password_confirmation": password,
        "address": address.toJson(),
        "subjects": testSub!.map((e) => e.toJson()).toList()
      });

      CacheHelper.saveData(
          key: CacheKeys.token, value: res.data['access_token']);
      CacheHelper.saveData(key: CacheKeys.id, value: res.data['user']['id']);
      emit(RegisterSuccess(res.data['access_token']));
    } on DioError catch (e) {
      emit(RegisterError(e.response!.data['message']));

      rethrow;
    }
  }

  List<Subject>? testSub = [];
  getSelectedSubjects() {
    testSub?.clear();

    for (String subject in sub) {
      testSub!.addAll(subjectModel!.result!
          .where((element) => element.subjectName!.contains(subject))
          .toList());
    }

    print(testSub!.map((e) => e.toJson()).toList());
  }

  login({
    required String emailOrPhone,
    required String password,
  }) async {
    emit(RegisterLoading());
    try {
      if (emailRegex.hasMatch(emailOrPhone)) {
        final res = await _networkHelper.post(path: '/login', data: {
          'email': emailOrPhone,
          'password': password,
        });

        CacheHelper.saveData(
            key: CacheKeys.token, value: res.data['access_token']);
        CacheHelper.saveData(key: CacheKeys.id, value: res.data['user']['id']);
        emit(RegisterSuccess(res.data['access_token']));
        return;
      }
      final res = await _networkHelper.post(path: '/login', data: {
        'phone': emailOrPhone,
        'password': password,
      });
      CacheHelper.saveData(
          key: CacheKeys.token, value: res.data['access_token']);
      CacheHelper.saveData(key: CacheKeys.id, value: res.data['user']['id']);
      emit(RegisterSuccess(res.data['access_token']));
    } on DioError catch (e) {
      emit(RegisterError(e.response?.data['error']));
      rethrow;
    }
  }

  logout(context, String token) {
    try {
      HomeCubit.get(context).userModel = null;
      HomeCubit.get(context).pdfModel = null;
      _networkHelper.post(
          path: '/logout',
          headers: {'Authorization': 'Bearer $token'}).then((value) {
        CacheHelper.removeData(CacheKeys.token);
        CacheHelper.removeData(CacheKeys.id);
        C.navToRemove(context, const Login());
      });
    } on DioError catch (e) {
      log(e.toString());
    }
  }
}
