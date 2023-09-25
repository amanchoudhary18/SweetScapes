class GetRecentPlansResponse {
  String? status;
  List<UserRecentPlans>? userRecentPlans;

  GetRecentPlansResponse({this.status, this.userRecentPlans});

  GetRecentPlansResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['user_recent_plans'] != null) {
      userRecentPlans = <UserRecentPlans>[];
      json['user_recent_plans'].forEach((v) {
        userRecentPlans!.add(new UserRecentPlans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.userRecentPlans != null) {
      data['user_recent_plans'] =
          this.userRecentPlans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserRecentPlans {
  int? planStartTime;
  String? id;
  String? tileContent;
  List<Tags>? tags;

  UserRecentPlans({this.planStartTime, this.id, this.tileContent, this.tags});

  UserRecentPlans.fromJson(Map<String, dynamic> json) {
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