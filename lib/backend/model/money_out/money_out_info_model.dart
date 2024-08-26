

import '../../../widgets/drop_down/custom_drop_down.dart';

class MoneyOutInfoModel {
  final Message message;
  final Data data;

  MoneyOutInfoModel({
    required this.message,
    required this.data,
  });

  factory MoneyOutInfoModel.fromJson(Map<String, dynamic> json) =>
      MoneyOutInfoModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final String baseCurr;
  final String baseCurrRate;
  final String defaultImage;
  final String imagePath;
  final UserWallet userWallet;
  final List<Gateway> gateways;
  final List<Transaction> transactions;

  Data({
    required this.baseCurr,
    required this.baseCurrRate,
    required this.defaultImage,
    required this.imagePath,
    required this.userWallet,
    required this.gateways,
    required this.transactions,
  });

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(
        baseCurr: json["base_curr"],
        baseCurrRate: json["base_curr_rate"],
        defaultImage: json["default_image"],
        imagePath: json["image_path"],
        userWallet: UserWallet.fromJson(json["userWallet"]),
        gateways: List<Gateway>.from(
            json["gateways"].map((x) => Gateway.fromJson(x))),
        transactions: List<Transaction>.from(
            json["transactions"].map((x) => Transaction.fromJson(x))),
      );
}

class Gateway {
  final int id;
  final String name;
  final dynamic image;
  final String slug;
  final int code;
  final String type;
  final String alias;
  final List<String> supportedCurrencies;
  final List<InputField> inputFields;
  final int status;
  final List<Currency> currencies;

  Gateway({
    required this.id,
    required this.name,
    required this.image,
    required this.slug,
    required this.code,
    required this.type,
    required this.alias,
    required this.supportedCurrencies,
    required this.inputFields,
    required this.status,
    required this.currencies,
  });

  factory Gateway.fromJson(Map<String, dynamic> json) =>
      Gateway(
        id: json["id"],
        name: json["name"],
        image: json["image"] ?? '',
        slug: json["slug"],
        code: json["code"],
        type: json["type"],
        alias: json["alias"],
        supportedCurrencies:
        List<String>.from(json["supported_currencies"].map((x) => x)),
        inputFields: json["input_fields"] != null
            ? List<InputField>.from(
            json["input_fields"].map((x) => InputField.fromJson(x)))
            : [],
        status: json["status"],
        currencies: List<Currency>.from(
            json["currencies"].map((x) => Currency.fromJson(x))),
      );
}

class Currency implements DropdownModel {
  final dynamic id;
  final dynamic paymentGatewayId;
  final String type;
  final String name;
  final String alias;
  final String currencyCode;
  final String currencySymbol;
  final dynamic image;
  final dynamic minLimit;
  final dynamic maxLimit;
  final dynamic percentCharge;
  final dynamic fixedCharge;
  final dynamic rate;

  Currency({
    this.id,
    this.paymentGatewayId,
    required this.type,
    required this.name,
    required this.alias,
    required this.currencyCode,
    required this.currencySymbol,
    this.image,
    this.minLimit,
    this.maxLimit,
    this.percentCharge,
    this.fixedCharge,
    this.rate,
  });

  factory Currency.fromJson(Map<String, dynamic> json) =>
      Currency(
        id: json["id"] ?? '',
        paymentGatewayId: json["payment_gateway_id"] ?? '',
        type: json["type"],
        name: json["name"],
        alias: json["alias"],
        currencyCode: json["currency_code"],
        currencySymbol: json["currency_symbol"],
        image: json["image"] ?? '',
        minLimit: json["min_limit"] ?? 0.0,
        maxLimit: json["max_limit"] ?? 0.0,
        percentCharge: json["percent_charge"] ?? 0.0,
        fixedCharge: json["fixed_charge"] ?? 0.0,
        rate: json["rate"] ?? 0.0,
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "payment_gateway_id": paymentGatewayId,
        "type": type,
        "name": name,
        "alias": alias,
        "currency_code": currencyCode,
        "currency_symbol": currencySymbol,
        "image": image,
        "min_limit": minLimit,
        "max_limit": maxLimit,
        "percent_charge": percentCharge,
        "fixed_charge": fixedCharge,
        "rate": rate,
      };

  @override
  String get title => name;
}

