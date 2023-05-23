

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../model/booking.dart';
class ReviewServices {
  static FlutterSecureStorage storage = new FlutterSecureStorage();
  static String baseURL = 'http://20.24.98.145:8000';


  static Future<bool> addReview(id,star,comment) async{
    String? token = await storage.read(key: 'Token');

    var client = http.Client();
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token}'
    };
    var response = await client.post(
        Uri.parse("$baseURL/api/user/addReview"),
        headers: headers,
        body: json.encode({
        'id': id,
        'star': star,
        'review' : comment
    }),
    );
    if(response.statusCode == 200){
      print('Đăng review thành công ');
      var result = response.body;
      return true;
    }
    else{
      print('Tai du lieu that bai');
      return false;
    }
  }
// static Future<bool> addAddress(String name, String address, String lat, String long) async{
//   String? token = await storage.read(key: 'Token');
//
//   var client = http.Client();
//   Map<String, String> headers = {
//     "Content-type": "application/json",
//     "Authorization": 'Bearer ${token}'
//   };
//   var response = await client.post(
//     Uri.parse("$baseURL/api/user/addressbook"),
//     headers: headers,
//     body: json.encode({
//       'name': name,
//       'address': address,
//       'lat' : lat,
//       'long': long
//     }),
//   );
//   if(response.statusCode == 200){
//     print('Tai du lieu thanh cong');
//     return true;
//   }
//   else{
//     print('Tai du lieu that bai');
//     AlertDialog(
//       title: Text('Lỗi cập nhật'),
//     );
//     return false;
//   }
// }

}