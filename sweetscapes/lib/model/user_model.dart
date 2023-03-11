class UserModel {
  String? status;
  String? message;
  User? user;
  String? token;

  UserModel({this.status, this.message, this.user, this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  int? mobileNumber;
  Preferences? preferences;
  bool? isPaired;
  bool? isSubscribed;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
      {this.mobileNumber,
      this.preferences,
      this.isPaired,
      this.isSubscribed,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobileNumber'];
    preferences = json['preferences'] != null
        ? new Preferences.fromJson(json['preferences'])
        : null;
    isPaired = json['isPaired'];
    isSubscribed = json['isSubscribed'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileNumber'] = this.mobileNumber;
    if (this.preferences != null) {
      data['preferences'] = this.preferences!.toJson();
    }
    data['isPaired'] = this.isPaired;
    data['isSubscribed'] = this.isSubscribed;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Preferences {
  Dine? dine;
  Outing? outing;

  Preferences({this.dine, this.outing});

  Preferences.fromJson(Map<String, dynamic> json) {
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
  int? fineDining;
  int? decentDining;
  int? dhabas;
  int? homeDelivery;
  int? takeAway;
  int? homeMade;
  int? cafes;

  Dine(
      {this.fineDining,
      this.decentDining,
      this.dhabas,
      this.homeDelivery,
      this.takeAway,
      this.homeMade,
      this.cafes});

  Dine.fromJson(Map<String, dynamic> json) {
    fineDining = json['Fine_Dining'];
    decentDining = json['Decent_Dining'];
    dhabas = json['Dhabas'];
    homeDelivery = json['Home_Delivery'];
    takeAway = json['Take_Away'];
    homeMade = json['Home_Made'];
    cafes = json['Cafes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Fine_Dining'] = this.fineDining;
    data['Decent_Dining'] = this.decentDining;
    data['Dhabas'] = this.dhabas;
    data['Home_Delivery'] = this.homeDelivery;
    data['Take_Away'] = this.takeAway;
    data['Home_Made'] = this.homeMade;
    data['Cafes'] = this.cafes;
    return data;
  }
}

class Outing {
  int? hillsLakes;
  int? damsWaterfalls;
  int? malls;
  int? movie;
  int? park;
  int? picnics;
  int? clubbing;
  int? nightOut;
  int? windowShopping;

  Outing(
      {this.hillsLakes,
      this.damsWaterfalls,
      this.malls,
      this.movie,
      this.park,
      this.picnics,
      this.clubbing,
      this.nightOut,
      this.windowShopping});

  Outing.fromJson(Map<String, dynamic> json) {
    hillsLakes = json['Hills_Lakes'];
    damsWaterfalls = json['Dams_Waterfalls'];
    malls = json['Malls'];
    movie = json['Movie'];
    park = json['Park'];
    picnics = json['Picnics'];
    clubbing = json['Clubbing'];
    nightOut = json['Night_Out'];
    windowShopping = json['Window_Shopping'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Hills_Lakes'] = this.hillsLakes;
    data['Dams_Waterfalls'] = this.damsWaterfalls;
    data['Malls'] = this.malls;
    data['Movie'] = this.movie;
    data['Park'] = this.park;
    data['Picnics'] = this.picnics;
    data['Clubbing'] = this.clubbing;
    data['Night_Out'] = this.nightOut;
    data['Window_Shopping'] = this.windowShopping;
    return data;
  }
}