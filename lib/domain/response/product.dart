import 'dart:convert';

ProductResponseModel productResponseModelFromJson(String str) => ProductResponseModel.fromJson(json.decode(str));

String productResponseModelToJson(ProductResponseModel data) => json.encode(data.toJson());

class ProductResponseModel {
    ProductResponseModel({
        this.nombre,
        this.descripcion,
        this.uid,
        this.existencia,
        this.valor,
        this.update
    });

    String? nombre;
    String? descripcion;
    String? uid;
    int? existencia;
    int? valor;
    String? update;

     
    factory ProductResponseModel.fromJson(Map<String, dynamic> json) => ProductResponseModel(
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        existencia: json["existencia"],
        valor: json["valor"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "descripcion":descripcion,
        "existencia":existencia,
        "valor":valor,
        "fecha": DateTime.now().millisecondsSinceEpoch
    };
}