class InputField {
  final String type;
  final String label;
  final String name;
  final bool required;
  final Validation validation;

  InputField({
    required this.type,
    required this.label,
    required this.name,
    required this.required,
    required this.validation,
  });

  factory InputField.fromJson(Map<String, dynamic> json) =>
      InputField(
        type: json["type"],
        label: json["label"],
        name: json["name"],
        required: json["required"],
        validation: Validation.fromJson(json["validation"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "type": type,
        "label": label,
        "name": name,
        "required": required,
        "validation": validation.toJson(),
      };
}

class Validation {
  final String max;
  final List<dynamic> mimes;
  final String min;
  final List<dynamic> options;
  final bool required;

  Validation({
    required this.max,
    required this.mimes,
    required this.min,
    required this.options,
    required this.required,
  });

  factory Validation.fromJson(Map<String, dynamic> json) =>
      Validation(
        max: json["max"],
        mimes: List<dynamic>.from(json["mimes"].map((x) => x)),
        min: json["min"],
        options: List<dynamic>.from(json["options"].map((x) => x)),
        required: json["required"],
      );

  Map<String, dynamic> toJson() =>
      {
        "max": max,
        "mimes": List<dynamic>.from(mimes.map((x) => x)),
        "min": min,
        "options": List<dynamic>.from(options.map((x) => x)),
        "required": required,
      };
}

class Transaction {
  final int id;
  final String trx;
  final String gatewayName;
  final String gatewayCurrencyName;
  final String transactionType;
  final String requestAmount;
  final String payable;
  final String exchangeRate;
  final String totalCharge;
  final String currentBalance;
  final String status;
  final DateTime dateTime;
  final StatusInfo statusInfo;
  final String rejectionReason;

  Transaction({
    required this.id,
    required this.trx,
    required this.gatewayName,
    required this.gatewayCurrencyName,
    required this.transactionType,
    required this.requestAmount,
    required this.payable,
    required this.exchangeRate,
    required this.totalCharge,
    required this.currentBalance,
    required this.status,
    required this.dateTime,
    required this.statusInfo,
    required this.rejectionReason,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      Transaction(
        id: json["id"],
        trx: json["trx"],
        gatewayName: json["gateway_name"],
        gatewayCurrencyName: json["gateway_currency_name"],
        transactionType: json["transaction_type"],
        requestAmount: json["request_amount"],
        payable: json["payable"],
        exchangeRate: json["exchange_rate"],
        totalCharge: json["total_charge"],
        currentBalance: json["current_balance"],
        status: json["status"],
        dateTime: DateTime.parse(json["date_time"]),
        statusInfo: StatusInfo.fromJson(json["status_info"]),
        rejectionReason: json["rejection_reason"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "trx": trx,
        "gateway_name": gatewayName,
        "gateway_currency_name": gatewayCurrencyName,
        "transaction_type": transactionType,
        "request_amount": requestAmount,
        "payable": payable,
        "exchange_rate": exchangeRate,
        "total_charge": totalCharge,
        "current_balance": currentBalance,
        "status": status,
        "date_time": dateTime.toIso8601String(),
        "status_info": statusInfo.toJson(),
        "rejection_reason": rejectionReason,
      };
}

class StatusInfo {
  final int success;
  final int pending;
  final int rejected;

  StatusInfo({
    required this.success,
    required this.pending,
    required this.rejected,
  });

  factory StatusInfo.fromJson(Map<String, dynamic> json) =>
      StatusInfo(
        success: json["success"],
        pending: json["pending"],
        rejected: json["rejected"],
      );

  Map<String, dynamic> toJson() =>
      {
        "success": success,
        "pending": pending,
        "rejected": rejected,
      };
}

class UserWallet {
  final String balance;
  final String currency;

  UserWallet({
    required this.balance,
    required this.currency,
  });

  factory UserWallet.fromJson(Map<String, dynamic> json) =>
      UserWallet(
        balance: json["balance"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() =>
      {
        "balance": balance,
        "currency": currency,
      };
}

class Message {
  final List<String> success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      Message(
        success: List<String>.from(json["success"].map((x) => x)),
      );

  Map<String, dynamic> toJson() =>
      {
        "success": List<dynamic>.from(success.map((x) => x)),
      };
}
