import 'dart:convert';

ProvidersModel providersModelFromJson(String str) => ProvidersModel.fromJson(json.decode(str));

String providersModelToJson(ProvidersModel data) => json.encode(data.toJson());

class ProvidersModel {
    ProvidersModel({
        this.id,
        this.name,
        this.phone,
        this.address,
        this.valoration,
    });

    int id;
    String name;
    String phone;
    String address;
    double valoration;

    factory ProvidersModel.fromJson(Map<String, dynamic> json) => ProvidersModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        valoration: double.parse(json["valoration"].toString()),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "address": address,
        "valoration": valoration,
    };
}