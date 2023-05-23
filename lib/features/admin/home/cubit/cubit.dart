import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_system/features/admin/adminScreens/departments/departmentscreen.dart';
import 'package:student_system/features/admin/adminScreens/subjects/subjectscreen.dart';
import 'package:student_system/features/admin/adminScreens/users/userscreen.dart';
import 'package:student_system/features/admin/home/cubit/states.dart';

class AdminHomeCubit extends Cubit<AdminHomeStates>{
  AdminHomeCubit() : super(AdminHomeInitialState());
  static AdminHomeCubit get(context) => BlocProvider.of(context);
  var currentIndex = 0;
  List<Widget> adminScreens = [
    DepartmentsScreen(),
    SubjectsScreen(),
    UserScreen(),
    // SettingsScreen(),
  ];
  void changeBottomNavBar(index) {
    currentIndex = index;
    emit(AdminHomeBottomNavState());
  }


}