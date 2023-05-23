import 'package:flutter/material.dart';
import 'package:student_system/features/admin/adminScreens/subjects/model/subjectmode.dart';

class SubjectItem extends StatelessWidget {
  const SubjectItem({Key? key, required this.itemIndex, required this.subjectModel}) : super(key: key);
  final int itemIndex;
  final SubjectModel subjectModel;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20,right: 20,left: 20,bottom: 10),
      child: Container(
        width: double.infinity,
        height: 180,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          boxShadow:const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(10, 20),
              blurRadius: 20,
              spreadRadius: 20,
            )
          ],
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
                      "${subjectModel.subjectName}",
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
                Text("Required: ${subjectModel.requireSubject}"),
                SizedBox(height: 5,),
                Text("Code: ${subjectModel.subjectCode}"),
                Text("Department: ${subjectModel.subjectDepart}"),
                Text("Grade: ${subjectModel.grade}"),
              ],
            )
          ],
        ),

      ),
    );
  }
}
