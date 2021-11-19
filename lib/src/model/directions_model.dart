import 'dart:convert';

List<DirectionsModel> directionsListModelFromJson(String str) => List<DirectionsModel>.from(json.decode(str).map((x) => DirectionsModel.fromJson(x)));

DirectionsModel directionsModelFromJson(String str) => DirectionsModel.fromJson(json.decode(str));

String directionsModelToJson(List<DirectionsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DirectionsModel {
    DirectionsModel({
        this.id,
        this.state,
        this.country,
        this.address,
        this.cp,
        this.phone,
        this.person,
    });

    int id;
    String state;
    String country;
    String address;
    int cp;
    String phone;
    String person;

    factory DirectionsModel.fromJson(Map<String, dynamic> json) => DirectionsModel(
        id: json["id"],
        state: json["state"],
        country: json["country"],
        address: json["address"],
        cp: json["cp"],
        phone: json["phone"],
        person: json["person"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "state": state,
        "country": country,
        "address": address,
        "cp": cp,
        "phone": phone,
        "person": person,
    };
}