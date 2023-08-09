// class Components {
//   bool? isHighlight;
//   Details? details;
//   int? order;

//   Components({this.isHighlight, this.details, this.order});

//   Components.fromJson(Map<String, dynamic> json) {
//     isHighlight = json['is_highlight'];
//     details =
//         json['details'] != null ? new Details.fromJson(json['details']) : null;
//     order = json['order'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['is_highlight'] = this.isHighlight;
//     if (this.details != null) {
//       data['details'] = this.details!.toJson();
//     }
//     data['order'] = this.order;
//     return data;
//   }
// }

// class Details {
//   Contact? contact;
//   MapLocation? map;
//   Availability? availability;
//   String? sId;
//   String? type;
//   List<String>? tags;
//   String? hotelName;
//   String? menu;
//   String? description;
//   double? rating;
//   int? pricePerHead;
//   String? busNodalPoint;
//   List<String>? busRouteType;
//   int? duration;
//   String? openingTime;
//   String? closingTime;
//   String? img;
//   int? iV;
//   String? placeName;
//   String? websiteLink;

//   Details(
//       {this.contact,
//       this.map,
//       this.availability,
//       this.sId,
//       this.type,
//       this.tags,
//       this.hotelName,
//       this.menu,
//       this.description,
//       this.rating,
//       this.pricePerHead,
//       this.busNodalPoint,
//       this.busRouteType,
//       this.duration,
//       this.openingTime,
//       this.closingTime,
//       this.img,
//       this.iV,
//       this.placeName,
//       this.websiteLink});

//   Details.fromJson(Map<String, dynamic> json) {
//     contact =
//         json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
//     map = json['map'] != null ? new MapLocation.fromJson(json['map']) : null;
//     availability = json['availability'] != null
//         ? new Availability.fromJson(json['availability'])
//         : null;
//     sId = json['_id'];
//     type = json['type'];
//     tags = json['tags'].cast<String>();
//     hotelName = json['hotel_name'];
//     menu = json['menu'];
//     description = json['description'];
//     rating = json['rating'].toDouble();
//     pricePerHead = json['price_per_head'];
//     busNodalPoint = json['bus_nodal_point'];
//     busRouteType = json['bus_route_type'].cast<String>();
//     duration = json['duration'];
//     openingTime = json['opening_time'];
//     closingTime = json['closing_time'];
//     img = json['img'];
//     iV = json['__v'];
//     placeName = json['place_name'];
//     websiteLink = json['website_link'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.contact != null) {
//       data['contact'] = this.contact!.toJson();
//     }
//     if (this.map != null) {
//       data['map'] = this.map!.toJson();
//     }
//     if (this.availability != null) {
//       data['availability'] = this.availability!.toJson();
//     }
//     data['_id'] = this.sId;
//     data['type'] = this.type;
//     data['tags'] = this.tags;
//     data['hotel_name'] = this.hotelName;
//     data['menu'] = this.menu;
//     data['description'] = this.description;
//     data['rating'] = this.rating;
//     data['price_per_head'] = this.pricePerHead;
//     data['bus_nodal_point'] = this.busNodalPoint;
//     data['bus_route_type'] = this.busRouteType;
//     data['duration'] = this.duration;
//     data['opening_time'] = this.openingTime;
//     data['closing_time'] = this.closingTime;
//     data['img'] = this.img;
//     data['__v'] = this.iV;
//     data['place_name'] = this.placeName;
//     data['website_link'] = this.websiteLink;
//     return data;
//   }
// }

// class Contact {
//   String? name;
//   String? number;

//   Contact({this.name, this.number});

//   Contact.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     number = json['number'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['number'] = this.number;
//     return data;
//   }
// }

// class MapLocation {
//   String? lat;
//   String? lng;

//   MapLocation({this.lat, this.lng});

//   MapLocation.fromJson(Map<String, dynamic> json) {
//     lat = json['lat'];
//     lng = json['lng'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['lat'] = this.lat;
//     data['lng'] = this.lng;
//     return data;
//   }
// }
