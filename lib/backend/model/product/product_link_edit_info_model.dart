import 'dart:convert';

import '../../../widgets/drop_down/custom_drop_down.dart';

ProductLinkEditInfoModel productLinkEditInfoModelFromJson(String str) =>
    ProductLinkEditInfoModel.fromJson(json.decode(str));

String productLinkEditInfoModelToJson(ProductLinkEditInfoModel data) =>
    json.encode(data.toJson());

class ProductLinkEditInfoModel {
  final Message message;
  final Data data;

  ProductLinkEditInfoModel({
    required this.message,
    required this.data,
  });

  factory ProductLinkEditInfoModel.fromJson(Map<String, dynamic> json) =>
      ProductLinkEditInfoModel(
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
  final List<CurrencyDatum> currencyData;
  final Product product;

  Data({
    required this.baseUrl,
    required this.currencyData,
    required this.product,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        baseUrl: json["base_url"],
        currencyData: List<CurrencyDatum>.from(
            json["currency_data"].map((x) => CurrencyDatum.fromJson(x))),
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "base_url": baseUrl,
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
  final int userId;
  final int productId;
  final String currency;
  final String currencyName;
  final String currencySymbol;
  final String country;
  final String price;
  final int quantity;
  final int status;

  Product({
    required this.id,
    required this.userId,
    required this.productId,
    required this.currency,
    required this.currencyName,
    required this.currencySymbol,
    required this.country,
    required this.price,
    required this.quantity,
    required this.status,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        currency: json["currency"],
        currencyName: json["currency_name"],
        currencySymbol: json["currency_symbol"],
        country: json["country"],
        price: json["price"],
        quantity: json["quantity"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "currency": currency,
        "currency_name": currencyName,
        "currency_symbol": currencySymbol,
        "country": country,
        "price": price,
        "quantity": quantity,
        "status": status,
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
