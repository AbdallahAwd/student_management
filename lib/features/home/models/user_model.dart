class UserInfoModel {
  User? user;

  UserInfoModel({this.user});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  int? grade;
  String? phone;
  String? role;
  String? createdAt;
  String? updatedAt;
  Address? address;
  List<Subjects>? subjects;

  User(
      {this.id,
      this.name,
      this.email,
      this.grade,
      this.phone,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.address,
      this.subjects});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    grade = json['grade'];
    phone = json['phone'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['grade'] = grade;
    data['phone'] = phone;
    data['role'] = role;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  int? id;
  String? govern;
  String? city;
  String? createdAt;
  String? updatedAt;

  Address({this.id, this.govern, this.city, this.createdAt, this.updatedAt});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    govern = json['govern'];
    city = json['city'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['govern'] = govern;
    data['city'] = city;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Subjects {
  int? id;
  String? subjectName;
  String? subjectCode;
  String? subjectDeprt;
  String? createdAt;
  String? updatedAt;

  Subjects(
      {this.id,
      this.subjectName,
      this.subjectCode,
      this.subjectDeprt,
      this.createdAt,
      this.updatedAt});

  Subjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subject_name'];
    subjectCode = json['subject_code'];
    subjectDeprt = json['subject_deprt'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subject_name'] = subjectName;
    data['subject_code'] = subjectCode;
    data['subject_deprt'] = subjectDeprt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
