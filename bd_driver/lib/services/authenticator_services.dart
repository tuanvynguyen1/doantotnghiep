import 'dart:convert';
import 'dart:io';

import 'package:bd_driver/utils/device_info.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:bd_driver/utils/api_services.dart';
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
      Uri.parse("$baseURL/api/driver/login"),
      headers: headers,
      body: json.encode({
        'email': username,
        'password': password,
        'device_name': device.toString()
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

  static String _convertDOB(dob) {
    final splitted = dob.split('/');
    return splitted[2] + '-' + splitted[1] + '-' + splitted[0];
  }

  static Future<void> updateService(name, email, phone, address, idCard,
      password, File frontCard, File backCard, File avatar) async {
    String? token = await storage.read(key: 'Token');
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token}'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse("$baseURL/api/driver/updateDriver"))
      ..headers.addAll(headers)
      ..fields['name'] = name
      ..fields['email'] = email
      ..fields['phone'] = phone
      ..fields['address'] = address

      ..fields['citizen_identity_card'] = idCard
      ..fields['password'] = password
      ..files
          .add(await http.MultipartFile.fromPath('frontCard', frontCard.path))
      ..files.add(await http.MultipartFile.fromPath('backCard', backCard.path))
      ..files.add(await http.MultipartFile.fromPath('avatar', avatar.path));
  }

  static void registerService(name, email, phone, address, idCard, password,
      gender, dob, File frontCard, File backCard) async {

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse("$baseURL/api/driver/register"))
      ..headers.addAll(headers)
      ..fields['name'] = name
      ..fields['email'] = email
      ..fields['phone'] = phone
      ..fields['address'] = address
      ..fields['citizen_identity_card'] = idCard
      ..fields['password'] = password
      ..fields['gender'] = gender == true ? '1' : '0'
      ..fields['dob'] = _convertDOB(dob)
      ..files
          .add(await http.MultipartFile.fromPath('frontCard', frontCard.path))
      ..files.add(await http.MultipartFile.fromPath('backCard', backCard.path));

    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);
    Map<String, dynamic>  json = jsonDecode(respStr);

    if (json['status'] == "Success") {
      print(json['msg']);
    } else{
      print('lỗi');
    }
  }

  static Future<User> getInfomation(token) async {
    var client = http.Client();
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token}'
    };
    var response =
        await client.get(Uri.parse("$baseURL/api/driver/me"), headers: headers);
    User u = User(
        id: 0,
        userId: 0,
        name: 'Default',
        email: 'Default',
        phone: 'Default',
        address: 'Default',
        citizenIdentityCard: 'Default',
        score: 0,
        gender: "Nam",
        dob: '1/1/1990',
        isActive: true,
        isBike: false,
        isCar: false);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      u = userFromJson(json.encode(result['data']));
    }
    return u;
  }

  static Future<void> logOut() async {
    var client = http.Client();
    String? token = await storage.read(key: 'Token');

    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token!}'
    };
    var response = await client.post(Uri.parse("$baseURL/api/driver/logout"),
        headers: headers);
    storage.delete(key: 'Token');
    if (response.statusCode == 200) {
    } else {}
  }

  static Future<void> updateLocation(lat, long) async {
    var client = http.Client();
    String? token = await storage.read(key: 'Token');

    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token!}'
    };
    var response = await client.post(
      Uri.parse("$baseURL/api/driver/upLoc"),
      headers: headers,
      body: json.encode({
        'lat': lat,
        'long': long,
      }),
    );
  }
}
