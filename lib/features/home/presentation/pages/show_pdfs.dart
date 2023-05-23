import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_system/config/Cache/cache_helper.dart';
import 'package:student_system/config/extension/num_extention.dart';
import 'package:student_system/config/extension/string_extention.dart';
import 'package:student_system/config/resources/cache_keys.dart';
import 'package:student_system/features/home/presentation/cubit/home_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubit/home_state.dart';

class ShowPdfs extends StatefulWidget {
  final String subject;
  final int subIndex;
  const ShowPdfs({Key? key, required this.subject, required this.subIndex})
      : super(key: key);

  @override
  State createState() => _ShowPdfsState();
}

class _ShowPdfsState extends State<ShowPdfs> {
  final grade = Cache.getData(key: CacheKeys.grade);
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
        title: Text(widget.subject),
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
          log(widget.subIndex.toString());
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
                  mainAxisAlignment:
                      cubit.pdfModel!.result![widget.subIndex].pdf!.isEmpty
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.start,
                  children: [
                    if (cubit.pdfModel!.result![widget.subIndex].pdf!.isEmpty)
                      Center(
                        child: Column(
                          children: <Widget>[
                            const Icon(
                              Icons.picture_as_pdf,
                              size: 50,
                            ),
                            10.sbh,
                            'No Pdfs Found'.txt(),
                          ],
                        ),
                      ),
                    if (cubit
                        .pdfModel!.result![widget.subIndex].pdf!.isNotEmpty)
                      'PDF'.txt(fontSize: 20, fontWeight: FontWeight.w600),
                    30.sbh,
                    if (cubit
                        .pdfModel!.result![widget.subIndex].pdf!.isNotEmpty)
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () async {
                                final path = cubit.getPdfPath(cubit
                                    .pdfModel!
                                    .result![widget.subIndex]
                                    .pdf![index]
                                    .path!);
                                if (!await launchUrl(Uri.parse(path),
                                    mode: LaunchMode.externalApplication)) {
                                  throw Exception('Could not launch $path');
                                }
                              },
                              leading: const Icon(
                                Icons.picture_as_pdf_rounded,
                                size: 40,
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  '${cubit.pdfModel!.result![widget.subIndex].pdf![index].fileName}'
                                      .txt(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                  5.sbh,
                                  Text(
                                    cubit
                                        .pdfModel!
                                        .result![widget.subIndex]
                                        .pdf![index]
                                        .updatedAt!
                                        .convertDateToString,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                              trailing: cubit.userModel!.user!.role! == 'doctor'
                                  ? IconButton(
                                      onPressed: () {
                                        final pdfId = cubit
                                            .pdfModel!
                                            .result![widget.subIndex]
                                            .pdf![index]
                                            .id;
                                        cubit.pdfModel!.result![widget.subIndex]
                                            .pdf!
                                            .removeAt(index);
                                        cubit.deletePDf(pdfId!);
                                      },
                                      icon: const Icon(Icons.delete))
                                  : null,
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: cubit
                              .pdfModel!.result![widget.subIndex].pdf!.length),
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
                    final subId = HomeCubit.get(context)
                        .pdfModel!
                        .result![widget.subIndex]
                        .id;
                    HomeCubit.get(context).uplaodPdfFile(subId!);
                  },
                  child: const Icon(Icons.upload_file_outlined),
                ),
    );
  }
}
