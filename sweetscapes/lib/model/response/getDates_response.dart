class GetDates {
  String? status;
  List<Date>? date;

  GetDates({this.status, this.date});

  GetDates.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['date'] != null) {
      date = <Date>[];
      json['date'].forEach((v) {
        date!.add(new Date.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.date != null) {
      data['date'] = this.date!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Date {
  double? likeness;
  String? category;
  Availability? availability;
  String? area;
  PeopleCount? peopleCount;
  String? tileContent;
  int? pricePerHead;
  Tags? tags;
  String? sId;

  Date(
      {this.likeness,
      this.category,
      this.availability,
      this.area,
      this.peopleCount,
      this.tileContent,
      this.pricePerHead,
      this.tags,
      this.sId});

  Date.fromJson(Map<String, dynamic> json) {
    likeness = json['likeness'];
    category = json['category'];
    availability = json['availability'] != null
        ? new Availability.fromJson(json['availability'])
        : null;
    area = json['area'];
    peopleCount = json['people_count'] != null
        ? new PeopleCount.fromJson(json['people_count'])
        : null;
    tileContent = json['tile_content'];
    pricePerHead = json['price_per_head'];
    tags = json['tags'] != null ? new Tags.fromJson(json['tags']) : null;
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['likeness'] = this.likeness;
    data['category'] = this.category;
    if (this.availability != null) {
      data['availability'] = this.availability!.toJson();
    }
    data['area'] = this.area;
    if (this.peopleCount != null) {
      data['people_count'] = this.peopleCount!.toJson();
    }
    data['tile_content'] = this.tileContent;
    data['price_per_head'] = this.pricePerHead;
    if (this.tags != null) {
      data['tags'] = this.tags!.toJson();
    }
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

class PeopleCount {
  bool? couple;
  bool? small;
  bool? medium;
  bool? large;

  PeopleCount({this.couple, this.small, this.medium, this.large});

  PeopleCount.fromJson(Map<String, dynamic> json) {
    couple = json['couple'];
    small = json['small'];
    medium = json['medium'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['couple'] = this.couple;
    data['small'] = this.small;
    data['medium'] = this.medium;
    data['large'] = this.large;
    return data;
  }
}

class Tags {
  Dine? dine;
  Outing? outing;

  Tags({this.dine, this.outing});

  Tags.fromJson(Map<String, dynamic> json) {
    dine = json['Dine'] != null ? new Dine.fromJson(json['Dine']) : null;
    outing =
        json['Outing'] != null ? new Outing.fromJson(json['Outing']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dine != null) {
      data['Dine'] = this.dine!.toJson();
    }
    if (this.outing != null) {
      data['Outing'] = this.outing!.toJson();
    }
    return data;
  }
}

class Dine {
  int? decentDining;
  int? streetfood;
  int? fineDining;
  int? dhabas;
  int? homeDelivery;
  int? takeAway;
  int? homeMade;
  int? cafes;

  Dine(
      {this.decentDining,
      this.streetfood,
      this.fineDining,
      this.dhabas,
      this.homeDelivery,
      this.takeAway,
      this.homeMade,
      this.cafes});

  Dine.fromJson(Map<String, dynamic> json) {
    decentDining = json['Decent_Dining'];
    streetfood = json['Streetfood'];
    fineDining = json['Fine_Dining'];
    dhabas = json['Dhabas'];
    homeDelivery = json['Home_Delivery'];
    takeAway = json['Take_Away'];
    homeMade = json['Home_Made'];
    cafes = json['Cafes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Decent_Dining'] = this.decentDining;
    data['Streetfood'] = this.streetfood;
    data['Fine_Dining'] = this.fineDining;
    data['Dhabas'] = this.dhabas;
    data['Home_Delivery'] = this.homeDelivery;
    data['Take_Away'] = this.takeAway;
    data['Home_Made'] = this.homeMade;
    data['Cafes'] = this.cafes;
    return data;
  }
}

class Outing {
  int? malls;
  int? park;
  int? hillsLakes;
  int? damsWaterfalls;
  int? movie;
  int? picnics;
  int? clubbing;
  int? nightOut;
  int? windowShopping;

  Outing(
      {this.malls,
      this.park,
      this.hillsLakes,
      this.damsWaterfalls,
      this.movie,
      this.picnics,
      this.clubbing,
      this.nightOut,
      this.windowShopping});

  Outing.fromJson(Map<String, dynamic> json) {
    malls = json['Malls'];
    park = json['Park'];
    hillsLakes = json['Hills_Lakes'];
    damsWaterfalls = json['Dams_Waterfalls'];
    movie = json['Movie'];
    picnics = json['Picnics'];
    clubbing = json['Clubbing'];
    nightOut = json['Night_Out'];
    windowShopping = json['Window_Shopping'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Malls'] = this.malls;
    data['Park'] = this.park;
    data['Hills_Lakes'] = this.hillsLakes;
    data['Dams_Waterfalls'] = this.damsWaterfalls;
    data['Movie'] = this.movie;
    data['Picnics'] = this.picnics;
    data['Clubbing'] = this.clubbing;
    data['Night_Out'] = this.nightOut;
    data['Window_Shopping'] = this.windowShopping;
    return data;
  }
}