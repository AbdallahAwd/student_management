import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_system/config/extension/context_ex.dart';
import 'package:student_system/config/extension/num_extention.dart';
import 'package:student_system/config/extension/string_extention.dart';
import 'package:student_system/config/extension/widget_extension.dart';
import 'package:student_system/features/home/models/pdf_model.dart';
import 'package:student_system/features/home/models/user_model.dart';
import 'package:student_system/features/home/presentation/pages/show_pdfs.dart';

import '../../../../config/utils/components.dart';

class StudentOrDoctorBuilder extends StatefulWidget {
  final User user;
  final List<Result> subjects;
  const StudentOrDoctorBuilder(
      {Key? key, required this.user, required this.subjects})
      : super(key: key);

  @override
  State<StudentOrDoctorBuilder> createState() => _StudentOrDoctorBuilderState();
}

class _StudentOrDoctorBuilderState extends State<StudentOrDoctorBuilder> {
  @override
  void initState() {
    super.initState();
    registeredSubjects();
  }

  List registeredSubjects() {
    final subjects = widget.subjects.map((e) => e.subjectName).toList();
    final userSubjects =
        widget.user.subjects!.map((e) => e.subjectName).toList();

    return subjects.where((element) => userSubjects.contains(element)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    'Good Morning, '.txt(
                      fontSize: 15,
                    ),
                    (widget.user.name![0].toUpperCase() +
                            widget.user.name!.substring(1))
                        .txt(fontSize: 15, fontWeight: FontWeight.w600)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 8, right: 8),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,
                                  blurStyle: BlurStyle.outer),
                            ],
                            borderRadius: BorderRadius.circular(22)),
                        child: Column(
                          children: <Widget>[
                            SvgPicture.asset(
                              'course'.toSvg,
                            ),
                            10.sbh,
                            '${widget.subjects.length}'
                                .txt(fontSize: 35, fontWeight: FontWeight.w600),
                            10.sbh,
                            'Courses Available'.txt(
                              fontSize: 15,
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: context.sw(0.44),
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,
                                  blurStyle: BlurStyle.outer),
                            ],
                            borderRadius: BorderRadius.circular(22)),
                        child: Column(
                          children: <Widget>[
                            SvgPicture.asset(
                              'rcourse'.toSvg,
                            ),
                            10.sbh,
                            '${registeredSubjects().length}'
                                .txt(fontSize: 35, fontWeight: FontWeight.w600),
                            10.sbh,
                            'Registered'.txt(
                              fontSize: 15,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                50.sbh,
                Container(
                  width: context.width,
                  height: context.sh(0.54),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(22),
                          topRight: Radius.circular(22)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10,
                            blurStyle: BlurStyle.outer),
                      ]),
                  child: Column(
                    children: <Widget>[
                      3.sbh,
                      Container(
                        height: 8,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(22)),
                      ),
                      20.sbh,
                      Align(
                              alignment: Alignment.centerLeft,
                              child: 'Top Classes'.txt(
                                  fontWeight: FontWeight.w600, fontSize: 25))
                          .paddingSymmetric(20, 0),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                                widget.subjects.length,
                                (index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 18.0),
                                      child: InkWell(
                                        onTap: () {
                                          if (!registeredSubjects().contains(
                                              widget.subjects[index]
                                                  .subjectName!)) {
                                            C.snack(context,
                                                'You\'re not registed in this subject');
                                            return;
                                          }
                                          C.navToDown(
                                              context,
                                              ShowPdfs(
                                                  subject:
                                                      widget.subjects[index]));
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    color: C.getRandomColor(),
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                  child: Text(
                                                    widget
                                                        .subjects[index]
                                                        .subjectName!
                                                        .firstLetters,
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white),
                                                  ),
                                                )).paddingSymmetric(10, 0),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    '${widget.subjects[index].subjectName}'
                                                        .txt(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                    5.sbw,
                                                    const CircleAvatar(
                                                      radius: 4,
                                                    ),
                                                    5.sbw,
                                                    '${widget.subjects[index].subjectCode}'
                                                        .txt(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ],
                                                ),
                                                5.sbh,
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 10,
                                                      width: 20,
                                                      color: Colors.red,
                                                      child: Center(
                                                          child: 'PDF'.txt(
                                                              fontSize: 6,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                    ),
                                                    5.sbw,
                                                    '${widget.subjects[index].pdf!.length} PDFS'
                                                        .txt(
                                                            color: Colors.grey,
                                                            fontSize: 12),
                                                    8.sbw,
                                                    const CircleAvatar(
                                                      radius: 4,
                                                      backgroundColor:
                                                          Colors.red,
                                                    ),
                                                    5.sbw,
                                                    widget.subjects[index]
                                                        .subjectDeprt!
                                                        .txt(),
                                                    10.sbw,
                                                    widget
                                                        .subjects[index]
                                                        .updatedAt!
                                                        .convertDateToString
                                                        .txt(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.grey,
                                                            fontSize: 12),
                                                  ],
                                                )
                                              ],
                                            ),
                                            const Spacer(),
                                            if (registeredSubjects().contains(
                                                widget.subjects[index]
                                                    .subjectName!))
                                              const Icon(Icons.arrow_forward),
                                            if (!registeredSubjects().contains(
                                                widget.subjects[index]
                                                    .subjectName!))
                                              const Icon(
                                                  Icons.lock_clock_outlined),
                                          ],
                                        ),
                                      ),
                                    )),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
