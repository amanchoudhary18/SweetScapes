class CreatePlanResponse {
  String? status;
  String? message;
  String? componentId;
  AllTravel? allTravel;

  CreatePlanResponse({this.status, this.message, this.componentId, this.allTravel});

  CreatePlanResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    componentId = json['componentId'];
    allTravel = json['allTravel'] != null
        ? new AllTravel.fromJson(json['allTravel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['componentId'] = this.componentId;
    if (this.allTravel != null) {
      data['allTravel'] = this.allTravel!.toJson();
    }
    return data;
  }
}

class AllTravel {
  Bus? bus;
  Auto? auto;
  Scooty? scooty;
  Bike? bike;
  MidSizeCar? midSize;
  SUV? suv;

  AllTravel(
      {this.bus, this.auto, this.scooty, this.bike, this.midSize, this.suv});

  AllTravel.fromJson(Map<String, dynamic> json) {
    bus = json['bus'] != null ? new Bus.fromJson(json['bus']) : null;
    auto = json['auto'] != null ? new Auto.fromJson(json['auto']) : null;
    scooty =
        json['scooty'] != null ? new Scooty.fromJson(json['scooty']) : null;
    bike = json['bike'] != null ? new Bike.fromJson(json['bike']) : null;
    midSize = json['mid_size'] != null
        ? new MidSizeCar.fromJson(json['mid_size'])
        : null;
    suv = json['suv'] != null ? new SUV.fromJson(json['suv']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bus != null) {
      data['bus'] = this.bus!.toJson();
    }
    if (this.auto != null) {
      data['auto'] = this.auto!.toJson();
    }
    if (this.scooty != null) {
      data['scooty'] = this.scooty!.toJson();
    }
    if (this.bike != null) {
      data['bike'] = this.bike!.toJson();
    }
    if (this.midSize != null) {
      data['mid_size'] = this.midSize!.toJson();
    }
    if (this.suv != null) {
      data['suv'] = this.suv!.toJson();
    }
    return data;
  }
}

class Bus {
  List<Route>? route;
  String? distance;
  double? duration;
  double? price;

  Bus({this.route, this.distance, this.duration, this.price});

  Bus.fromJson(Map<String, dynamic> json) {
    if (json['route'] != null) {
      route = <Route>[];
      json['route'].forEach((v) {
        route!.add(new Route.fromJson(v));
      });
    }
    distance = json['distance'];
    duration = json['duration'].toDouble();
    price = json['price'].toDouble();
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
  double? duration;
  double? price;

  Auto({this.route, this.distance, this.duration, this.price});

  Auto.fromJson(Map<String, dynamic> json) {
    if (json['route'] != null) {
      route = <Route>[];
      json['route'].forEach((v) {
        route!.add(new Route.fromJson(v));
      });
    }
    distance = json['distance'].toDouble();
    duration = json['duration'].toDouble();
    price = json['price'].toDouble();
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

class Scooty {
  List<Route>? route;
  double? distance;
  double? duration;
  double? price;

  Scooty({this.route, this.distance, this.duration, this.price});

  Scooty.fromJson(Map<String, dynamic> json) {
    if (json['route'] != null) {
      route = <Route>[];
      json['route'].forEach((v) {
        route!.add(new Route.fromJson(v));
      });
    }
    distance = json['distance'].toDouble();
    duration = json['duration'].toDouble();
    price = json['price'].toDouble();
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

class Bike {
  List<Route>? route;
  double? distance;
  double? duration;
  double? price;

  Bike({this.route, this.distance, this.duration, this.price});

  Bike.fromJson(Map<String, dynamic> json) {
    if (json['route'] != null) {
      route = <Route>[];
      json['route'].forEach((v) {
        route!.add(new Route.fromJson(v));
      });
    }
    distance = json['distance'].toDouble();
    duration = json['duration'].toDouble();
    price = json['price'].toDouble();
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

class MidSizeCar {
  List<Route>? route;
  double? distance;
  double? duration;
  double? price;

  MidSizeCar({this.route, this.distance, this.duration, this.price});

  MidSizeCar.fromJson(Map<String, dynamic> json) {
    if (json['route'] != null) {
      route = <Route>[];
      json['route'].forEach((v) {
        route!.add(new Route.fromJson(v));
      });
    }
    distance = json['distance'].toDouble();
    duration = json['duration'].toDouble();
    price = json['price'].toDouble();
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

class SUV {
  List<Route>? route;
  double? distance;
  double? duration;
  double? price;

  SUV({this.route, this.distance, this.duration, this.price});

  SUV.fromJson(Map<String, dynamic> json) {
    if (json['route'] != null) {
      route = <Route>[];
      json['route'].forEach((v) {
        route!.add(new Route.fromJson(v));
      });
    }
    distance = json['distance'].toDouble();
    duration = json['duration'].toDouble();
    price = json['price'].toDouble();
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
