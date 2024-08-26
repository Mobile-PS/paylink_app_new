import 'dart:convert';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  final Message message;
  final Data data;

  SignUpModel({
    required this.message,
    required this.data,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  final String token;
  final String imagePath;
  final String defaultImage;
  final String baseUr;
  final User user;

  Data({
    required this.token,
    required this.imagePath,
    required this.defaultImage,
    required this.baseUr,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        imagePath: json["image_path"],
        defaultImage: json["default_image"],
        baseUr: json["base_ur"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "image_path": imagePath,
        "default_image": defaultImage,
        "base_ur": baseUr,
        "user": user.toJson(),
      };
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String mobileCode;
  final String mobile;
  final String fullMobile;
  final Address address;
  final int status;
  final String email;
  final String image;
  final String verCode;
  final String verCodeSendAt;
  final String emailVerifiedAt;
  final int emailVerified;
  final int smsVerified;
  final int kycVerified;
  final int twoFactorVerified;
  final int twoFactorStatus;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.mobileCode,
    required this.mobile,
    required this.fullMobile,
    required this.address,
    required this.status,
    required this.email,
    required this.image,
    required this.verCode,
    required this.verCodeSendAt,
    required this.emailVerifiedAt,
    required this.emailVerified,
    required this.smsVerified,
    required this.kycVerified,
    required this.twoFactorVerified,
    required this.twoFactorStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        mobileCode: json["mobile_code"],
        mobile: json["mobile"],
        fullMobile: json["full_mobile"],
        address: Address.fromJson(json["address"]),
        status: json["status"],
        email: json["email"],
        image: json["image"],
        verCode: json["ver_code"],
        verCodeSendAt: json["ver_code_send_at"],
        emailVerifiedAt: json["email_verified_at"],
        emailVerified: json["email_verified"],
        smsVerified: json["sms_verified"],
        kycVerified: json["kyc_verified"],
        twoFactorVerified: json["two_factor_verified"],
        twoFactorStatus: json["two_factor_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "mobile_code": mobileCode,
        "mobile": mobile,
        "full_mobile": fullMobile,
        "address": address.toJson(),
        "status": status,
        "email": email,
        "image": image,
        "ver_code": verCode,
        "ver_code_send_at": verCodeSendAt,
        "email_verified_at": emailVerifiedAt,
        "email_verified": emailVerified,
        "sms_verified": smsVerified,
        "kyc_verified": kycVerified,
        "two_factor_verified": twoFactorVerified,
        "two_factor_status": twoFactorStatus,
      };
}

class Address {
  final String country;
  final String city;
  final String state;
  final String zipCode;
  final String address;
  final String companyName;

  Address({
    required this.country,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.address,
    required this.companyName,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        country: json["country"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zip_code"],
        address: json["address"],
        companyName: json["company_name"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "city": city,
        "state": state,
        "zip_code": zipCode,
        "address": address,
        "company_name": companyName,
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