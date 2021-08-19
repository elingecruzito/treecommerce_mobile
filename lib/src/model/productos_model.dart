import 'dart:convert';

ProductosModel productosModelFromJson(String str) => ProductosModel.fromJson(json.decode(str));

String productosModelToJson(ProductosModel data) => json.encode(data.toJson());

class ProductosModel {
    ProductosModel({
        this.g01Id,
        this.g01Name,
        this.g01Precio,
        this.g01Descripcion,
        this.g01Imagens,
    });

    int g01Id;
    String g01Name;
    String g01Precio;
    String g01Descripcion;
    String g01Imagens;

    factory ProductosModel.fromJson(Map<String, dynamic> json) => ProductosModel(
        g01Id: json["g01_id"],
        g01Name: json["g01_name"],
        g01Precio: json["g01_precio"],
        g01Descripcion: json["g01_descripcion"],
        g01Imagens: json["g01_imagens"],
    );

    Map<String, dynamic> toJson() => {
        "g01_id": g01Id,
        "g01_name": g01Name,
        "g01_precio": g01Precio,
        "g01_descripcion": g01Descripcion,
        "g01_imagens": g01Imagens,
    };
}

