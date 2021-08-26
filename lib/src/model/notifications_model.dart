import 'dart:convert';

NotificationsModel notificationsModelFromJson(String str) => NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) => json.encode(data.toJson());

class NotificationsModel {
    NotificationsModel({
        this.g02Id,
        this.g02Title,
        this.g02Desc,
        this.g02Imagen,
    });

    int g02Id;
    String g02Title;
    String g02Desc;
    String g02Imagen;

    factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
        g02Id: json["g02_id"],
        g02Title: json["g02_title"],
        g02Desc: json["g02_desc"],
        g02Imagen: json["g02_imagen"],
    );

    Map<String, dynamic> toJson() => {
        "g02_id": g02Id,
        "g02_title": g02Title,
        "g02_desc": g02Desc,
        "g02_imagen": g02Imagen,
    };
}
