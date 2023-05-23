

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../model/booking.dart';
class BookingServices {
  static FlutterSecureStorage storage = new FlutterSecureStorage();
  static String baseURL = 'http://20.24.98.145:8000';


  static Future<List<Booking>> getList() async{
    String? token = await storage.read(key: 'Token');

    var client = http.Client();
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token}'
    };
    var response = await client.get(
        Uri.parse("$baseURL/api/user/bookinglist"),
        headers: headers
    );
    List<Booking> ls = [];
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
  static Future<int?> sendBookingRequest(lat1, long1, lat2, long2, carType) async{
    String? token = await storage.read(key: 'Token');

    var client = http.Client();
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token}'
    };
    var response = await client.post(
        Uri.parse("$baseURL/api/user/book"),
        headers: headers,
      body: json.encode({
        'latitudefrom': lat1.toString(),
        'longtitudefrom': long1.toString(),
        'latitudedes' : lat2.toString(),
        'longtitudedes' : long2.toString(),
        'cartype' : carType
      }),
    );
    if(response.statusCode == 200){
      print('Gọi xe thành công');
      var result = response.body;
      Map<String, dynamic> res = jsonDecode(result);
      return res['bookingID'];
    }
    else{
      print('Gọi xe thất bại');
      return null;


    }

  }
  static Future<int?> getPrice(lat1,long1,lat2,long2,type) async{
    String? token = await storage.read(key: 'Token');

    var client = http.Client();
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token}'
    };
    var response = await client.post(
      Uri.parse("$baseURL/api/user/getprice"),
      headers: headers,
      body: json.encode({
        'lat1': lat1.toString(),
        'long1': long1.toString(),
        'lat2' : lat2.toString(),
        'long2' : long2.toString(),
        'type' : type
      }),
    );
    if(response.statusCode == 200){

      var result = response.body;
      Map<String, dynamic> price = jsonDecode(result);
      return price['data'];

    }
    else{
      print('Gọi xe thất bại');
      throw Exception("Loi lay du lieu. Chi tiết: ${response.body}");


    }
  }
  static Future<bool> isAccept(bookingID) async{
    String? token = await storage.read(key: 'Token');

    var client = http.Client();
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token}'
    };

    var response = await client.post(
      Uri.parse("$baseURL/api/user/isAccept"),
      headers: headers,
      body: json.encode({
        'id': bookingID
      }),
    );
    if(response.statusCode == 200){

      var result = response.body;
      Map<String, dynamic> res = jsonDecode(result);
      if(res['status'] == 'Accepted'){
        return true;
      }
      else
        return false;

    }
    else{
      print('Lỗi gì r');
      return false;


    }
  }
}