import 'dart:convert';

RequestGetModel requestGetModelFromJson(String str) => RequestGetModel.fromJson(json.decode(str));

String requestGetModelToJson(RequestGetModel data) => json.encode(data.toJson());

class RequestGetModel {
    RequestGetModel({
        this.code,
        this.message,
        this.body,
    });

    int code;
    String message;
    List body;

    factory RequestGetModel.fromJson(Map<String, dynamic> json) => RequestGetModel(
        code: json["code"],
        message: json["message"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "body": body,
    };
}