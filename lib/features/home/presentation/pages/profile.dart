import 'package:flutter/material.dart';
import 'package:student_system/config/extension/context_ex.dart';
import 'package:student_system/config/extension/num_extention.dart';
import 'package:student_system/config/extension/string_extention.dart';
import 'package:student_system/config/extension/widget_extension.dart';
import 'package:student_system/features/home/models/user_model.dart';
import 'package:tap_to_expand/tap_to_expand.dart';

import '../../../../config/utils/components.dart';

class Profile extends StatefulWidget {
  final User user;
  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  State createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isDoctor = false;
  @override
  void initState() {
    super.initState();
    isDoctor = widget.user.role == 'doctor';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: SizedBox(
              width: context.width,
              child: Column(
                children: <Widget>[
                  35.sbh,
                  Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          color: C.getRandomColor(), shape: BoxShape.circle),
                      child: Center(
                        child: Text(
                          widget.user.name!.firstLetters,
                          style: const TextStyle(
                              fontSize: 30, color: Colors.white),
                        ),
                      )),
                  15.sbh,
                  if (!isDoctor)
                    widget.user.name!
                        .txt(fontSize: 25, fontWeight: FontWeight.w500),
                  if (isDoctor)
                    "Dr.${widget.user.name!}"
                        .txt(fontSize: 25, fontWeight: FontWeight.w500),
                  widget.user.role!.txt(fontSize: 12, color: Colors.grey),
                  20.sbh,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      if (!isDoctor)
                        Column(
                          children: <Widget>[
                            '${widget.user.subjects!.length * 3}'
                                .txt(fontSize: 25, fontWeight: FontWeight.w500),
                            'Hours'.txt(fontSize: 15, color: Colors.grey),
                          ],
                        ),
                      Column(
                        children: <Widget>[
                          '${widget.user.subjects!.length}'
                              .txt(fontSize: 25, fontWeight: FontWeight.w500),
                          'Registered'.txt(fontSize: 15, color: Colors.grey),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          widget.user.grade!.stringifyGrade
                              .txt(fontSize: 25, fontWeight: FontWeight.w500),
                          'Grade'.txt(fontSize: 15, color: Colors.grey),
                        ],
                      ),
                    ],
                  ).paddingAll(18),
                  5.sbh,
                  const Divider(),
                  10.sbh,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: 'Basic Details'.txt(
                        color: Colors.grey,
                      )),
                  15.sbh,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      details(
                          icon: Icons.email_outlined,
                          value: widget.user.email!),
                      details(
                          icon: Icons.phone_android_rounded,
                          value: widget.user.phone!),
                    ],
                  ),
                  25.sbh,
                  details(
                      icon: Icons.place,
                      value:
                          '${widget.user.address!.city}, ${widget.user.address!.govern}'),
                  25.sbh,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: 'Subjects'.txt(
                        color: Colors.grey,
                      )),
                  Column(
                    children: List.generate(
                        widget.user.subjects!.length,
                        (index) => TapToExpand(
                              borderRadius: 25,
                              onTapPadding: 20,
                              scrollable: true,
                              openedHeight: context.sh(0.25),
                              color: Colors.grey[300],
                              closedHeight: context.sh(0.1),
                              title: Row(
                                children: <Widget>[
                                  Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: C.getRandomColor(),
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: widget.user.subjects![index]
                                            .subjectName!.firstLetters
                                            .txt(color: Colors.white),
                                      )),
                                  10.sbw,
                                  widget.user.subjects![index].subjectName!.txt(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              content: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    DataTable(
                                      columns: const [
                                        DataColumn(label: Text('ID')),
                                        DataColumn(label: Text('Name')),
                                        DataColumn(label: Text('Code')),
                                        DataColumn(label: Text('Department')),
                                      ],
                                      rows: [
                                        DataRow(cells: [
                                          DataCell(Text(widget
                                              .user.subjects![index].id!
                                              .toString())),
                                          DataCell(Text(widget.user
                                              .subjects![index].subjectName!)),
                                          DataCell(Text(widget.user
                                              .subjects![index].subjectCode!)),
                                          DataCell(Text(widget.user
                                              .subjects![index].subjectDeprt!)),
                                        ]),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget details({
    required String value,
    required IconData icon,
  }) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.grey,
        ),
        10.sbw,
        value.txt()
      ],
    );
  }
}
