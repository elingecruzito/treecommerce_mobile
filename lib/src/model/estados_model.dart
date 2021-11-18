import 'dart:convert';

List<EstadoModel> estadoListModelFromJson(String str) => List<EstadoModel>.from(json.decode(str).map((x) => EstadoModel.fromJson(x)));

String estadoListModelToJson(List<EstadoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EstadoModel {
    EstadoModel({
        this.id,
        this.estado,
    });

    int id;
    String estado;

    factory EstadoModel.fromJson(Map<String, dynamic> json) => EstadoModel(
        id: json["id"],
        estado: json["estado"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "estado": estado,
    };
}