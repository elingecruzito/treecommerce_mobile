import 'dart:convert';

import 'package:treecommerce/src/utilerias/utils.dart';

List<NotificationsModel> notificationsListModelFromJson(String str) => List<NotificationsModel>.from(json.decode(str).map((x) => NotificationsModel.fromJson(x)));

String notificationsListModelToJson(List<NotificationsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationsModel {
    NotificationsModel({
        this.id,
        this.type,
        this.title,
        this.message,
        this.readed,
        this.createdAt,
    });

    int id;
    int type;
    String title;
    String message;
    int readed;
    String createdAt;

    factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
        id: int.parse(json["id"].toString()),
        type: int.parse(json["type"].toString()),
        title: json["title"],
        message: json["message"],
        readed: int.parse(json["readed"].toString()),
        createdAt: parseDate(DateTime.parse(json["created_at"])),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "title": title,
        "message": message,
        "readed": readed,
        "created_at": createdAt,
    };
}
