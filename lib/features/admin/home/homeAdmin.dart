import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_system/features/admin/home/cubit/cubit.dart';
import 'package:student_system/features/admin/home/cubit/states.dart';

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) =>AdminHomeCubit(),
      child: BlocConsumer<AdminHomeCubit,AdminHomeStates>(
          listener: (context,state){

          },
          builder: (context,state){
            var cubit=AdminHomeCubit.get(context);
            return Scaffold(
              body: cubit.adminScreens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_tree_outlined),
                    label: 'Departments',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.subject),
                    label: 'Subjects',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_box),
                    label: 'Users',
                  ),
                  // BottomNavigationBarItem(
                  //   icon: Icon(Icons.settings),
                  //   label: 'Settings',
                  // ),
                ],
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNavBar(index);
                },
              ),
            );
          }

      )
    );

  }
}
