import 'dart:convert';

import '../../../widgets/drop_down/custom_drop_down.dart';

EditInfoModel editInfoModelFromJson(String str) =>
    EditInfoModel.fromJson(json.decode(str));

String editInfoModelToJson(EditInfoModel data) => json.encode(data.toJson());

class EditInfoModel {
  final Message message;
  final Data data;

  EditInfoModel({
    required this.message,
    required this.data,
  });

  factory EditInfoModel.fromJson(Map<String, dynamic> json) => EditInfoModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  final String baseUrl;
  final String defaultImage;
  final String imagePath;
  final List<CurrencyDatum> currencyData;
  final Product product;

  Data({
    required this.baseUrl,
    required this.defaultImage,
    required this.imagePath,
    required this.currencyData,
    required this.product,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        baseUrl: json["base_url"],
        defaultImage: json["default_image"],
        imagePath: json["image_path"],
        currencyData: List<CurrencyDatum>.from(
            json["currency_data"].map((x) => CurrencyDatum.fromJson(x))),
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "base_url": baseUrl,
        "default_image": defaultImage,
        "image_path": imagePath,
        "currency_data":
            List<dynamic>.from(currencyData.map((x) => x.toJson())),
        "product": product.toJson(),
      };
}

class CurrencyDatum implements DropdownModel {
  final dynamic country;
  final dynamic id;
  final dynamic name;
  final dynamic code;
  final dynamic symbol;
  final dynamic type;

  CurrencyDatum({
    required this.country,
    required this.id,
    required this.name,
    required this.code,
    required this.symbol,
    required this.type,
  });

  factory CurrencyDatum.fromJson(Map<String, dynamic> json) => CurrencyDatum(
        country: json["country"],
        id: json["id"],
        name: json["name"],
        code: json["code"],
        symbol: json["symbol"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        // "country": country,
        "name": name,
        "id": id,
        "code": code,
        "symbol": symbol,
        "type": type,
      };

  @override
  // TODO: implement title
  String get title => '$code-$name';
}

class Product {
  final int id;
  final dynamic currency;
  final dynamic currencyName;
  final dynamic currencySymbol;
  final dynamic country;
  final dynamic productName;
  final dynamic image;
  final dynamic desc;
  final dynamic price;
  final int status;
  final dynamic stringStatus;

  Product({
    required this.id,
    required this.currency,
    required this.currencyName,
    required this.currencySymbol,
    required this.country,
    required this.productName,
    required this.image,
    required this.desc,
    required this.price,
    required this.status,
    required this.stringStatus,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        currency: json["currency"] ?? '',
        currencyName: json["currency_name"] ?? '',
        currencySymbol: json["currency_symbol"] ?? '',
        country: json["country"] ?? '',
        productName: json["product_name"] ?? '',
        image: json["image"] ?? '',
        desc: json["desc"] ?? '',
        price: json["price"] ?? '',
        status: json["status"],
        stringStatus: json["string_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currency": currency,
        "currency_name": currencyName,
        "currency_symbol": currencySymbol,
        "country": country,
        "product_name": productName,
        "image": image,
        "desc": desc,
        "price": price,
        "status": status,
        "string_status": stringStatus,
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
