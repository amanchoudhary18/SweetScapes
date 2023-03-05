class SignUpOTPModel {
  String? message;
  String? otpId;

  SignUpOTPModel({this.message, this.otpId});

  SignUpOTPModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    otpId = json['otpId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['otpId'] = this.otpId;
    return data;
  }
}
