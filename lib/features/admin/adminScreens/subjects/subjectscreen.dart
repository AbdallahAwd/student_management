import 'package:card_actions/card_action_button.dart';
import 'package:card_actions/card_actions.dart';
import 'package:flutter/material.dart';
import 'package:student_system/features/admin/adminScreens/departments/widgets/departmentItem.dart';
import 'package:student_system/features/admin/adminScreens/departments/model/departmentModel.dart';
import 'package:student_system/features/admin/adminScreens/subjects/model/subjectmode.dart';
import 'package:student_system/features/admin/adminScreens/subjects/widgets/subjectitem.dart';

class SubjectsScreen extends StatelessWidget {
  SubjectsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add),
          ),
          body: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: subjectList.length,
              itemBuilder: (context, index) {
                return Dismissible(
                    key: UniqueKey(),
                    background: Container(

                    ),
                    secondaryBackground: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color:Colors.redAccent ,
                        boxShadow:const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(10, 20),
                            blurRadius: 20,
                            spreadRadius: 20,
                          )
                        ],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: SubjectItem(
                      itemIndex: index,
                      subjectModel: subjectList[index],
                    ));
              })),
    );
  }
}
