import 'package:sweetscapes/model/response/getAllPlans_response.dart';

class SaveUserCreatedPlanResponse {
  String? status;
  FinalPlanDetails? finalPlanDetails;

  SaveUserCreatedPlanResponse({this.status, this.finalPlanDetails});

  SaveUserCreatedPlanResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    finalPlanDetails = json['final_plan_details'] != null
        ? new FinalPlanDetails.fromJson(json['final_plan_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.finalPlanDetails != null) {
      data['final_plan_details'] = this.finalPlanDetails!.toJson();
    }
    return data;
  }
}

class FinalPlanDetails {
  int? planStartTime;
  List<Images>? images;
  int? noOfComponents;
  String? tileContent;
  List<String>? tags;
  List<CompleteTravel>? completeTravel;
  int? componentPrice;
  int? travelPrice;
  int? peopleCount;

  FinalPlanDetails(
      {this.planStartTime,
      this.images,
      this.noOfComponents,
      this.tileContent,
      this.tags,
      this.completeTravel,
      this.componentPrice,
      this.travelPrice,
      this.peopleCount});

  FinalPlanDetails.fromJson(Map<String, dynamic> json) {
    planStartTime = json['plan_start_time'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    noOfComponents = json['no_of_components'];
    tileContent = json['tile_content'];
    tags = json['tags'].cast<String>();
    if (json['complete_travel'] != null) {
      completeTravel = <CompleteTravel>[];
      json['complete_travel'].forEach((v) {
        completeTravel!.add(new CompleteTravel.fromJson(v));
      });
    }
    componentPrice = json['component_price'];
    travelPrice = json['travel_price'];
    peopleCount = json['people_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plan_start_time'] = this.planStartTime;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['no_of_components'] = this.noOfComponents;
    data['tile_content'] = this.tileContent;
    data['tags'] = this.tags;
    if (this.completeTravel != null) {
      data['complete_travel'] =
          this.completeTravel!.map((v) => v.toJson()).toList();
    }
    data['component_price'] = this.componentPrice;
    data['travel_price'] = this.travelPrice;
    data['people_count'] = this.peopleCount;
    return data;
  }
}

class CompleteTravel {
  String? mode;
  int? duration;
  String? distance;
  String? boardingPoint;
  int? boardingTime;
  String? boardingTimeFormatted;
  String? dropPoint;
  int? dropTime;
  String? dropTimeFormatted;
  int? price;
  DropPointComponent? dropPointComponent;

  CompleteTravel(
      {this.mode,
      this.duration,
      this.distance,
      this.boardingPoint,
      this.boardingTime,
      this.boardingTimeFormatted,
      this.dropPoint,
      this.dropTime,
      this.dropTimeFormatted,
      this.price,
      this.dropPointComponent});

  CompleteTravel.fromJson(Map<String, dynamic> json) {
    mode = json['mode'];
    duration = json['duration'];
    distance = json['distance'];
    boardingPoint = json['boarding_point'];
    boardingTime = json['boarding_time'];
    boardingTimeFormatted = json['boarding_time_formatted'];
    dropPoint = json['drop_point'];
    dropTime = json['drop_time'];
    dropTimeFormatted = json['drop_time_formatted'];
    price = json['price'];
    dropPointComponent = json['drop_point_component'] != null
        ? new DropPointComponent.fromJson(json['drop_point_component'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mode'] = this.mode;
    data['duration'] = this.duration;
    data['distance'] = this.distance;
    data['boarding_point'] = this.boardingPoint;
    data['boarding_time'] = this.boardingTime;
    data['boarding_time_formatted'] = this.boardingTimeFormatted;
    data['drop_point'] = this.dropPoint;
    data['drop_time'] = this.dropTime;
    data['drop_time_formatted'] = this.dropTimeFormatted;
    data['price'] = this.price;
    if (this.dropPointComponent != null) {
      data['drop_point_component'] = this.dropPointComponent!.toJson();
    }
    return data;
  }
}

class DropPointComponent {
  bool? isHighlight;
  String? name;
  String? tag;
  int? pricePerHead;
  int? duration;

  DropPointComponent(
      {this.isHighlight,
      this.name,
      this.tag,
      this.pricePerHead,
      this.duration});

  DropPointComponent.fromJson(Map<String, dynamic> json) {
    isHighlight = json['is_highlight'];
    name = json['name'];
    tag = json['tag'];
    pricePerHead = json['price_per_head'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_highlight'] = this.isHighlight;
    data['name'] = this.name;
    data['tag'] = this.tag;
    data['price_per_head'] = this.pricePerHead;
    data['duration'] = this.duration;
    return data;
  }
}