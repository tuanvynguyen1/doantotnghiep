


import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../model/banner_obj.dart';

class BannerServices {
  static FlutterSecureStorage storage = new FlutterSecureStorage();
  static String baseURL = 'http://20.24.98.145:8000';

  static Future<List<BannerObj>> getList() async{
    String? token = await storage.read(key: 'Token');

    var client = http.Client();
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token}'
    };
    var response = await client.get(
        Uri.parse("$baseURL/api/user/bannerList"),
        headers: headers
    );
    List<BannerObj> ls = [];
    if(response.statusCode == 200){
      var result = response.body;
      Map<String, dynamic> json = jsonDecode(result);
      if(json['status'] == 'Success'){
        ls = bannerFromJson(jsonEncode(json['data']));
        return ls;
      }
      else{
        print('lỗi');
        return ls;
      }
    }
    else{
      print('Tai du lieu that bai');
      return ls;
      throw Exception("Loi lay du lieu. Chi tiết: ${response.statusCode}");
    }
  }
}