class SignupBody {
  String? name;
  String? mobileNumber;
  String? password;

  SignupBody({this.name, this.mobileNumber, this.password});

  SignupBody.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    mobileNumber = json['mobileNumber'];
    password = json['password'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['name'] = this.name;
    data['mobileNumber'] = this.mobileNumber;
    data['password'] = this.password;
    return data;
  }
}