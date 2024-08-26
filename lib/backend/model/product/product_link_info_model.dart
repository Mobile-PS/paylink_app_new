import 'dart:convert';

import '../../../widgets/drop_down/custom_drop_down.dart';

ProductLinkInfoModel productLinkInfoModelFromJson(String str) =>
    ProductLinkInfoModel.fromJson(json.decode(str));

String productLinkInfoModelToJson(ProductLinkInfoModel data) =>
    json.encode(data.toJson());

class ProductLinkInfoModel {
  final Message message;
  final Data data;

  ProductLinkInfoModel({
    required this.message,
    required this.data,
  });

  factory ProductLinkInfoModel.fromJson(Map<String, dynamic> json) =>
      ProductLinkInfoModel(
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
  final List<ProductLink> productLinks;

  Data({
    required this.baseUrl,
    required this.defaultImage,
    required this.imagePath,
    required this.currencyData,
    required this.productLinks,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        baseUrl: json["base_url"],
        defaultImage: json["default_image"],
        imagePath: json["image_path"],
        currencyData: List<CurrencyDatum>.from(
            json["currency_data"].map((x) => CurrencyDatum.fromJson(x))),
        productLinks: List<ProductLink>.from(
            json["product_links"].map((x) => ProductLink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "base_url": baseUrl,
        "default_image": defaultImage,
        "image_path": imagePath,
        "currency_data":
            List<dynamic>.from(currencyData.map((x) => x.toJson())),
        "product_links":
            List<dynamic>.from(productLinks.map((x) => x.toJson())),
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

class ProductLink {
  final ProductLinks productLinks;

  ProductLink({
    required this.productLinks,
  });

  factory ProductLink.fromJson(Map<String, dynamic> json) => ProductLink(
        productLinks: ProductLinks.fromJson(json["product_links"]),
      );

  Map<String, dynamic> toJson() => {
        "product_links": productLinks.toJson(),
      };
}

class ProductLinks {
  final int id;
  final int productId;
  final String currency;
  final String currencyName;
  final String currencySymbol;
  final String country;
  final String price;
  final int qty;
  final String token;
  final int status;
  final String stringStatus;
  final DateTime createdAt;

  ProductLinks({
    required this.id,
    required this.productId,
    required this.currency,
    required this.currencyName,
    required this.currencySymbol,
    required this.country,
    required this.price,
    required this.qty,
    required this.token,
    required this.status,
    required this.stringStatus,
    required this.createdAt,
  });

  factory ProductLinks.fromJson(Map<String, dynamic> json) => ProductLinks(
        id: json["id"],
        productId: json["product_id"],
        currency: json["currency"],
        currencyName: json["currency_name"],
        currencySymbol: json["currency_symbol"],
        country: json["country"],
        price: json["price"],
        qty: json["qty"],
        token: json["token"],
        status: json["status"],
        stringStatus: json["string_status"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "currency": currency,
        "currency_name": currencyName,
        "currency_symbol": currencySymbol,
        "country": country,
        "price": price,
        "qty": qty,
        "token": token,
        "status": status,
        "string_status": stringStatus,
        "created_at": createdAt.toIso8601String(),
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
