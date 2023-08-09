class CreatePlanBody {
  int? planStartTime;
  List<FinalComponents>? finalComponents;

  CreatePlanBody({this.planStartTime, this.finalComponents});

  CreatePlanBody.fromJson(Map<String, dynamic> json) {
    planStartTime = json['plan_start_time'];
    if (json['components'] != null) {
      finalComponents = <FinalComponents>[];
      json['components'].forEach((v) {
        finalComponents!.add(new FinalComponents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plan_start_time'] = this.planStartTime;
    if (this.finalComponents != null) {
      data['components'] = this.finalComponents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FinalComponents {
  int? order;
  String? type;
  String? id;

  FinalComponents({this.order, this.type, this.id});

  FinalComponents.fromJson(Map<String, dynamic> json) {
    order = json['order'];
    type = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order'] = this.order;
    data['type'] = this.type;
    data['id'] = this.id;
    return data;
  }
}