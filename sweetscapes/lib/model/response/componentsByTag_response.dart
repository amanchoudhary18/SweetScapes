import 'package:sweetscapes/model/response/getAllPlans_response.dart';

class ComponentsByTagResponse {
  String? status;
  List<Components>? components;

  ComponentsByTagResponse({this.status, this.components});

  ComponentsByTagResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['components'] != null) {
      components = <Components>[];
      json['components'].forEach((v) {
        components!.add(new Components.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.components != null) {
      data['components'] = this.components!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}