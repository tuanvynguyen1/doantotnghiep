

import 'dart:convert';

import 'package:bd/model/address_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
class AddressBookServices {
  static FlutterSecureStorage storage = new FlutterSecureStorage();
  static String baseURL = 'http://20.24.98.145:8000';


  static Future<List<AddressBook>> getList() async{
    String? token = await storage.read(key: 'Token');

    var client = http.Client();
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token}'
    };
    var response = await client.get(
        Uri.parse("$baseURL/api/user/addressbook"),
        headers: headers
    );
    List<AddressBook> ls = [];
    if(response.statusCode == 200){
      print('Tai du lieu thanh cong');
      var result = response.body;
      ls = addressBookFromJson(result);
      return ls;
    }
    else{
      print('Tai du lieu that bai');
      throw Exception("Loi lay du lieu. Chi tiết: ${response.statusCode}");
    }
  }
  static Future<bool> addAddress(String name, String address, String lat, String long) async{
    String? token = await storage.read(key: 'Token');

    var client = http.Client();
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token}'
    };
    var response = await client.post(
        Uri.parse("$baseURL/api/user/addressbook"),
        headers: headers,
        body: json.encode({
          'name': name,
          'address': address,
          'lat' : lat,
          'long': long
      }),
    );
    if(response.statusCode == 200){
      print('Tai du lieu thanh cong');
      return true;
    }
    else{
      print('Tai du lieu that bai');
      AlertDialog(
        title: Text('Lỗi cập nhật'),
      );
      return false;
    }
  }

}