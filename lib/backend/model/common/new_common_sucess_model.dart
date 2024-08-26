import 'dart:convert';

NewCommonSuccessModel newCommonSuccessModelFromJson(String str) =>
    NewCommonSuccessModel.fromJson(json.decode(str));

String newCommonSuccessModelToJson(NewCommonSuccessModel data) =>
    json.encode(data.toJson());

class NewCommonSuccessModel {
  final Message message;

  NewCommonSuccessModel({
    required this.message,
  });

  factory NewCommonSuccessModel.fromJson(Map<String, dynamic> json) =>
      NewCommonSuccessModel(
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
      };
}

class Message {
  final List<String> success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: List<String>.from(json["success"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": List<dynamic>.from(success.map((x) => x)),
      };
}
