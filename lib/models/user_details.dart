class UserModel {
  String? userid;
  String? email;
  String? firstname;
  String? secondname;
  UserModel({this.userid, this.email, this.firstname, this.secondname});
  //fetch data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        userid: map["userid"],
        email: map["email"],
        firstname: map['firstname'],
        secondname: map["secondname"]);
  }
  //sending data to server
  Map<String, dynamic> toMap() {
    return {
      "userid": userid,
      "email": email,
      "firstname": firstname,
      "secondname": secondname
    };
  }
}
