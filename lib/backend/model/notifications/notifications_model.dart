class NotificationsModel {
  final NotificationsModelMessage message;
  final Data data;

  NotificationsModel({
    required this.message,
    required this.data,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
    message: NotificationsModelMessage.fromJson(json["message"]),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message.toJson(),
    "data": data.toJson(),
  };
}

class Data {
  final List<Notification> notifications;

  Data({
    required this.notifications,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notifications: List<Notification>.from(json["notifications"].map((x) => Notification.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "notifications": List<dynamic>.from(notifications.map((x) => x.toJson())),
  };
}

class Notification {
  final int id;
  final String type;
  final NotificationMessage message;
  final DateTime createdAt;

  Notification({
    required this.id,
    required this.type,
    required this.message,
    required this.createdAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["id"],
    type: json["type"],
    message: NotificationMessage.fromJson(json["message"]),
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "message": message.toJson(),
    "created_at": createdAt.toIso8601String(),
  };
}

class NotificationMessage {
  final String title;
  final String message;
  final String image;

  NotificationMessage({
    required this.title,
    required this.message,
    required this.image,
  });

  factory NotificationMessage.fromJson(Map<String, dynamic> json) => NotificationMessage(
    title: json["title"],
    message: json["message"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "message": message,
    "image": image,
  };
}

class NotificationsModelMessage {
  final List<String> success;

  NotificationsModelMessage({
    required this.success,
  });

  factory NotificationsModelMessage.fromJson(Map<String, dynamic> json) => NotificationsModelMessage(
    success: List<String>.from(json["success"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": List<dynamic>.from(success.map((x) => x)),
  };
}