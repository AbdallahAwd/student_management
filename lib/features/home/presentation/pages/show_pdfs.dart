import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_system/config/Cache/cache_helper.dart';
import 'package:student_system/config/extension/num_extention.dart';
import 'package:student_system/config/extension/string_extention.dart';
import 'package:student_system/config/extension/widget_extension.dart';
import 'package:student_system/config/resources/cache_keys.dart';
import 'package:student_system/features/home/presentation/cubit/home_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/utils/components.dart';
import '../../models/pdf_model.dart';
import '../cubit/home_state.dart';

class ShowPdfs extends StatefulWidget {
  final Result subject;
  const ShowPdfs({
    Key? key,
    required this.subject,
  }) : super(key: key);

  @override
  State createState() => _ShowPdfsState();
}

class _ShowPdfsState extends State<ShowPdfs> {
  final grade = CacheHelper.getData(key: CacheKeys.grade);
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${HomeCubit.get(context).userModel!.user!.grade!.stringifyGrade} Grade",
          style: const TextStyle(color: Colors.grey),
        ),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is UploadPDFSuccess) {
            HomeCubit.get(context).pdfModel = null;
            Future.delayed(
              const Duration(seconds: 2),
              () {
                HomeCubit.get(context).getSubjectPdf(grade);
              },
            );
          }
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);

          if (cubit.pdfModel == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                await cubit.getSubjectPdf(grade);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: widget.subject.pdf!.isEmpty
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    if (widget.subject.pdf!.isEmpty)
                      Center(
                        child: Column(
                          children: <Widget>[
                            const Icon(
                              Icons.picture_as_pdf,
                              size: 100,
                              color: Colors.red,
                            ),
                            10.sbh,
                            'No Pdfs Found'.txt(color: Colors.grey),
                          ],
                        ),
                      ),
                    if (widget.subject.pdf!.isNotEmpty)
                      Row(
                        children: [
                          Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: C.getRandomColor(),
                                  shape: BoxShape.circle),
                              child: Center(
                                child: Text(
                                  widget.subject.subjectName!.firstLetters,
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              )),
                          15.sbw,
                          widget.subject.subjectName!
                              .txt(fontWeight: FontWeight.w500, fontSize: 20)
                        ],
                      ).paddingSymmetric(10, 10),
                    10.sbh,
                    if (widget.subject.pdf!.isNotEmpty)
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 20,
                            color: Colors.red,
                            child: Center(
                                child: 'PDF'.txt(
                                    fontSize: 6,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                          ),
                          10.sbw,
                          'PDF'.txt(fontSize: 20, fontWeight: FontWeight.w600),
                        ],
                      ),
                    30.sbh,
                    if (widget.subject.pdf!.isNotEmpty)
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () async {
                                final path = cubit.getPdfPath(
                                    widget.subject.pdf![index].path!);
                                if (!await launchUrl(Uri.parse(path),
                                    mode: LaunchMode.externalApplication)) {
                                  throw Exception('Could not launch $path');
                                }
                              },
                              leading: const Icon(
                                Icons.picture_as_pdf_rounded,
                                size: 40,
                                color: Colors.red,
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.subject.pdf![index].fileName!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  5.sbh,
                                  Text(
                                    widget.subject.pdf![index].updatedAt!
                                        .convertDateToString,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                              trailing: cubit.userModel!.user!.role! == 'doctor'
                                  ? IconButton(
                                      onPressed: () {
                                        final pdfId =
                                            widget.subject.pdf![index].id;
                                        widget.subject.pdf!.removeAt(index);
                                        cubit.deletePDf(pdfId!);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                      ))
                                  : null,
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: widget.subject.pdf!.length),
                  ],
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton:
          HomeCubit.get(context).userModel!.user!.role! != 'doctor'
              ? const SizedBox()
              : FloatingActionButton(
                  onPressed: () {
                    final subId = widget.subject.id;
                    HomeCubit.get(context).uplaodPdfFile(subId!);
                  },
                  backgroundColor: Colors.red,
                  child: const Icon(
                    Icons.upload_file_outlined,
                  ),
                ),
    );
  }
}
