class User {
  int? id;
  String? name;
  String? email;
  String? mobile;

  User({this.id, this.name, this.email, this.mobile});

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile_no'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile_no'] = mobile;
    return data;
  }
}

class Team {
  String? name;
  String? image;
  String? designation;
  String? team;
  String? mobileNo;
  String? officeName;

  Team({this.name, this.image, this.designation, this.mobileNo, this.team, this.officeName});
}