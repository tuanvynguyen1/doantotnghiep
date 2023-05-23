import 'dart:convert';

BookPending bookPendingFromJson(String str) => BookPending.fromJson(json.decode(str));

String bookPendingToJson(BookPending data) => json.encode(data.toJson());

class BookPending {
  int id;
  int bookID;
  String add1;
  String lat1;
  String lng1;
  double distance;
  String add2;
  String lat2;
  String lng2;
  String name;
  String sdt;
  bool? isRejoin = false;
  int status;
  BookPending({
    required this.id,
    required this.bookID,
    required this.add1,
    required this.lat1,
    required this.lng1,
    required this.distance,
    required this.add2,
    required this.lat2,
    required this.lng2,
    required this.name,
    required this.sdt,
    required this.status
  });

  factory BookPending.fromJson(Map<String, dynamic> json) => BookPending(
    id: json["id"],
    bookID: json["bookID"],
    add1: json["add1"],
    lat1: json["lat1"],
    lng1: json["lng1"],
    distance: json["distance"]?.toDouble(),
    add2: json["add2"],
    lat2: json["lat2"],
    lng2: json["lng2"],
    name: json["name"],
    sdt: json["sdt"],
    status: json["status"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bookID": bookID,
    "add1": add1,
    "lat1": lat1,
    "lng1": lng1,
    "distance": distance,
    "add2": add2,
    "lat2": lat2,
    "lng2": lng2,
    "name": name,
    "sdt": sdt,
    "status": status
  };
}