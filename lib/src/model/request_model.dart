import 'dart:convert';

RequestModel requestModelFromJson(String str) => RequestModel.fromJson(json.decode(str));

String requestModelToJson(RequestModel data) => json.encode(data.toJson());

class RequestModel {
    RequestModel({
        this.code,
        this.message,
        this.body,
    });

    int code;
    String message;
    Map<String, dynamic> body;

    factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
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
