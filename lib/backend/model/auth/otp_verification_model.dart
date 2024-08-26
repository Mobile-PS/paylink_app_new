// To parse this JSON data, do
//
//     final otpVerificationModel = otpVerificationModelFromJson(jsonString);

import 'dart:convert';

OtpVerificationModel otpVerificationModelFromJson(String str) => OtpVerificationModel.fromJson(json.decode(str));

String otpVerificationModelToJson(OtpVerificationModel data) => json.encode(data.toJson());

class OtpVerificationModel {
  final Message message;
  final Data data;

  OtpVerificationModel({
    required this.message,
    required this.data,
  });

  factory OtpVerificationModel.fromJson(Map<String, dynamic> json) => OtpVerificationModel(
    message: Message.fromJson(json["message"]),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message.toJson(),
    "data": data.toJson(),
  };
}

class Data {
  final PasswordResetData passwordResetData;

  Data({
    required this.passwordResetData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    passwordResetData: PasswordResetData.fromJson(json["password_reset_data"]),
  );

  Map<String, dynamic> toJson() => {
    "password_reset_data": passwordResetData.toJson(),
  };
}

class PasswordResetData {
  final String token;

  PasswordResetData({
    required this.token,
  });

  factory PasswordResetData.fromJson(Map<String, dynamic> json) => PasswordResetData(
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
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