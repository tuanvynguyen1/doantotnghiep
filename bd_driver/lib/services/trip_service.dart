import 'dart:convert';

import 'package:http/http.dart' as http;


import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TripService {
  static FlutterSecureStorage storage = new FlutterSecureStorage();
  static String baseURL = 'http://20.24.98.145:8000';
  static Future<bool?> sendTripData(id, lat,lng) async {
    String? token = await storage.read(key: 'Token');

    var client = http.Client();
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token}'
    };
    var response = await client.post(Uri.parse("$baseURL/api/driver/updateTrip"),
        headers: headers,
        body: json.encode({
          'id': id,
          'lat' : lat,
          'lng': lng
        })
    );
  }
  static Future<void> setStatus(id, status) async{
    String? token = await storage.read(key: 'Token');

    var client = http.Client();
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token}'
    };
    var response = await client.post(Uri.parse("$baseURL/api/driver/updateStatus"),
        headers: headers,
        body: json.encode({
          'id': id,
          'status': status
        })
    );
    print(response.body);
  }
  static Future<void> finishTrip(id) async{
    String? token = await storage.read(key: 'Token');

    var client = http.Client();
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token}'
    };
    var response = await client.post(Uri.parse("$baseURL/api/driver/finishtrip"),
        headers: headers,
        body: json.encode({
          'id': id
        })
    );
  }
}