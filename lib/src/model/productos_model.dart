import 'dart:convert';

ProductosModel productosModelFromJson(String str) => ProductosModel.fromJson(json.decode(str));

List<ProductosModel> productosListModelFromJson(String str) => List<ProductosModel>.from(json.decode(str).map((x) => ProductosModel.fromJson(x)));

String productosModelToJson(ProductosModel data) => json.encode(data.toJson());

class ProductosModel {
    ProductosModel({
        this.id,
        this.name,
        this.price,
        this.description,
        this.unity,
        this.category,
        this.favorite,
    });

    int id;
    String name;
    double price;
    String description;
    int unity;
    String category;
    int favorite;

    factory ProductosModel.fromJson(Map<String, dynamic> json) => ProductosModel(
        id: json["id"],
        name: json["name"],
        price: double.parse(json["price"].toString()),
        description: json["description"],
        unity: json["unity"],
        category: json["category"],
        favorite: json["favorite"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "unity": unity,
        "category": category,
    };
}

