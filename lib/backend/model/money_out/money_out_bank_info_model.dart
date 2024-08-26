import 'dart:convert';

import '../../../widgets/drop_down/custom_drop_down.dart';

MoneyOutBankInfoModel moneyOutBankInfoModelFromJson(String str) => MoneyOutBankInfoModel.fromJson(json.decode(str));

String moneyOutBankInfoModelToJson(MoneyOutBankInfoModel data) => json.encode(data.toJson());

class MoneyOutBankInfoModel {
  final Message message;
  final Data data;

  MoneyOutBankInfoModel({
    required this.message,
    required this.data,
  });

  factory MoneyOutBankInfoModel.fromJson(Map<String, dynamic> json) => MoneyOutBankInfoModel(
    message: Message.fromJson(json["message"]),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message.toJson(),
    "data": data.toJson(),
  };
}

class Data {
  final List<String> success;

  Data({
    required this.success,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    success: List<String>.from(json["success"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": List<dynamic>.from(success.map((x) => x)),
  };
}

class Message {
  final List<BankInfo> bankInfo;

  Message({
    required this.bankInfo,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    bankInfo: List<BankInfo>.from(json["bank_info"].map((x) => BankInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bank_info": List<dynamic>.from(bankInfo.map((x) => x.toJson())),
  };
}

class BankInfo implements DropdownModel{
  final int id;
  final String code;
  final String name;

  BankInfo({
    required this.id,
    required this.code,
    required this.name,
  });

  factory BankInfo.fromJson(Map<String, dynamic> json) => BankInfo(
    id: json["id"],
    code: json["code"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
  };

  @override
  String get title => name;
}
