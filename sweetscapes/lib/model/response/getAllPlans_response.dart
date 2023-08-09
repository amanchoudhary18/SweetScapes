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
  List<Components>? components;

  CompletedAllPlans(
      {this.id,
      this.tags,
      this.images,
      this.availability,
      this.planStartTime,
      this.price,
      this.tileContent,
      this.likeness,
      this.components});

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
    if (json['components'] != null) {
      components = <Components>[];
      json['components'].forEach((v) {
        components!.add(new Components.fromJson(v));
      });
    }
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
    if (this.components != null) {
      data['components'] = this.components!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  CompletedAllPlans.copy(CompletedAllPlans other)
      : id = other.id,
        tags = List.from(other.tags as Iterable),
        images = List.from(other.images as Iterable),
        availability = Availability.copy(other.availability!),
        planStartTime = other.planStartTime,
        price = other.price,
        tileContent = other.tileContent,
        likeness = other.likeness,
        components = List.from(other.components as Iterable);
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

  Availability.copy(Availability other)
      : sunday = other.sunday,
        monday = other.monday,
        tuesday = other.tuesday,
        wednesday = other.wednesday,
        thursday = other.thursday,
        friday = other.friday,
        saturday = other.saturday;
}

class Components {
  bool? isHighlight;
  Details? details;
  int? order;

  Components({this.isHighlight, this.details, this.order});

  Components.fromJson(Map<String, dynamic> json) {
    isHighlight = json['is_highlight'];
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_highlight'] = this.isHighlight;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    data['order'] = this.order;
    return data;
  }
}

class Details {
  Contact? contact;
  MapLocation? map;
  Availability? availability;
  String? sId;
  String? type;
  List<String>? tags;
  String? hotelName;
  String? menu;
  String? description;
  double? rating;
  int? pricePerHead;
  String? busNodalPoint;
  List<String>? busRouteType;
  int? duration;
  String? openingTime;
  String? closingTime;
  String? img;
  int? iV;
  String? placeName;
  String? websiteLink;

  Details(
      {this.contact,
      this.map,
      this.availability,
      this.sId,
      this.type,
      this.tags,
      this.hotelName,
      this.menu,
      this.description,
      this.rating,
      this.pricePerHead,
      this.busNodalPoint,
      this.busRouteType,
      this.duration,
      this.openingTime,
      this.closingTime,
      this.img,
      this.iV,
      this.placeName,
      this.websiteLink});

  Details.fromJson(Map<String, dynamic> json) {
    contact =
        json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
    map = json['map'] != null ? new MapLocation.fromJson(json['map']) : null;
    availability = json['availability'] != null
        ? new Availability.fromJson(json['availability'])
        : null;
    sId = json['_id'];
    type = json['type'];
    tags = json['tags'].cast<String>();
    hotelName = json['hotel_name'];
    menu = json['menu'];
    description = json['description'];
    rating = json['rating'].toDouble();
    pricePerHead = json['price_per_head'];
    busNodalPoint = json['bus_nodal_point'];
    busRouteType = json['bus_route_type'].cast<String>();
    duration = json['duration'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
    img = json['img'];
    iV = json['__v'];
    placeName = json['place_name'];
    websiteLink = json['website_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contact != null) {
      data['contact'] = this.contact!.toJson();
    }
    if (this.map != null) {
      data['map'] = this.map!.toJson();
    }
    if (this.availability != null) {
      data['availability'] = this.availability!.toJson();
    }
    data['_id'] = this.sId;
    data['type'] = this.type;
    data['tags'] = this.tags;
    data['hotel_name'] = this.hotelName;
    data['menu'] = this.menu;
    data['description'] = this.description;
    data['rating'] = this.rating;
    data['price_per_head'] = this.pricePerHead;
    data['bus_nodal_point'] = this.busNodalPoint;
    data['bus_route_type'] = this.busRouteType;
    data['duration'] = this.duration;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    data['img'] = this.img;
    data['__v'] = this.iV;
    data['place_name'] = this.placeName;
    data['website_link'] = this.websiteLink;
    return data;
  }
}

class Contact {
  String? name;
  String? number;

  Contact({this.name, this.number});

  Contact.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['number'] = this.number;
    return data;
  }
}

class MapLocation {
  String? lat;
  String? lng;

  MapLocation({this.lat, this.lng});

  MapLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
