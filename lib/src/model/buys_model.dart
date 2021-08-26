import 'dart:convert';

BuysModel buysModelFromJson(String str) => BuysModel.fromJson(json.decode(str));

String buysModelToJson(BuysModel data) => json.encode(data.toJson());

class BuysModel {
    BuysModel({
        this.g03Id,
        this.g03State,
        this.g02Date,
        this.g01Id,
    });

    int g03Id;
    int g03State;
    DateTime g02Date;
    int g01Id;

    factory BuysModel.fromJson(Map<String, dynamic> json) => BuysModel(
        g03Id: json["g03_id"],
        g03State: json["g03_state"],
        g02Date: json["g02_date"],
        g01Id: json["g01_id"],
    );

    Map<String, dynamic> toJson() => {
        "g03_id": g03Id,
        "g03_state": g03State,
        "g02_date": g02Date,
        "g01_id": g01Id,
    };
}
