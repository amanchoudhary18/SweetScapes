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
  Preferences? preferences;
  Location? location;
  String? sId;
  int? mobileNumber;
  bool? isPaired;
  bool? isSubscribed;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? name;
  String? birthday;
  String? gender;
  String? username;
  bool? isNew;
  String? email;
  String? pairedWith;
  String? avatar;

  User(
      {this.preferences,
      this.location,
      this.sId,
      this.mobileNumber,
      this.isPaired,
      this.isSubscribed,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.name,
      this.birthday,
      this.gender,
      this.username,
      this.isNew,
      this.email,
      this.pairedWith,
      this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    preferences = json['preferences'] != null
        ? new Preferences.fromJson(json['preferences'])
        : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    mobileNumber = json['mobileNumber'];
    isPaired = json['isPaired'];
    isSubscribed = json['isSubscribed'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    name = json['name'];
    birthday = json['birthday'];
    gender = json['gender'];
    username = json['username'];
    isNew = json['isNew'];
    email = json['email'];
    pairedWith = json['pairedWith'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.preferences != null) {
      data['preferences'] = this.preferences!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    data['mobileNumber'] = this.mobileNumber;
    data['isPaired'] = this.isPaired;
    data['isSubscribed'] = this.isSubscribed;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['name'] = this.name;
    data['birthday'] = this.birthday;
    data['gender'] = this.gender;
    data['username'] = this.username;
    data['isNew'] = this.isNew;
    data['email'] = this.email;
    data['pairedWith'] = this.pairedWith;
    data['avatar'] = this.avatar;
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

class Location {
  String? latitude;
  String? longitude;

  Location({this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}