import 'dart:convert';

import 'package:bd_driver/model/book_pending.dart';
import 'package:bd_driver/model/driver_license.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../model/booking.dart';

class BookingServices {
  static FlutterSecureStorage storage = new FlutterSecureStorage();
  static String baseURL = 'http://20.24.98.145:8000';

  static Future<List<Booking>> getList() async {
    String? token = await storage.read(key: 'Token');

    var client = http.Client();
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token}'
    };
    var response = await client.get(Uri.parse("$baseURL/api/driver/bookinglist"),
        headers: headers);
    List<Booking> ls = [];
    if (response.statusCode == 200) {
      print('Tai du lieu thanh cong');
      var result = response.body;
      ls = addressBookFromJson(result);
      return ls;
    } else {
      print('Tai du lieu that bai');
      throw Exception("Loi lay du lieu. Chi tiết: ${response.statusCode}");
    }
  }

  static Future<void> rejectRequest(id) async{
    String? token = await storage.read(key: 'Token');

    var client = http.Client();
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token}'
    };

    var response = await client.post(
      Uri.parse("$baseURL/api/driver/rejectRequest"),
      headers: headers,
      body: json.encode({
        'id': id
      }),
    );
  }
  static Future<void> acceptRequest(id) async{
    String? token = await storage.read(key: 'Token');

    var client = http.Client();
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token}'
    };

    var response = await client.post(
      Uri.parse("$baseURL/api/driver/acceptRequest"),
      headers: headers,
      body: json.encode({
        'id': id
      }),
    );
  }
  static Future<BookPending?> checkRequest() async {
    String? token = await storage.read(key: 'Token');

    var client = http.Client();
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token}'
    };

    var response = await client.post(
      Uri.parse("$baseURL/api/driver/pendingBook"),
      headers: headers,
    );
    BookPending? d = null;
    if (response.statusCode == 200) {
      var result = response.body;
      Map<String, dynamic> res = jsonDecode(result);
      if (res['status'] == "Success") {
        d = bookPendingFromJson(jsonEncode(res['data']));
        print(d.status);
        return d;
      } else if(res['status'] == "Rejoin"){
        d = bookPendingFromJson(jsonEncode(res['data']));
        d.isRejoin = true;
        return d;
      }
    } else {
      print('Lỗi gì r');
    }
  }
}
