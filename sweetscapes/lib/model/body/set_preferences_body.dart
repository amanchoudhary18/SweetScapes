class SetPreferences_Body {
  Preferences? preferences;

  SetPreferences_Body({this.preferences});

  SetPreferences_Body.fromJson(Map<String, dynamic> json) {
    preferences = json['preferences'] != null
        ? new Preferences.fromJson(json['preferences'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.preferences != null) {
      data['preferences'] = this.preferences!.toJson();
    }
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
  bool? fineDining;
  bool? decentDining;
  bool? dhabas;
  bool? homeDelivery;
  bool? takeAway;
  bool? homeMade;
  bool? cafes;

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
  bool? hillsLakes;
  bool? damsWaterfalls;
  bool? malls;
  bool? movie;
  bool? park;
  bool? picnics;
  bool? clubbing;
  bool? nightOut;
  bool? windowShopping;

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