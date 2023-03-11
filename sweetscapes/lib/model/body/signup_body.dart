class SignupBody {
  String? mobileNumber;

  SignupBody({this.mobileNumber});

  SignupBody.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobileNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileNumber'] = this.mobileNumber;
    return data;
  }
}