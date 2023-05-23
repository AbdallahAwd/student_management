class PdfModel {
  String? succss;
  List<Result>? result;

  PdfModel({this.succss, this.result});

  PdfModel.fromJson(Map<String, dynamic> json) {
    succss = json['succss'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['succss'] = succss;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? id;
  String? subjectName;
  String? subjectCode;
  String? subjectDeprt;
  String? requireSubject;
  int? grade;
  String? createdAt;
  String? updatedAt;
  List<Pdf>? pdf;

  Result(
      {this.id,
      this.subjectName,
      this.subjectCode,
      this.subjectDeprt,
      this.requireSubject,
      this.grade,
      this.createdAt,
      this.updatedAt,
      this.pdf});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subject_name'];
    subjectCode = json['subject_code'];
    subjectDeprt = json['subject_deprt'];
    requireSubject = json['require_subject'];
    grade = json['grade'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['pdf'] != null) {
      pdf = <Pdf>[];
      json['pdf'].forEach((v) {
        pdf!.add(Pdf.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subject_name'] = subjectName;
    data['subject_code'] = subjectCode;
    data['subject_deprt'] = subjectDeprt;
    data['require_subject'] = requireSubject;
    data['grade'] = grade;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pdf != null) {
      data['pdf'] = pdf!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pdf {
  int? id;
  String? path;
  String? fileName;
  int? subjectId;
  String? createdAt;
  String? updatedAt;

  Pdf(
      {this.id,
      this.path,
      this.fileName,
      this.subjectId,
      this.createdAt,
      this.updatedAt});

  Pdf.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    fileName = json['fileName'];
    subjectId = json['subject_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['path'] = path;
    data['fileName'] = fileName;
    data['subject_id'] = subjectId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
