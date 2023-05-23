class SubjectModel {
  String? subjectName;
  String? subjectCode;
  String? subjectDepart;
  String? requireSubject;
  int? grade;


  SubjectModel(this.subjectName, this.subjectCode,this.subjectDepart,this.requireSubject,this.grade);
}


List<SubjectModel> subjectList=[
  new SubjectModel("Machine Learning", "ML", "CS","Artifical Intelligent",3),
  new SubjectModel("Machine Learning", "ML", "CS","Artifical Intelligent",3),
  new SubjectModel("Machine Learning", "ML", "CS","Artifical Intelligent",3),
  new SubjectModel("Machine Learning", "ML", "CS","Artifical Intelligent",3),
  new SubjectModel("Machine Learning", "ML", "CS","Artifical Intelligent",3),
  new SubjectModel("Machine Learning", "ML", "CS","Artifical Intelligent",3),

];