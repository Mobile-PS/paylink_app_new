class DashboardModel {
  final Message message;
  final Data data;

  DashboardModel({
    required this.message,
    required this.data,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final Wallet wallet;
  final String collectionPayment;
  final String collectionInvoice;
  final String moneyOut;
  final String totalPaymentLink;
  final String totalInvoice;
  final List<Transaction> transactions;

  Data({
    required this.wallet,
    required this.collectionPayment,
    required this.collectionInvoice,
    required this.moneyOut,
    required this.totalPaymentLink,
    required this.totalInvoice,
    required this.transactions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        wallet: Wallet.fromJson(json["wallet"]),
        collectionPayment: json["collection_payment"],
        collectionInvoice: json["collection_invoice"],
        moneyOut: json["money_out"],
        totalPaymentLink: json["total_payment_link"],
        totalInvoice: json["total_invoice"],
        transactions: List<Transaction>.from(
            json["transactions"].map((x) => Transaction.fromJson(x))),
      );
}

class Transaction {
  final int id;
  final String trx;
  final String transactionType;
  final String? transactionHeading;
  final String requestAmount;
  final String currentBalance;
  final String? receiveAmount;
  final String exchangeRate;
  final String totalCharge;
  final String? remark;
  final String status;
  final DateTime dateTime;
  final StatusInfo statusInfo;
  final String? gatewayName;
  final String? gatewayCurrencyName;
  final dynamic payable;
  final String? rejectionReason;
  final dynamic cardHolderName;
  final dynamic senderEmail;
  final dynamic senderCardNumber;
  final String? paymentType;
  final dynamic paymentTypeTitle;
  final dynamic senderFullName;

  Transaction({
    required this.id,
    required this.trx,
    required this.transactionType,
    this.transactionHeading,
    required this.requestAmount,
    required this.currentBalance,
    this.receiveAmount,
    required this.exchangeRate,
    required this.totalCharge,
    this.remark,
    required this.status,
    required this.dateTime,
    required this.statusInfo,
    this.gatewayName,
    this.gatewayCurrencyName,
    this.payable,
    this.rejectionReason,
    this.cardHolderName,
    this.senderEmail,
    this.senderCardNumber,
    this.paymentType,
    this.paymentTypeTitle,
    this.senderFullName
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        trx: json["trx"],
        transactionType: json["transaction_type"],
        transactionHeading: json["transaction_heading"],
        requestAmount: json["request_amount"],
        currentBalance: json["current_balance"],
        receiveAmount: json["receive_amount"],
        exchangeRate: json["exchange_rate"],
        totalCharge: json["total_charge"],
        remark: json["remark"],
        status: json["status"],
        dateTime: DateTime.parse(json["date_time"]),
        statusInfo: StatusInfo.fromJson(json["status_info"]),
        gatewayName: json["gateway_name"],
        gatewayCurrencyName: json["gateway_currency_name"],
        payable: json["payable"],
        rejectionReason: json["rejection_reason"],
        cardHolderName: json["card_holder_name"] ?? '',
        senderEmail: json["sender_email"] ?? '',
        senderCardNumber: json["sender_card_number"] ?? '',
    paymentType: json["payment_type"] ?? '',
    paymentTypeTitle: json["payment_type_title"] ?? '',
    senderFullName: json["sender_full_name"] ?? '',
      );
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

  factory StatusInfo.fromJson(Map<String, dynamic> json) => StatusInfo(
        success: json["success"],
        pending: json["pending"],
        rejected: json["rejected"],
      );
}

class Wallet {
  final int id;
  final String code;
  final String name;
  final String balance;

  Wallet({
    required this.id,
    required this.code,
    required this.name,
    required this.balance,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        balance: json["balance"],
      );
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


