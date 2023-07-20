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
  bool? cafes;
  bool? streetfood;

  Dine(
      {this.fineDining,
      this.decentDining,
      this.dhabas,
      this.cafes,
      this.streetfood});

  Dine.fromJson(Map<String, dynamic> json) {
    fineDining = json['Fine_Dining'];
    decentDining = json['Decent_Dining'];
    dhabas = json['Dhabas'];
    cafes = json['Cafes'];
    streetfood = json['Streetfood'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Fine_Dining'] = this.fineDining;
    data['Decent_Dining'] = this.decentDining;
    data['Dhabas'] = this.dhabas;
    data['Cafes'] = this.cafes;
    data['Streetfood'] = this.streetfood;
    return data;
  }
}

class Outing {
  bool? hills;
  bool? lakes;
  bool? damsWaterfalls;
  bool? malls;
  bool? movieHalls;
  bool? parks;
  bool? clubbing;
  bool? nightOut;
  bool? shopping;
  bool? placesOfWorship;
  bool? museum;

  Outing(
      {this.hills,
      this.lakes,
      this.damsWaterfalls,
      this.malls,
      this.movieHalls,
      this.parks,
      this.clubbing,
      this.nightOut,
      this.shopping,
      this.placesOfWorship,
      this.museum});

  Outing.fromJson(Map<String, dynamic> json) {
    hills = json['Hills'];
    lakes = json['Lakes'];
    damsWaterfalls = json['Dams_Waterfalls'];
    malls = json['Malls'];
    movieHalls = json['Movie_Halls'];
    parks = json['Parks'];
    clubbing = json['Clubbing'];
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
    data['Malls'] = this.malls;
    data['Movie_Halls'] = this.movieHalls;
    data['Parks'] = this.parks;
    data['Clubbing'] = this.clubbing;
    data['Night_Out'] = this.nightOut;
    data['Shopping'] = this.shopping;
    data['Places_Of_Worship'] = this.placesOfWorship;
    data['Museum'] = this.museum;
    return data;
  }
}