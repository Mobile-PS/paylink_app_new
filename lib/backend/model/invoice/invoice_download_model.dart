class InvoiceDownloadModel {
  final Message message;
  final Data data;

  InvoiceDownloadModel({
    required this.message,
    required this.data,
  });

  factory InvoiceDownloadModel.fromJson(Map<String, dynamic> json) =>
      InvoiceDownloadModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final String downloadUrl;

  Data({
    required this.downloadUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        downloadUrl: json["download_url"],
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
}