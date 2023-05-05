class DateListResponse {
  String? status;
  List<DateData>? dateData;

  DateListResponse({this.status, this.dateData});

  DateListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['dateData'] != null) {
      dateData = <DateData>[];
      json['dateData'].forEach((v) {
        dateData!.add(new DateData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.dateData != null) {
      data['dateData'] = this.dateData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DateData {
  String? category;
  Availability? availability;
  String? area;
  int? peopleCount;
  String? tileContent;
  int? pricePerHead;
  String? sId;

  DateData(
      {this.category,
      this.availability,
      this.area,
      this.peopleCount,
      this.tileContent,
      this.pricePerHead,
      this.sId});

  DateData.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    availability = json['availability'] != null
        ? new Availability.fromJson(json['availability'])
        : null;
    area = json['area'];
    peopleCount = json['people_count'];
    tileContent = json['tile_content'];
    pricePerHead = json['price_per_head'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    if (this.availability != null) {
      data['availability'] = this.availability!.toJson();
    }
    data['area'] = this.area;
    data['people_count'] = this.peopleCount;
    data['tile_content'] = this.tileContent;
    data['price_per_head'] = this.pricePerHead;
    data['_id'] = this.sId;
    return data;
  }
}

class Availability {
  bool? monday;
  bool? tuesday;
  bool? wednesday;
  bool? thursday;
  bool? friday;
  bool? saturday;
  bool? sunday;

  Availability(
      {this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.sunday});

  Availability.fromJson(Map<String, dynamic> json) {
    monday = json['monday'];
    tuesday = json['tuesday'];
    wednesday = json['wednesday'];
    thursday = json['thursday'];
    friday = json['friday'];
    saturday = json['saturday'];
    sunday = json['sunday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['monday'] = this.monday;
    data['tuesday'] = this.tuesday;
    data['wednesday'] = this.wednesday;
    data['thursday'] = this.thursday;
    data['friday'] = this.friday;
    data['saturday'] = this.saturday;
    data['sunday'] = this.sunday;
    return data;
  }
}