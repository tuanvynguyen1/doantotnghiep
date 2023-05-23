// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User(
      {this.id,
      this.userId,
      required this.name,
      required this.email,
      this.avatar,
      required this.phone,
      required this.address,
      required this.citizenIdentityCard,
      this.citizenIdentityCardImgFront,
      this.citizenIdentityCardImgBack,
      required this.score,
      required this.gender,
      required this.dob,
      required this.isActive,
     this.isBike,
   this.isCar});

  int? id;
  int? userId;
  String name;
  String email;
  String? avatar;
  String phone;
  String address;
  String citizenIdentityCard;
  dynamic citizenIdentityCardImgFront;
  dynamic citizenIdentityCardImgBack;
  int score;
  String dob;
  String gender;
  bool isActive;
  bool? isBike;
  bool? isCar;
  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      userId: json["userID"],
      name: json["name"],
      email: json["email"],
      avatar: json["avatar"],
      phone: json["phone"],
      address: json["address"],
      citizenIdentityCard: json["citizen_identity_card"],
      citizenIdentityCardImgFront: json["citizen_identity_card_img_front"],
      citizenIdentityCardImgBack: json["citizen_identity_card_img_back"],
      score: json["score"],
      gender: json["gender"] == 1 ? "Nam": "Nữ",
      dob: json["dob"],
      isActive: json["is_active"]== 1 ? true : false,
      isBike: json['isBike'],
      isCar: json['isCar']
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "name": name,
        "email": email,
        "avatar": avatar,
        "phone": phone,
        "address": address,
        "citizen_identity_card": citizenIdentityCard,
        "citizen_identity_card_img_front": citizenIdentityCardImgFront,
        "citizen_identity_card_img_back": citizenIdentityCardImgBack,
        "score": score,
        "gender": gender,
        "dob": dob,
        "is_active": isActive,
        "isBike": isBike,
  "isCar": isCar
      };
}
