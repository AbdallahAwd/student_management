import 'package:flutter/material.dart';
import 'package:student_system/features/admin/adminScreens/departments/model/departmentModel.dart';

class DepartmentItem extends StatelessWidget {
  const DepartmentItem({Key? key, required this.itemIndex, required this.departmentModel}) : super(key: key);
  final int itemIndex;
  final DepartmentModel departmentModel;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20,right: 20,left: 20,bottom: 10),
      child: Container(
        width: double.infinity,
        height: 150,
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
                      departmentModel.title!,
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
                Text('StudentNumber: ${departmentModel.sNum}'),
                SizedBox(height: 5,),
                Text("Code: ${departmentModel.abv!}",style: TextStyle(
                    color: Colors.grey
                ),)
              ],
            )
          ],
        ),

      ),
    );
  }
}
