import 'dart:convert';

List<MunicipiosModel> municipiosListModelFromJson(String str) => List<MunicipiosModel>.from(json.decode(str).map((x) => MunicipiosModel.fromJson(x)));

String municipiosListModelToJson(List<MunicipiosModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MunicipiosModel {
    MunicipiosModel({
        this.id,
        this.municipio,
    });

    int id;
    String municipio;

    factory MunicipiosModel.fromJson(Map<String, dynamic> json) => MunicipiosModel(
        id: json["id"],
        municipio: json["municipio"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "municipio": municipio,
    };
}