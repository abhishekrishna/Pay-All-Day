// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  UserData({
    this.id,
    this.referredBy,
    this.providerId,
    this.userType,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.verificationCode,
    this.newEmailVerificiationCode,
    this.deviceToken,
    this.avatar,
    this.avatarOriginal,
    this.address,
    this.country,
    this.city,
    this.postalCode,
    this.phone,
    this.balance,
    this.banned,
    this.referralCode,
    this.customerPackageId,
    this.remainingUploads,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String referredBy;
  dynamic providerId;
  String userType;
  String name;
  String email;
  DateTime emailVerifiedAt;
  dynamic verificationCode;
  dynamic newEmailVerificiationCode;
  dynamic deviceToken;
  String avatar;
  dynamic avatarOriginal;
  String address;
  String country;
  String city;
  String postalCode;
  dynamic phone;
  int balance;
  int banned;
  String referralCode;
  dynamic customerPackageId;
  dynamic remainingUploads;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        referredBy: json["referred_by"],
        providerId: json["provider_id"],
        userType: json["user_type"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        verificationCode: json["verification_code"],
        newEmailVerificiationCode: json["new_email_verificiation_code"],
        deviceToken: json["device_token"],
        avatar: json["avatar"],
        avatarOriginal: json["avatar_original"],
        address: json["address"],
        country: json["country"],
        city: json["city"],
        postalCode: json["postal_code"],
        phone: json["phone"],
        balance: json["balance"],
        banned: json["banned"],
        referralCode: json["referral_code"],
        customerPackageId: json["customer_package_id"],
        remainingUploads: json["remaining_uploads"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "referred_by": referredBy,
        "provider_id": providerId,
        "user_type": userType,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "verification_code": verificationCode,
        "new_email_verificiation_code": newEmailVerificiationCode,
        "device_token": deviceToken,
        "avatar": avatar,
        "avatar_original": avatarOriginal,
        "address": address,
        "country": country,
        "city": city,
        "postal_code": postalCode,
        "phone": phone,
        "balance": balance,
        "banned": banned,
        "referral_code": referralCode,
        "customer_package_id": customerPackageId,
        "remaining_uploads": remainingUploads,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
