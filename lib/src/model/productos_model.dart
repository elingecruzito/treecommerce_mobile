import 'dart:convert';

ProductosModel productosModelFromJson(String str) => ProductosModel.fromJson(json.decode(str));

List<ProductosModel> productosListModelFromJson(String str) => List<ProductosModel>.from(json.decode(str).map((x) => ProductosModel.fromJson(x)));

String productosModelToJson(ProductosModel data) => json.encode(data.toJson());

List<String> productosListModelToJson(List<ProductosModel> data) => data.map((item) => productosModelToJson(item)).toList();

class ProductosModel {
    ProductosModel({
        this.id,
        this.name,
        this.price,
        this.description,
        this.unity,
        this.category,

        this.id_category,
        this.provider,
        this.valorarion,
        this.count_valoration,

        this.favorite,
        this.porcentage,
        this.total,
    });

    int id;
    String name;
    double price;
    String description;
    int unity;
    String category;

    int id_category;
    String provider;
    double valorarion;
    int count_valoration;

    bool favorite;
    int porcentage;
    double total;

    factory ProductosModel.fromJson(Map<String, dynamic> json) => ProductosModel(
        id: json["id"],
        name: json["name"],
        price: double.parse(json["price"].toString()),
        description: json["description"],
        unity: json["unity"],
        category: json["category"],

        id_category: json["id_category"],
        provider: json["provider"],
        valorarion: double.parse(json["valoration"].toString()),
        count_valoration: json["count_valoration"],

        favorite: json["favorite"] == 1 ? true : false,
        porcentage: json["percentage"],
        total: json["percentage"] == 0 ? 
                double.parse(json["price"].toString()) : 
                (double.parse(json["price"].toString()) - ( double.parse(json["price"].toString()) * ( json["percentage"] / 100) ) ),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "unity": unity,
        "category": category,

        "id_category" : id_category,
        "provider" : provider,
        "valoration" : valorarion,
        "count_valoration" : count_valoration,

        "favorite": favorite,
        "percentage": porcentage,
        "total": total,
    };
}

