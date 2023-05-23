import 'package:flutter/material.dart';
import 'package:student_system/features/admin/adminScreens/users/model/usermodel.dart';
import 'package:student_system/features/admin/adminScreens/users/model/widgets/useritem.dart';

class UserScreen extends StatefulWidget {
  UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton:
            FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter text to search";
                  } else {
                    return null;
                  }
                },
                onChanged: (String text) {},
                controller: searchController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    label: Text("Search"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Dismissible(
                        key: UniqueKey(),
                        background: Container(),
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
                        child: UserItem(
                            itemIndex: index, userModel: userList[index]));
                  },
                  itemCount: userList.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // void search(String query){
  //   final search=userList.where((element) {
  //     final usertitle=userList[index].userName!.toLowerCase();
  //     final input=query.toLowerCase();
  //     return usertitle.contains(input);
  //   }).toList();
  //   setState(() {
  //     userList=search;
  //   });
  // }
}
