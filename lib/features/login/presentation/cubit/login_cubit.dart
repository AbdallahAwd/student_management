import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_system/config/Network/dio_helper.dart';
import 'package:student_system/config/resources/cache_keys.dart';

import '../../../../config/Cache/cache_helper.dart';
import '../../models/address.dart';
import '../../models/subjects.dart';
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
        "subjects": subjectModel!.toJson()['result']
      });

      Cache.saveData(key: CacheKeys.token, value: res.data['access_token']);
      Cache.saveData(key: CacheKeys.role, value: role);
      emit(RegisterSuccess());
    } on DioError catch (e) {
      emit(RegisterError(e.response!.data.toString()));
      log(e.response!.data!);
      rethrow;
    }
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

        Cache.saveData(key: CacheKeys.token, value: res.data['access_token']);
        Cache.saveData(key: CacheKeys.role, value: res.data['user']['role']);
        emit(RegisterSuccess());
        return;
      }
      final res = await _networkHelper.post(path: '/login', data: {
        'phone': emailOrPhone,
        'password': password,
      });
      Cache.saveData(key: CacheKeys.token, value: res.data['access_token']);
      Cache.saveData(key: CacheKeys.role, value: res.data['user']['role']);
      emit(RegisterSuccess());
    } on DioError catch (e) {
      emit(RegisterError(e.response!.data.toString()));
      rethrow;
    }
  }
}
