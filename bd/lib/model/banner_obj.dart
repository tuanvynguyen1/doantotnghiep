// To parse this JSON data, do
//
//     final banner = bannerFromJson(jsonString);

import 'dart:convert';

//Banner bannerFromJson(String str) => Banner.fromJson(json.decode(str));
List<BannerObj> bannerFromJson(String str) => List<BannerObj>.from(json.decode(str).map((x) => BannerObj.fromJson(x)));

String bannerToJson(BannerObj data) => json.encode(data.toJson());

class BannerObj {
  int id;
  String name;
  String image;
  DateTime expire;
  int isDelete;
  DateTime createdAt;
  DateTime updatedAt;

  BannerObj({
    required this.id,
    required this.name,
    required this.image,
    required this.expire,
    required this.isDelete,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BannerObj.fromJson(Map<String, dynamic> json) => BannerObj(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    expire: DateTime.parse(json["expire"]),
    isDelete: json["isDelete"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "expire": "${expire.year.toString().padLeft(4, '0')}-${expire.month.toString().padLeft(2, '0')}-${expire.day.toString().padLeft(2, '0')}",
    "isDelete": isDelete,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
