class GetUpcomingPlansResponse {
  String? status;
  List<UserUpcomingPlans>? userUpcomingPlans;

  GetUpcomingPlansResponse({this.status, this.userUpcomingPlans});

  GetUpcomingPlansResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['user_upcoming_plans'] != null) {
      userUpcomingPlans = <UserUpcomingPlans>[];
      json['user_upcoming_plans'].forEach((v) {
        userUpcomingPlans!.add(new UserUpcomingPlans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.userUpcomingPlans != null) {
      data['user_upcoming_plans'] =
          this.userUpcomingPlans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserUpcomingPlans {
  int? planStartTime;
  String? id;
  String? tileContent;
  List<Tags>? tags;

  UserUpcomingPlans({this.planStartTime, this.id, this.tileContent, this.tags});

  UserUpcomingPlans.fromJson(Map<String, dynamic> json) {
    planStartTime = json['plan_start_time'];
    id = json['id'];
    tileContent = json['tile_content'];
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(new Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plan_start_time'] = this.planStartTime;
    data['id'] = this.id;
    data['tile_content'] = this.tileContent;
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tags {
  int? order;
  String? tag;

  Tags({this.order, this.tag});

  Tags.fromJson(Map<String, dynamic> json) {
    order = json['order'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order'] = this.order;
    data['tag'] = this.tag;
    return data;
  }
}