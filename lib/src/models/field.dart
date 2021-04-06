class Field {
  List markets;
  String id;
  String name;
  String description;
  String image;
  bool selected;
  String siraNo;

  Field();

  Field.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      markets = jsonMap['markets'];
      id = jsonMap['id'].toString();
      name = jsonMap['name'];
      description = jsonMap['description'];
      image = jsonMap['media'][0]['url'] != null
          ? jsonMap['media'][0]['url']
          : null;
      selected = jsonMap['selected'] ?? false;
      siraNo = jsonMap['custom_fields']['sira']['value'] != null
          ? jsonMap['custom_fields']['sira']['value']
          : null;
    } catch (e) {
      markets = null;
      id = '';
      name = '';
      description = '';
      image = '';
      selected = false;
      siraNo = '';
    }
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['siraNo'] = siraNo;
    return map;
  }

  @override
  bool operator ==(dynamic other) {
    return other.id == this.id;
  }

  @override
  int get hashCode => super.hashCode;
}
