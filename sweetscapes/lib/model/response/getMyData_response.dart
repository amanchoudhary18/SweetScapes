class GetMyDataResponse {
  String? status;
  UserData? userData;

  GetMyDataResponse({this.status, this.userData});

  GetMyDataResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userData = json['userData'] != null
        ? new UserData.fromJson(json['userData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.userData != null) {
      data['userData'] = this.userData!.toJson();
    }
    return data;
  }
}

class UserData {
  Preferences? preferences;
  String? sId;
  String? name;
  String? email;
  bool? isNew;
  bool? isPaired;
  bool? isSubscribed;
  List<String>? createdPlans;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? birthday;
  String? gender;

  UserData(
      {this.preferences,
      this.sId,
      this.name,
      this.email,
      this.isNew,
      this.isPaired,
      this.isSubscribed,
      this.createdPlans,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.birthday,
      this.gender});

  UserData.fromJson(Map<String, dynamic> json) {
    preferences = json['preferences'] != null
        ? new Preferences.fromJson(json['preferences'])
        : null;
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    isNew = json['isNew'];
    isPaired = json['isPaired'];
    isSubscribed = json['isSubscribed'];
    createdPlans = json['createdPlans'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    birthday = json['birthday'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.preferences != null) {
      data['preferences'] = this.preferences!.toJson();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['isNew'] = this.isNew;
    data['isPaired'] = this.isPaired;
    data['isSubscribed'] = this.isSubscribed;
    data['createdPlans'] = this.createdPlans;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['birthday'] = this.birthday;
    data['gender'] = this.gender;
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
  int? restroBar;
  int? foodcourt;
  int? classicDineIn;
  int? dhabas;
  int? cafes;
  int? streetfood;

  Dine(
      {this.fineDining,
      this.restroBar,
      this.foodcourt,
      this.classicDineIn,
      this.dhabas,
      this.cafes,
      this.streetfood});

  Dine.fromJson(Map<String, dynamic> json) {
    fineDining = json['Fine_Dining'];
    restroBar = json['RestroBar'];
    foodcourt = json['Foodcourt'];
    classicDineIn = json['Classic_Dine_In'];
    dhabas = json['Dhabas'];
    cafes = json['Cafes'];
    streetfood = json['Streetfood'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Fine_Dining'] = this.fineDining;
    data['RestroBar'] = this.restroBar;
    data['Foodcourt'] = this.foodcourt;
    data['Classic_Dine_In'] = this.classicDineIn;
    data['Dhabas'] = this.dhabas;
    data['Cafes'] = this.cafes;
    data['Streetfood'] = this.streetfood;
    return data;
  }
}

class Outing {
  int? hills;
  int? lakes;
  int? damsWaterfalls;
  int? arcade;
  int? movieHalls;
  int? parks;
  int? clubsBars;
  int? nightOut;
  int? shopping;
  int? placesOfWorship;
  int? museum;

  Outing(
      {this.hills,
      this.lakes,
      this.damsWaterfalls,
      this.arcade,
      this.movieHalls,
      this.parks,
      this.clubsBars,
      this.nightOut,
      this.shopping,
      this.placesOfWorship,
      this.museum});

  Outing.fromJson(Map<String, dynamic> json) {
    hills = json['Hills'];
    lakes = json['Lakes'];
    damsWaterfalls = json['Dams_Waterfalls'];
    arcade = json['Arcade'];
    movieHalls = json['Movie_Halls'];
    parks = json['Parks'];
    clubsBars = json['Clubs_Bars'];
    nightOut = json['Night_Out'];
    shopping = json['Shopping'];
    placesOfWorship = json['Places_Of_Worship'];
    museum = json['Museum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Hills'] = this.hills;
    data['Lakes'] = this.lakes;
    data['Dams_Waterfalls'] = this.damsWaterfalls;
    data['Arcade'] = this.arcade;
    data['Movie_Halls'] = this.movieHalls;
    data['Parks'] = this.parks;
    data['Clubs_Bars'] = this.clubsBars;
    data['Night_Out'] = this.nightOut;
    data['Shopping'] = this.shopping;
    data['Places_Of_Worship'] = this.placesOfWorship;
    data['Museum'] = this.museum;
    return data;
  }
}