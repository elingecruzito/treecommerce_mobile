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
    String body;

    factory RequestModel.fromJson(Map<String, dynamic> data) => RequestModel(
        code: data["code"],
        message: data["message"],
        body: json.encode(data["body"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "body": body,
    };
}
