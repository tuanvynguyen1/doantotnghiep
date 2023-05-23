// To parse this JSON data, do
//
//     final booking = bookingFromJson(jsonString);

import 'dart:convert';

//Booking bookingFromJson(String str) => Booking.fromJson(json.decode(str));
List<Booking> addressBookFromJson(String str) => List<Booking>.from(json.decode(str).map((x) => Booking.fromJson(x)));

String bookingToJson(Booking data) => json.encode(data.toJson());

class Booking {
  int id;
  int driverId;
  int userInfoId;
  String addressfrom;
  String latitudefrom;
  String longtitudefrom;
  double totaldistance;
  dynamic driverincome;
  dynamic companyincome;
  dynamic bookingtime;
  dynamic driveracepttime;
  int cartype;
  dynamic rate;
  dynamic comment;
  dynamic starttime;
  dynamic endtime;
  int paymentstatus;
  String addressdes;
  String latitudedes;
  String longtitudedes;
  DateTime createdAt;
  DateTime updatedAt;

  Booking({
    required this.id,
    required this.driverId,
    required this.userInfoId,
    required this.addressfrom,
    required this.latitudefrom,
    required this.longtitudefrom,
    required this.totaldistance,
    this.driverincome,
    this.companyincome,
    this.bookingtime,
    this.driveracepttime,
    required this.cartype,
    this.rate,
    this.comment,
    this.starttime,
    this.endtime,
    required this.paymentstatus,
    required this.addressdes,
    required this.latitudedes,
    required this.longtitudedes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["id"],
    driverId: json["driverID"],
    userInfoId: json["user_infoID"],
    addressfrom: json["addressfrom"],
    latitudefrom: json["latitudefrom"],
    longtitudefrom: json["longtitudefrom"],
    totaldistance: json["totaldistance"]?.toDouble(),
    driverincome: json["driverincome"],
    companyincome: json["companyincome"],
    bookingtime: json["bookingtime"],
    driveracepttime: json["driveracepttime"],
    cartype: json["cartype"],
    rate: json["rate"],
    comment: json["comment"],
    starttime: json["starttime"],
    endtime: json["endtime"],
    paymentstatus: json["paymentstatus"],
    addressdes: json["addressdes"],
    latitudedes: json["latitudedes"],
    longtitudedes: json["longtitudedes"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "driverID": driverId,
    "user_infoID": userInfoId,
    "addressfrom": addressfrom,
    "latitudefrom": latitudefrom,
    "longtitudefrom": longtitudefrom,
    "totaldistance": totaldistance,
    "driverincome": driverincome,
    "companyincome": companyincome,
    "bookingtime": bookingtime,
    "driveracepttime": driveracepttime,
    "cartype": cartype,
    "rate": rate,
    "comment": comment,
    "starttime": starttime,
    "endtime": endtime,
    "paymentstatus": paymentstatus,
    "addressdes": addressdes,
    "latitudedes": latitudedes,
    "longtitudedes": longtitudedes,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
