class ComponentsByTagBody {
  String? type;
  String? tag;

  ComponentsByTagBody({this.type, this.tag});

  ComponentsByTagBody.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['tag'] = this.tag;
    return data;
  }
}
