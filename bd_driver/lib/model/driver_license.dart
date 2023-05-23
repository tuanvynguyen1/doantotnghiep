import 'dart:convert';

//DriverLicense driverLicenseFromJson(String str) => DriverLicense.fromJson(json.decode(str));
List<DriverLicense> driverLicenseFromJson(String str) => List<DriverLicense>.from(json.decode(str).map((x) => DriverLicense.fromJson(x)));
String driverLicenseToJson(DriverLicense data) => json.encode(data.toJson());

class DriverLicense {
  int id;

  String rank;
  String front;
  String back;
  int? status;
  String? reason;
  DateTime? createdAt;
  DateTime? updatedAt;

  DriverLicense({
    required this.id,
    required this.rank,
    required this.front,
    required this.back,
    this.status,
    this.reason,
    this.createdAt,
    this.updatedAt,
  });

  factory DriverLicense.fromJson(Map<String, dynamic> json) => DriverLicense(
    id: json["id"],
    rank: json["rank"],
    front: json["front"],
    back: json["back"],
    status: json["status"],
    reason: json["reason"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rank": rank,
    "front": front,
    "back": back,
    "status": status,
    "reason": reason,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
