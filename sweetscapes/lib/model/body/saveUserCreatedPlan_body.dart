import 'package:sweetscapes/model/response/createPlan_response.dart';

class SaveUserCreatedPlanBody {
  int? peopleCount;
  List<FinalComponentsforViewPlan>? finalComponents;
  FinalTravel? finalTravel;
  String? tileContent;

  SaveUserCreatedPlanBody(
      {this.peopleCount,
      this.finalComponents,
      this.finalTravel,
      this.tileContent});

  SaveUserCreatedPlanBody.fromJson(Map<String, dynamic> json) {
    peopleCount = json['people_count'];
    if (json['finalComponents'] != null) {
      finalComponents = <FinalComponentsforViewPlan>[];
      json['finalComponents'].forEach((v) {
        finalComponents!.add(new FinalComponentsforViewPlan.fromJson(v));
      });
    }
    finalTravel = json['finalTravel'] != null
        ? new FinalTravel.fromJson(json['finalTravel'])
        : null;
    tileContent = json['tile_content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['people_count'] = this.peopleCount;
    if (this.finalComponents != null) {
      data['finalComponents'] =
          this.finalComponents!.map((v) => v.toJson()).toList();
    }
    if (this.finalTravel != null) {
      data['finalTravel'] = this.finalTravel!.toJson();
    }
    data['tile_content'] = this.tileContent;
    return data;
  }
}

class FinalComponentsforViewPlan {
  int? order;
  String? type;
  String? componentId;
  bool? isHighlight;

  FinalComponentsforViewPlan({this.order, this.type, this.componentId, this.isHighlight});

  FinalComponentsforViewPlan.fromJson(Map<String, dynamic> json) {
    order = json['order'];
    type = json['type'];
    componentId = json['component_id'];
    isHighlight = json['is_highlight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order'] = this.order;
    data['type'] = this.type;
    data['component_id'] = this.componentId;
    data['is_highlight'] = this.isHighlight;
    return data;
  }
}

class FinalTravel {
  List<Route>? route;
  double? duration;
  double? distance;
  double? price;

  FinalTravel({this.route, this.duration, this.distance, this.price});

  FinalTravel.fromJson(Map<String, dynamic> json) {
    if (json['route'] != null) {
      route = <Route>[];
      json['route'].forEach((v) {
        route!.add(new Route.fromJson(v));
      });
    }
    duration = json['duration'].toDouble();
    distance = json['distance'];
    price = json['price'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.route != null) {
      data['route'] = this.route!.map((v) => v.toJson()).toList();
    }
    data['duration'] = this.duration;
    data['distance'] = this.distance;
    data['price'] = this.price;
    return data;
  }
}

// class Route {
//   String? mode;
//   int? duration;
//   String? distance;
//   String? boardingPoint;
//   int? boardingTime;
//   String? boardingTimeFormatted;
//   String? dropPoint;
//   int? dropTime;
//   String? dropTimeFormatted;
//   int? price;

//   Route(
//       {this.mode,
//       this.duration,
//       this.distance,
//       this.boardingPoint,
//       this.boardingTime,
//       this.boardingTimeFormatted,
//       this.dropPoint,
//       this.dropTime,
//       this.dropTimeFormatted,
//       this.price});

//   Route.fromJson(Map<String, dynamic> json) {
//     mode = json['mode'];
//     duration = json['duration'];
//     distance = json['distance'];
//     boardingPoint = json['boarding_point'];
//     boardingTime = json['boarding_time'];
//     boardingTimeFormatted = json['boarding_time_formatted'];
//     dropPoint = json['drop_point'];
//     dropTime = json['drop_time'];
//     dropTimeFormatted = json['drop_time_formatted'];
//     price = json['price'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['mode'] = this.mode;
//     data['duration'] = this.duration;
//     data['distance'] = this.distance;
//     data['boarding_point'] = this.boardingPoint;
//     data['boarding_time'] = this.boardingTime;
//     data['boarding_time_formatted'] = this.boardingTimeFormatted;
//     data['drop_point'] = this.dropPoint;
//     data['drop_time'] = this.dropTime;
//     data['drop_time_formatted'] = this.dropTimeFormatted;
//     data['price'] = this.price;
//     return data;
//   }
// }