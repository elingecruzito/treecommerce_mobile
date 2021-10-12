import 'dart:convert';

List<ValorationsModel> valorationsModelFromJson(String str) => List<ValorationsModel>.from(json.decode(str).map((x) => ValorationsModel.fromJson(x)));

String valorationsModelToJson(List<ValorationsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ValorationsModel {
    ValorationsModel({
        this.id,
        this.starts,
        this.comment,
        this.product,
    });

    int id;
    int starts;
    String comment;
    String product;

    factory ValorationsModel.fromJson(Map<String, dynamic> json) => ValorationsModel(
        id: json["id"],
        starts: json["starts"],
        comment: json["comment"],
        product: json["product"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "starts": starts,
        "comment": comment,
        "product": product,
    };
}