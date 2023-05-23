import 'dart:convert';
import 'dart:io';

import 'package:bd/utils/device_info.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:bd/utils/api_services.dart';
import 'package:http_parser/http_parser.dart';

import '../model/user.dart';
class AuthenticatorServices {
  static FlutterSecureStorage storage = new FlutterSecureStorage();
  static String baseURL = 'http://20.24.98.145:8000';
  static Future<User?> loginServices(username, password) async {
    var client = http.Client();
    var device = await DeviceInfo.getDeviceName();
    Map<String, String> headers = {"Content-type": "application/json"};
    var response = await client.post(
      Uri.parse("$baseURL/api/user/login"),
      headers: headers,
      body: json.encode({
        'email': username,
        'password': password,
        'device_name' : device.toString()
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);

      await storage.write(key: 'Token', value: result['token']);
      User u = userFromJson(json.encode(result['data']));
      return u;
    }
    return null;
  }

  static void registerService(name, email, phone, address, password) async {
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };
    var request =
        http.MultipartRequest('POST', Uri.parse("$baseURL/api/user/register"))
    ..headers.addAll(headers)
    ..fields['name'] = name
    ..fields['email'] = email
    ..fields['phone'] = phone
    ..fields['address'] = address
    ..fields['password'] = password;

    final response = await request.send();
    final respStr = await response.stream.bytesToString();
  }
  static Future<User> getInfomation(token) async{
    var client = http.Client();
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token}'
    };
    var response = await client.post(
      Uri.parse("$baseURL/api/user/me"),
      headers: headers
    );
    User u = User(name: 'Default', email: 'Default', phone: 'Default', address: 'Default');
    if (response.statusCode == 200) {
      u = userFromJson(response.body);
    }
    return u;
  }
  static Future<void> logOut() async{
    var client = http.Client();
    String? token = await storage.read(key: 'Token');

    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token!}'
    };
    var response = await client.post(
        Uri.parse("$baseURL/api/driver/logout"),
        headers: headers
    );
    storage.delete(key: 'Token');
    if(response.statusCode == 200){

    }
    else {
    }
  }
}
