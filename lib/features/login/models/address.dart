class AddressModel {
  String? city;
  String? govern;
  AddressModel({
    this.city,
    this.govern,
  });
  AddressModel.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    govern = json['govern'];
  }

  Map toJson() => {
        'city': city,
        'govern': govern,
      };
}

class City {
  String? cityAR;
  String? cityEN;
  String? id;
  City({
    this.cityAR,
    this.id,
    this.cityEN,
  });
  City.fromJson(Map<String, dynamic> json) {
    cityEN = json['cityEN'];
    id = json['id'];
    cityAR = json['cityAR'];
  }

  Map toJson() => {
        'cityAR': cityAR,
        'id': id,
        'cityEN': cityEN,
      };
}

class Govern {
  String? governAR;
  String? governEn;
  String? id;
  Govern({
    this.governAR,
    this.id,
    this.governEn,
  });
  Govern.fromJson(Map<String, dynamic> json) {
    governAR = json['governAR'];
    id = json['id'];
    governEn = json['governEn'];
  }

  Map toJson() => {
        'governAR': governAR,
        'id': id,
        'governEn': governEn,
      };
}
