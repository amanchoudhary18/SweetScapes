class GetAllPlans {
  String? status;
  List<CompletedAllPlans>? completedAllPlans;

  GetAllPlans({this.status, this.completedAllPlans});

  GetAllPlans.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['completedAllPlans'] != null) {
      completedAllPlans = <CompletedAllPlans>[];
      json['completedAllPlans'].forEach((v) {
        completedAllPlans!.add(new CompletedAllPlans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.completedAllPlans != null) {
      data['completedAllPlans'] =
          this.completedAllPlans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompletedAllPlans {
  String? id;
  List<String>? tags;
  List<Images>? images;
  Availability? availability;
  int? planStartTime;
  int? price;
  String? tileContent;
  double? likeness;

  CompletedAllPlans(
      {this.id,
      this.tags,
      this.images,
      this.availability,
      this.planStartTime,
      this.price,
      this.tileContent,
      this.likeness});

  CompletedAllPlans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tags = json['tags'].cast<String>();
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    availability = json['availability'] != null
        ? new Availability.fromJson(json['availability'])
        : null;
    planStartTime = json['plan_start_time'];
    price = json['price'];
    tileContent = json['tile_content'];
    likeness = json['likeness'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tags'] = this.tags;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.availability != null) {
      data['availability'] = this.availability!.toJson();
    }
    data['plan_start_time'] = this.planStartTime;
    data['price'] = this.price;
    data['tile_content'] = this.tileContent;
    data['likeness'] = this.likeness;
    return data;
  }
}

class Images {
  String? imgLink;
  String? imgName;
  int? order;

  Images({this.imgLink, this.imgName, this.order});

  Images.fromJson(Map<String, dynamic> json) {
    imgLink = json['img_link'];
    imgName = json['img_name'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img_link'] = this.imgLink;
    data['img_name'] = this.imgName;
    data['order'] = this.order;
    return data;
  }
}

class Availability {
  bool? sunday;
  bool? monday;
  bool? tuesday;
  bool? wednesday;
  bool? thursday;
  bool? friday;
  bool? saturday;

  Availability(
      {this.sunday,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday});

  Availability.fromJson(Map<String, dynamic> json) {
    sunday = json['sunday'];
    monday = json['monday'];
    tuesday = json['tuesday'];
    wednesday = json['wednesday'];
    thursday = json['thursday'];
    friday = json['friday'];
    saturday = json['saturday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sunday'] = this.sunday;
    data['monday'] = this.monday;
    data['tuesday'] = this.tuesday;
    data['wednesday'] = this.wednesday;
    data['thursday'] = this.thursday;
    data['friday'] = this.friday;
    data['saturday'] = this.saturday;
    return data;
  }
}