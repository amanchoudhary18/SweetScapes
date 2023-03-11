class VerifyOtpBody {
  String? otpEntered;
  String? otpId;

  VerifyOtpBody({this.otpEntered, this.otpId});

  VerifyOtpBody.fromJson(Map<String, dynamic> json) {
    otpEntered = json['otpEntered'];
    otpId = json['otpId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otpEntered'] = this.otpEntered;
    data['otpId'] = this.otpId;
    return data;
  }
}