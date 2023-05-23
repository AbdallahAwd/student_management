class UserModel{
  String? userName;
  String? email;
  String? phone;
  String? role;
  int? grade;



  UserModel(this.userName, this.email,this.phone,this.role,this.grade);




}

List<UserModel> userList=[
  new UserModel("Mhmoud Ahmed","Mhmoudsyd27@gmail.com","01121346770","Student",3),
  new UserModel("Ali Ahmed","AliEbrahem@gmail.com","02321344570","Student",2),
  new UserModel("Aya","Aya@gmail.com","023219854570","Student",1),
  new UserModel("Zed","Zed@gmail.com","03241344570","Student",1),

];