class SignUpOTPModel {
  String? status;
  String? message;
  String? otpId;

  SignUpOTPModel({this.status, this.message, this.otpId});

  SignUpOTPModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    otpId = json['otpId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['otpId'] = this.otpId;
    return data;
  }
}