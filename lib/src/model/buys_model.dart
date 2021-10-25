import 'dart:convert';

BuysModel buysModelFromJson(String str) => BuysModel.fromJson(json.decode(str));

String buysModelToJson(BuysModel data) => json.encode(data.toJson());

class BuysModel {
    BuysModel({
        this.id,
        this.idUser,
        this.idStatus,
        this.idDirection,
        this.total,
        this.dateCreated,
    });

    int id;
    int idUser;
    int idStatus;
    int idDirection;
    int total;
    String dateCreated;

    factory BuysModel.fromJson(Map<String, dynamic> json) => BuysModel(
        id: int.parse(json["id"].toString()),
        idUser: int.parse(json["id_user"].toString()),
        idStatus: int.parse(json["id_status"].toString()),
        idDirection: int.parse(json["id_direction"].toString()),
        total: int.parse(json["total"].toString()),
        dateCreated: json["date_created"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "id_status": idStatus,
        "id_direction": idDirection,
        "total": total,
        "date_created": dateCreated,
    };
}
