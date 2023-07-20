import 'dart:convert';

class VerifyOtpBody {
  String? otpEntered;
  String? otpId;
  User? user;

  VerifyOtpBody({this.otpEntered, this.otpId, this.user});

  VerifyOtpBody.fromJson(Map<String, dynamic> json) {
    otpEntered = json['otpEntered'];
    otpId = json['otpId'];
    user =
        json['user'] != null ? User.fromJson(jsonDecode(json['user'])) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otpEntered'] = this.otpEntered;
    data['otpId'] = this.otpId;
    data['user'] = JsonEncoder.withIndent('  ').convert(this.user);
    return data;
  }
}

class User {
  String? email;

  User({this.email});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    return data;
  }
}
