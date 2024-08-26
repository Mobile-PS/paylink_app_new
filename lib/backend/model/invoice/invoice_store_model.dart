class InvoiceStoreModel {
  final Message message;
  final Data data;

  InvoiceStoreModel({
    required this.message,
    required this.data,
  });

  factory InvoiceStoreModel.fromJson(Map<String, dynamic> json) =>
      InvoiceStoreModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );

}

class Data {
  final Invoice invoice;

  Data({
    required this.invoice,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        invoice: Invoice.fromJson(json["invoice"]),
      );


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
 // final User user;
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
    //required this.user,
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
       // user: User.fromJson(json["user"]),
        invoiceItems: List<InvoiceItem>.from(
            json["invoice_items"].map((x) => InvoiceItem.fromJson(x))),
      );

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

class User {
  final int id;
  final String firstname;
  final String lastname;
  final String username;
  final String email;
  final dynamic mobileCode;
  final dynamic mobile;
  final dynamic fullMobile;
  final dynamic refferalUserId;
  final dynamic image;
  final int status;
  final Address address;
  final int emailVerified;
  final int smsVerified;
  final int kycVerified;
  final dynamic verCode;
  final dynamic verCodeSendAt;
  final int twoFactorVerified;
  final int twoFactorStatus;
  final dynamic twoFactorSecret;
  final dynamic deviceId;
  final dynamic emailVerifiedAt;
  final dynamic deletedAt;
  final DateTime createdAt;
  final dynamic updatedAt;
  final String fullname;
  final String userImage;
  final StringStatus stringStatus;
  final String lastLogin;
  final StringStatus kycStringStatus;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
     this.mobileCode,
     this.mobile,
     this.fullMobile,
     this.refferalUserId,
     this.image,
    required this.status,
    required this.address,
    required this.emailVerified,
    required this.smsVerified,
    required this.kycVerified,
     this.verCode,
     this.verCodeSendAt,
    required this.twoFactorVerified,
    required this.twoFactorStatus,
     this.twoFactorSecret,
     this.deviceId,
     this.emailVerifiedAt,
     this.deletedAt,
    required this.createdAt,
     this.updatedAt,
    required this.fullname,
    required this.userImage,
    required this.stringStatus,
    required this.lastLogin,
    required this.kycStringStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        username: json["username"],
        email: json["email"],
        mobileCode: json["mobile_code"]??'',
        mobile: json["mobile"]??'',
        fullMobile: json["full_mobile"]??'',
        refferalUserId: json["refferal_user_id"]??'',
        image: json["image"]??'',
        status: json["status"],
        address: Address.fromJson(json["address"]),
        emailVerified: json["email_verified"],
        smsVerified: json["sms_verified"],
        kycVerified: json["kyc_verified"],
        verCode: json["ver_code"]??'',
        verCodeSendAt: json["ver_code_send_at"]??'',
        twoFactorVerified: json["two_factor_verified"],
        twoFactorStatus: json["two_factor_status"],
        twoFactorSecret: json["two_factor_secret"]??'',
        deviceId: json["device_id"]??'',
        emailVerifiedAt: json["email_verified_at"]??'',
        deletedAt: json["deleted_at"]??'',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"]??'',
        fullname: json["fullname"],
        userImage: json["userImage"],
        stringStatus: StringStatus.fromJson(json["stringStatus"]),
        lastLogin: json["lastLogin"],
        kycStringStatus: StringStatus.fromJson(json["kycStringStatus"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "email": email,
        "mobile_code": mobileCode,
        "mobile": mobile,
        "full_mobile": fullMobile,
        "refferal_user_id": refferalUserId,
        "image": image,
        "status": status,
        "address": address.toJson(),
        "email_verified": emailVerified,
        "sms_verified": smsVerified,
        "kyc_verified": kycVerified,
        "ver_code": verCode,
        "ver_code_send_at": verCodeSendAt,
        "two_factor_verified": twoFactorVerified,
        "two_factor_status": twoFactorStatus,
        "two_factor_secret": twoFactorSecret,
        "device_id": deviceId,
        "email_verified_at": emailVerifiedAt,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "fullname": fullname,
        "userImage": userImage,
        "stringStatus": stringStatus.toJson(),
        "lastLogin": lastLogin,
        "kycStringStatus": kycStringStatus.toJson(),
      };
}

class Address {
  final String country;
  final String city;
  final String zip;
  final String state;
  final String address;
  final String companyName;

  Address({
    required this.country,
    required this.city,
    required this.zip,
    required this.state,
    required this.address,
    required this.companyName,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        country: json["country"],
        city: json["city"],
        zip: json["zip"],
        state: json["state"],
        address: json["address"],
        companyName: json["company_name"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "city": city,
        "zip": zip,
        "state": state,
        "address": address,
        "company_name": companyName,
      };
}

class StringStatus {
  final String stringStatusClass;
  final String value;

  StringStatus({
    required this.stringStatusClass,
    required this.value,
  });

  factory StringStatus.fromJson(Map<String, dynamic> json) => StringStatus(
        stringStatusClass: json["class"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "class": stringStatusClass,
        "value": value,
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