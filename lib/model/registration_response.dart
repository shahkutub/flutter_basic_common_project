class RegistrationResponse {
  bool? success;
  String? message;
  UserInfo? user;
  String? token;
  Errors? errors;

  RegistrationResponse(
      {this.success, this.message, this.user, this.token, this.errors});

  RegistrationResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    user = json['user'] != null ? new UserInfo.fromJson(json['user']) : null;
    token = json['token'];
    errors =
    json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    return data;
  }
}

class UserInfo {
  String? name;
  String? mobileNo;
  String? email;
  String? profession;
  String? department;
  int? status;
  String? updatedAt;
  String? createdAt;
  int? id;
  VerificationToken? verificationToken;

  UserInfo(
      {this.name,
        this.mobileNo,
        this.email,
        this.profession,
        this.department,
        this.status,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.verificationToken});

  UserInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobileNo = json['mobile_no'];
    email = json['email'];
    profession = json['profession'];
    department = json['department'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    verificationToken = json['verification_token'] != null
        ? new VerificationToken.fromJson(json['verification_token'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile_no'] = this.mobileNo;
    data['email'] = this.email;
    data['profession'] = this.profession;
    data['department'] = this.department;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    if (this.verificationToken != null) {
      data['verification_token'] = this.verificationToken!.toJson();
    }
    return data;
  }
}

class VerificationToken {
  int? id;
  int? userId;
  String? token;
  String? createdAt;
  String? updatedAt;

  VerificationToken(
      {this.id, this.userId, this.token, this.createdAt, this.updatedAt});

  VerificationToken.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    token = json['token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['token'] = this.token;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Errors {
  List<String>? mobile;
  List<String>? email;
  List<String>? password;
  String? msg;

  Errors({this.mobile, this.email, this.password,this.msg});

  Errors.fromJson(Map<String, dynamic> json) {
    bool msgMobile = json.keys.contains('mobile');
    bool msgEmail = json.keys.contains('email');
    bool msgPass = json.keys.contains('password');

    if(msgMobile){
      mobile = json['mobile'].cast<String>();
      msg = mobile![0].toString();
    }

    if(msgEmail){
      email = json['email'].cast<String>();
      msg = email![0].toString();
    }

    if(msgPass){
      password = json['password'].cast<String>();
      msg = password![0].toString();
    }



  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}