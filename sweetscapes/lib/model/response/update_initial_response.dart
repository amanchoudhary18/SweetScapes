class UpdateInitial_Response {
  String? status;
  List<String>? dining;
  List<String>? outing;

  UpdateInitial_Response({this.status, this.dining, this.outing});

  UpdateInitial_Response.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    dining = json['dining'].cast<String>();
    outing = json['outing'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['dining'] = this.dining;
    data['outing'] = this.outing;
    return data;
  }
}