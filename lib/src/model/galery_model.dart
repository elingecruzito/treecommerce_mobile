import 'dart:convert';

List<GaleryModel> galeryListModelFromJson(String str) => List<GaleryModel>.from(json.decode(str).map((x) => GaleryModel.fromJson(x)));

GaleryModel galeryModelFromJson(String str) => GaleryModel.fromJson(json.decode(str));

String galeryModelToJson(List<GaleryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GaleryModel {
    GaleryModel({
        this.id,
        this.path,
    });

    int id;
    String path;

    factory GaleryModel.fromJson(Map<String, dynamic> json) => GaleryModel(
        id: json["id"],
        path: json["path"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "path": path,
    };
}