import '../../../widgets/drop_down/custom_drop_down.dart';

class InvoiceModel {
  final Message message;
  final Data data;

  InvoiceModel({
    required this.message,
    required this.data,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final List<Invoice> invoices;
  final Status status;
  final List<CurrencyDatum> currencyData;

  Data({
    required this.invoices,
    required this.status,
    required this.currencyData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        invoices: List<Invoice>.from(
            json["invoices"].map((x) => Invoice.fromJson(x))),
        status: Status.fromJson(json["status"]),
        currencyData: List<CurrencyDatum>.from(
            json["currency_data"].map((x) => CurrencyDatum.fromJson(x))),
      );
}

class CurrencyDatum implements DropdownModel {
  final dynamic currencyName;
  final dynamic currencyCode;
  final dynamic country;
  final dynamic currencySymbol;

  CurrencyDatum({
    this.currencyName,
    this.currencyCode,
    this.country,
    this.currencySymbol,
  });

  factory CurrencyDatum.fromJson(Map<String, dynamic> json) => CurrencyDatum(
        currencyName: json["name"] ?? '',
        currencyCode: json["code"] ?? '',
        country: json["country"] ?? '',
        currencySymbol: json["symbol"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "currency_name": currencyName,
        "currency_code": currencyCode,
        "country": country,
        "currency_symbol": currencySymbol,
      };

  @override
  String get title => currencyCode + '-' + currencyName!;
}

class Invoice {
  final int id;
  final int userId;
  final String currency;
  final String currencySymbol;
  final String currencyName;
  final String country;
  final String invoiceNo;
  final String token;
  final String title;
  final String name;
  final String email;
  final String phone;
  final int qty;
  final String amount;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<InvoiceItem> invoiceItems;

  Invoice({
    required this.id,
    required this.userId,
    required this.currency,
    required this.currencySymbol,
    required this.currencyName,
    required this.country,
    required this.invoiceNo,
    required this.token,
    required this.title,
    required this.name,
    required this.email,
    required this.phone,
    required this.qty,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.invoiceItems,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: json["id"],
        userId: json["user_id"],
        currency: json["currency"],
        currencySymbol: json["currency_symbol"],
        currencyName: json["currency_name"],
        country: json["country"],
        invoiceNo: json["invoice_no"],
        token: json["token"],
        title: json["title"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        qty: json["qty"],
        amount: json["amount"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        invoiceItems: List<InvoiceItem>.from(
            json["invoice_items"].map((x) => InvoiceItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "currency": currency,
        "currency_symbol": currencySymbol,
        "currency_name": currencyName,
        "country": country,
        "invoice_no": invoiceNo,
        "token": token,
        "title": title,
        "name": name,
        "email": email,
        "phone": phone,
        "qty": qty,
        "amount": amount,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "invoice_items":
            List<dynamic>.from(invoiceItems.map((x) => x.toJson())),
      };
}

class InvoiceItem {
  final int id;
  final int invoiceItemId;
  final String title;
  final int qty;
  final String price;
  final DateTime createdAt;
  final DateTime updatedAt;

  InvoiceItem({
    required this.id,
    required this.invoiceItemId,
    required this.title,
    required this.qty,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InvoiceItem.fromJson(Map<String, dynamic> json) => InvoiceItem(
        id: json["id"],
        invoiceItemId: json["invoice_item_id"],
        title: json["title"],
        qty: json["qty"],
        price: json["price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "invoice_item_id": invoiceItemId,
        "title": title,
        "qty": qty,
        "price": price,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Status {
  final int paid;
  final int unpaid;
  final int draft;

  Status({
    required this.paid,
    required this.unpaid,
    required this.draft,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        paid: json["Paid"],
        unpaid: json["Unpaid"],
        draft: json["Draft"],
      );

  Map<String, dynamic> toJson() => {
        "Paid": paid,
        "Unpaid": unpaid,
        "Draft": draft,
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
