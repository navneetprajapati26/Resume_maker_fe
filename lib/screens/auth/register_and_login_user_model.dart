class RegisterUser {
  String? name;
  String? email;
  String? password;

  RegisterUser({this.name, this.email, this.password});

  RegisterUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}

class Login {
  String? email;
  String? password;

  Login({this.email, this.password});

  Login.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}


class User {
  String? sId;
  String? name;
  String? email;
  String? password;
  List<String>? resumes;
  int? iV;

  User({this.sId, this.name, this.email, this.password, this.resumes, this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    resumes = json['resumes'].cast<String>();
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['resumes'] = this.resumes;
    data['__v'] = this.iV;
    return data;
  }
}
