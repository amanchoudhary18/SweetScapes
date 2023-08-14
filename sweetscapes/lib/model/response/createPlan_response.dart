class CreatePlanResponse {
  String? status;
  AllTravel? allTravel;
  Availability? availability;

  CreatePlanResponse({this.status, this.allTravel, this.availability});

  CreatePlanResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    allTravel = json['allTravel'] != null
        ? new AllTravel.fromJson(json['allTravel'])
        : null;
    availability = json['availability'] != null
        ? new Availability.fromJson(json['availability'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.allTravel != null) {
      data['allTravel'] = this.allTravel!.toJson();
    }
    if (this.availability != null) {
      data['availability'] = this.availability!.toJson();
    }
    return data;
  }
}

class AllTravel {
  Bus? bus;
  Auto? auto;
  TwoWheeler? twoWheeler;
  FourWheeler? fourWheeler;

  AllTravel({this.bus, this.auto, this.twoWheeler, this.fourWheeler});

  AllTravel.fromJson(Map<String, dynamic> json) {
    bus = json['bus'] != null ? new Bus.fromJson(json['bus']) : null;
    auto = json['auto'] != null ? new Auto.fromJson(json['auto']) : null;
    twoWheeler = json['two_wheeler'] != null
        ? new TwoWheeler.fromJson(json['two_wheeler'])
        : null;
    fourWheeler = json['four_wheeler'] != null
        ? new FourWheeler.fromJson(json['four_wheeler'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bus != null) {
      data['bus'] = this.bus!.toJson();
    }
    if (this.auto != null) {
      data['auto'] = this.auto!.toJson();
    }
    if (this.twoWheeler != null) {
      data['two_wheeler'] = this.twoWheeler!.toJson();
    }
    if (this.fourWheeler != null) {
      data['four_wheeler'] = this.fourWheeler!.toJson();
    }
    return data;
  }
}

class Bus {
  List<Route>? route;
  String? distance;
  int? duration;
  int? price;

  Bus({this.route, this.distance, this.duration, this.price});

  Bus.fromJson(Map<String, dynamic> json) {
    if (json['route'] != null) {
      route = <Route>[];
      json['route'].forEach((v) {
        route!.add(new Route.fromJson(v));
      });
    }
    distance = json['distance'];
    duration = json['duration'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.route != null) {
      data['route'] = this.route!.map((v) => v.toJson()).toList();
    }
    data['distance'] = this.distance;
    data['duration'] = this.duration;
    data['price'] = this.price;
    return data;
  }
}

class Route {
  String? mode;
  String? distance;
  int? duration;
  String? boardingPoint;
  int? boardingTime;
  String? boardingTimeFormatted;
  String? dropPoint;
  int? dropTime;
  String? dropTimeFormatted;
  int? price;

  Route(
      {this.mode,
      this.distance,
      this.duration,
      this.boardingPoint,
      this.boardingTime,
      this.boardingTimeFormatted,
      this.dropPoint,
      this.dropTime,
      this.dropTimeFormatted,
      this.price});

  Route.fromJson(Map<String, dynamic> json) {
    mode = json['mode'];
    distance = json['distance'];
    duration = json['duration'];
    boardingPoint = json['boarding_point'];
    boardingTime = json['boarding_time'];
    boardingTimeFormatted = json['boarding_time_formatted'];
    dropPoint = json['drop_point'];
    dropTime = json['drop_time'];
    dropTimeFormatted = json['drop_time_formatted'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mode'] = this.mode;
    data['distance'] = this.distance;
    data['duration'] = this.duration;
    data['boarding_point'] = this.boardingPoint;
    data['boarding_time'] = this.boardingTime;
    data['boarding_time_formatted'] = this.boardingTimeFormatted;
    data['drop_point'] = this.dropPoint;
    data['drop_time'] = this.dropTime;
    data['drop_time_formatted'] = this.dropTimeFormatted;
    data['price'] = this.price;
    return data;
  }
}

class Auto {
  List<Route>? route;
  double? distance;
  int? duration;
  int? price;

  Auto({this.route, this.distance, this.duration, this.price});

  Auto.fromJson(Map<String, dynamic> json) {
    if (json['route'] != null) {
      route = <Route>[];
      json['route'].forEach((v) {
        route!.add(new Route.fromJson(v));
      });
    }
    distance = json['distance'];
    duration = json['duration'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.route != null) {
      data['route'] = this.route!.map((v) => v.toJson()).toList();
    }
    data['distance'] = this.distance;
    data['duration'] = this.duration;
    data['price'] = this.price;
    return data;
  }
}

class TwoWheeler {
  List<Route>? route;
  int? duration;
  double? distance;
  PriceForRide? price;

  TwoWheeler({this.route, this.duration, this.distance, this.price});

  TwoWheeler.fromJson(Map<String, dynamic> json) {
    if (json['route'] != null) {
      route = <Route>[];
      json['route'].forEach((v) {
        route!.add(new Route.fromJson(v));
      });
    }
    duration = json['duration'];
    distance = json['distance'];
    price = json['price'] != null ? new PriceForRide.fromJson(json['price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.route != null) {
      data['route'] = this.route!.map((v) => v.toJson()).toList();
    }
    data['duration'] = this.duration;
    data['distance'] = this.distance;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    return data;
  }
}

class FourWheeler {
  List<Route>? route;
  int? duration;
  double? distance;
  PriceForCar? price;

  FourWheeler({this.route, this.duration, this.distance, this.price});

  FourWheeler.fromJson(Map<String, dynamic> json) {
    if (json['route'] != null) {
      route = <Route>[];
      json['route'].forEach((v) {
        route!.add(new Route.fromJson(v));
      });
    }
    duration = json['duration'];
    distance = json['distance'];
    price = json['price'] != null ? new PriceForCar.fromJson(json['price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.route != null) {
      data['route'] = this.route!.map((v) => v.toJson()).toList();
    }
    data['duration'] = this.duration;
    data['distance'] = this.distance;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    return data;
  }
}

class PriceForRide {
  int? scooty;
  int? bike;

  PriceForRide({this.scooty, this.bike});

  PriceForRide.fromJson(Map<String, dynamic> json) {
    scooty = json['scooty'];
    bike = json['bike'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scooty'] = this.scooty;
    data['bike'] = this.bike;
    return data;
  }
}

class PriceForCar {
  int? midSize;
  int? suv;

  PriceForCar({this.midSize, this.suv});

  PriceForCar.fromJson(Map<String, dynamic> json) {
    midSize = json['mid_size'];
    suv = json['suv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mid_size'] = this.midSize;
    data['suv'] = this.suv;
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