import 'package:flutter/material.dart';
import 'package:student_system/features/admin/adminScreens/subjects/model/subjectmode.dart';
import 'package:student_system/features/admin/adminScreens/users/model/usermodel.dart';

class UserItem extends StatelessWidget {
  const UserItem({Key? key, required this.itemIndex, required this.userModel}) : super(key: key);
  final int itemIndex;
  final UserModel userModel;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: double.infinity,
        height: 150,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(

          gradient: LinearGradient(colors: [
            Color(0xFFD3BFBF),
            Color(0xFF755EE8),
            Colors.purpleAccent,
            Colors.amber,
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${userModel.userName}",
                      style: TextStyle(color: Colors.black,fontFamily: "monospace",fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Stack(
                      children: List.generate(
                        2,
                            (index) => Container(
                          margin: EdgeInsets.only(left: (15 * index).toDouble()),
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white54),
                        ),
                      ),
                    ) ,
                  ],
                ),
                Text("${userModel.email}"),
                SizedBox(height: 5,),
                Text("${userModel.phone}"),
              ],
            )
          ],
        ),

      ),
    );
  }
}
