class VerifyOtpBody {
  String? otpEntered;
  String? otpId;
  User? user;

  VerifyOtpBody({this.otpEntered, this.otpId, this.user});

  VerifyOtpBody.fromJson(Map<String, dynamic> json) {
    otpEntered = json['otpEntered'];
    otpId = json['otpId'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otpEntered'] = this.otpEntered;
    data['otpId'] = this.otpId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? name;
  String? mobileNumber;
  String? password;

  User({this.name, this.mobileNumber, this.password});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobileNumber = json['mobileNumber'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobileNumber'] = this.mobileNumber;
    data['password'] = this.password;
    return data;
  }
}