import 'dart:convert';

import 'package:bd_driver/model/driver_license.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class DriverLicenseService {
  static FlutterSecureStorage storage = new FlutterSecureStorage();
  static String baseURL = 'http://20.24.98.145:8000';


  static Future<bool> uploadDriverLicense(rank, back, front) async{
    String? token = await storage.read(key: 'Token');
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      "Authorization": 'Bearer ${token}'
    };
    var request =
    http.MultipartRequest('POST', Uri.parse("$baseURL/api/driver/uploadLicense"))
      ..headers.addAll(headers)
      ..fields['rank'] = rank
      ..files.add(await http.MultipartFile.fromPath('front', front.path))
      ..files.add(await http.MultipartFile.fromPath('back', back.path));

    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    if(jsonDecode(respStr)['status'] == "200"){
      return true;
    }
    return false;
  }
  static Future<List<DriverLicense>> getListLicense() async{
    String? token = await storage.read(key: 'Token');

    var client = http.Client();
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token}'
    };
    var response = await client.post(
        Uri.parse("$baseURL/api/driver/getListLicense"),
        headers: headers
    );
    List<DriverLicense> ls = [];
    if(response.statusCode == 200){
      print('Tai du lieu thanh cong');
      var result = response.body;
      Map<String, dynamic> data = jsonDecode(result);
      ls = driverLicenseFromJson(jsonEncode(data['data']));

      return ls;
    }
    else{
      print('Tai du lieu that bai');
      throw Exception("Loi lay du lieu. Chi tiết: ${response.statusCode}");
    }
  }

}