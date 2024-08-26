class InvoiceEditModel {
  final Message message;
  final Data data;

  InvoiceEditModel({
    required this.message,
    required this.data,
  });

  factory InvoiceEditModel.fromJson(Map<String, dynamic> json) => InvoiceEditModel(
    message: Message.fromJson(json["message"]),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message.toJson(),
    "data": data.toJson(),
  };
}

class Data {
  final Invoice invoice;

  Data({
    required this.invoice,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    invoice: Invoice.fromJson(json["invoice"]),
  );

  Map<String, dynamic> toJson() => {
    "invoice": invoice.toJson(),
  };
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
    invoiceItems: List<InvoiceItem>.from(json["invoice_items"].map((x) => InvoiceItem.fromJson(x))),
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
    "invoice_items": List<dynamic>.from(invoiceItems.map((x) => x.toJson())),
  };
}

class InvoiceItem {
  final int id;
  final int invoiceItemId;
  final String title;
  final int qty;
  final dynamic price;
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