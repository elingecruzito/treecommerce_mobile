import 'dart:convert';

import 'package:treecommerce/src/utilerias/utils.dart';

List<BuysModel> buysListModelFromJson(String str) => List<BuysModel>.from(json.decode(str).map((x) => BuysModel.fromJson(x)));

String buysListModelToJson(List<BuysModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

BuysModel buysModelFromJson(String str) => BuysModel.fromJson(json.decode(str));

String buysModelToJson(BuysModel data) => json.encode(data.toJson());

class BuysModel {
    BuysModel({
        this.id,
        this.idUser,
        this.status,
        this.idStatus,
        this.idProduct,
        this.name,
        this.count,
        this.cost,
        this.total,
        this.description,
        this.address,
        this.cp,
        this.phone,
        this.person,
        this.estado,
        this.municipio,
        this.createdAt,
    });

    int id;
    int idUser;
    String status;
    int idStatus;
    int idProduct;
    String name;
    int count;
    int cost;
    int total;
    String description;
    String address;
    int cp;
    String phone;
    String person;
    String estado;
    String municipio;
    String createdAt;

    factory BuysModel.fromJson(Map<String, dynamic> json) => BuysModel(
        id: json["id"],
        idUser: json["id_user"],
        status: json["status"],
        idStatus: json["id_status"],
        idProduct: json["id_product"],
        name: json["name"],
        count: json["count"],
        cost: json["cost"],
        total: json["total"],
        description: json["description"],
        address: json["address"],
        cp: json["cp"],
        phone: json["phone"],
        person: json["person"],
        estado: json["estado"],
        municipio: json["municipio"],
        createdAt: parseDate(DateTime.parse(json["created_at"])),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "status": status,
        "id_status": idStatus,
        "id_product": idProduct,
        "name": name,
        "count": count,
        "cost": cost,
        "total": total,
        "description": description,
        "address": address,
        "cp": cp,
        "phone": phone,
        "person": person,
        "estado": estado,
        "municipio": municipio,
        "created_at": createdAt,
    };
}
