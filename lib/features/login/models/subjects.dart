class Subjects {
  String? succss;
  List<Subject>? result;

  Subjects({this.succss, this.result});

  Subjects.fromJson(Map<String, dynamic> json) {
    succss = json['succss'];
    if (json['result'] != null) {
      result = <Subject>[];
      json['result'].forEach((v) {
        result!.add(Subject.fromJson(v));
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

class Subject {
  int? id;
  String? subjectName;
  String? subjectCode;
  String? subjectDeprt;
  String? requireSubject;
  int? grade;
  String? createdAt;
  String? updatedAt;

  Subject(
      {this.id,
      this.subjectName,
      this.subjectCode,
      this.subjectDeprt,
      this.requireSubject,
      this.grade,
      this.createdAt,
      this.updatedAt});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subject_name'];
    subjectCode = json['subject_code'];
    subjectDeprt = json['subject_deprt'];
    requireSubject = json['require_subject'];
    grade = json['grade'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}
