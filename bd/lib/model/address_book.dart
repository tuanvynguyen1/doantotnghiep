// To parse this JSON data, do
//
//     final addressBook = addressBookFromJson(jsonString);

import 'dart:convert';

// AddressBook addressBookFromJson(String str) => AddressBook.fromJson(json.decode(str));
List<AddressBook> addressBookFromJson(String str) => List<AddressBook>.from(json.decode(str).map((x) => AddressBook.fromJson(x)));
String addressBookToJson(AddressBook data) => json.encode(data.toJson());

class AddressBook {
  int id;
  String name;
  String address;
  String lat;
  String long;

  AddressBook({
    required this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.long,
  });

  factory AddressBook.fromJson(Map<String, dynamic> json) => AddressBook(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    lat: json["lat"],
    long: json["long"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "lat": lat,
    "long": long,
  };
}
