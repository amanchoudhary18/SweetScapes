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
  String? preferredTransport;

  CompletedAllPlans(
      {this.id,
      this.tags,
      this.images,
      this.availability,
      this.planStartTime,
      this.price,
      this.tileContent,
      this.likeness,
      this.components,
      this.preferredTransport});

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
    preferredTransport = json['preferred_transport'];
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
    data['preferred_transport'] = this.preferredTransport;
    return data;
  }

  CompletedAllPlans.copy(CompletedAllPlans other)
    : id = other.id,
      tags = List<String>.from(other.tags ?? []),
      images = other.images != null
          ? List<Images>.from(other.images!.map((image) => Images.copy(image)))
          : [],
      availability = Availability.copy(other.availability!),
      planStartTime = other.planStartTime,
      price = other.price,
      tileContent = other.tileContent,
      likeness = other.likeness,
      components = other.components != null
          ? List<Components>.from(other.components!.map((component) => Components.copy(component)))
          : [],
      preferredTransport = other.preferredTransport;
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

  Images.copy(Images other)
      : imgLink = other.imgLink,
        imgName = other.imgName,
        order = other.order;
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
  int? order;
  Details? details;

  Components({this.isHighlight, this.order, this.details});

  Components.fromJson(Map<String, dynamic> json) {
    isHighlight = json['is_highlight'];
    order = json['order'];
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_highlight'] = this.isHighlight;
    data['order'] = this.order;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    return data;
  }

  Components.copy(Components other)
      : isHighlight = other.isHighlight,
        order = other.order,
        details = other.details != null ? Details.copy(other.details!) : null;
}

class Details {
  String? sId;
  String? type;
  List<String>? tags;
  String? placeName;
  String? description;
  double? rating;
  int? pricePerHead;
  MapLocation? map;
  String? busNodalPoint;
  List<String>? busRouteType;
  int? duration;
  List<TimeSlots>? timeSlots;
  String? img;
  Availability? availability;
  String? hotelName;
  Contact? contact;
  String? menu;
  String? websiteLink;

  Details(
      {this.sId,
      this.type,
      this.tags,
      this.placeName,
      this.description,
      this.rating,
      this.pricePerHead,
      this.map,
      this.busNodalPoint,
      this.busRouteType,
      this.duration,
      this.timeSlots,
      this.img,
      this.availability,
      this.hotelName,
      this.contact,
      this.menu,
      this.websiteLink});

  Details.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    tags = json['tags'].cast<String>();
    placeName = json['place_name'];
    description = json['description'];
    rating = json['rating'].toDouble();
    pricePerHead = json['price_per_head'];
    map = json['map'] != null ? new MapLocation.fromJson(json['map']) : null;
    busNodalPoint = json['bus_nodal_point'];
    final busRouteTypeList = json['bus_route_type'];
    busRouteType = (busRouteTypeList is List) ? busRouteTypeList.cast<String>() : [];
    duration = json['duration'];
    if (json['time_slots'] != null) {
      timeSlots = <TimeSlots>[];
      json['time_slots'].forEach((v) {
        timeSlots!.add(new TimeSlots.fromJson(v));
      });
    }
    img = json['img'];
    availability = json['availability'] != null
        ? new Availability.fromJson(json['availability'])
        : null;
    hotelName = json['hotel_name'];
    contact =
        json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
    menu = json['menu'];
    websiteLink = json['website_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['type'] = this.type;
    data['tags'] = this.tags;
    data['place_name'] = this.placeName;
    data['description'] = this.description;
    data['rating'] = this.rating;
    data['price_per_head'] = this.pricePerHead;
    if (this.map != null) {
      data['map'] = this.map!.toJson();
    }
    data['bus_nodal_point'] = this.busNodalPoint;
    data['bus_route_type'] = this.busRouteType;
    data['duration'] = this.duration;
    if (this.timeSlots != null) {
      data['time_slots'] = this.timeSlots!.map((v) => v.toJson()).toList();
    }
    data['img'] = this.img;
    if (this.availability != null) {
      data['availability'] = this.availability!.toJson();
    }
    data['hotel_name'] = this.hotelName;
    if (this.contact != null) {
      data['contact'] = this.contact!.toJson();
    }
    data['menu'] = this.menu;
    data['website_link'] = this.websiteLink;
    return data;
  }

  Details.copy(Details other)
      : sId = other.sId,
        type = other.type,
        tags = List<String>.from(other.tags ?? []),
        placeName = other.placeName,
        description = other.description,
        rating = other.rating,
        pricePerHead = other.pricePerHead,
        map = other.map != null ? MapLocation.copy(other.map!) : null,
        busNodalPoint = other.busNodalPoint,
        busRouteType = List<String>.from(other.busRouteType ?? []),
        duration = other.duration,
        timeSlots = other.timeSlots != null
            ? List<TimeSlots>.from(other.timeSlots!.map((slot) => TimeSlots.copy(slot)))
            : null,
        img = other.img,
        availability = other.availability != null
            ? Availability.copy(other.availability!)
            : null,
        hotelName = other.hotelName,
        contact = other.contact != null
            ? Contact.copy(other.contact!)
            : null,
        menu = other.menu,
        websiteLink = other.websiteLink;
}

class TimeSlots {
  String? sId;
  String? openingTime;
  String? closingTime;

  TimeSlots({this.sId, this.openingTime, this.closingTime});

  TimeSlots.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    return data;
  }

  TimeSlots.copy(TimeSlots other)
      : sId = other.sId,
        openingTime = other.openingTime,
        closingTime = other.closingTime;
}

class MapLocation {
  String? lat;
  String? lng;

  MapLocation({this.lat, this.lng});

  MapLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'].toString();
    lng = json['lng'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }

  MapLocation.copy(MapLocation other)
      : lat = other.lat,
        lng = other.lng;
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

  Contact.copy(Contact other)
      : name = other.name,
        number = other.number;
}