import 'package:bd/services/authenticator_services.dart';
import 'package:bd/view/home_page.dart';
import 'package:bd/view/loading_screen.dart';
import 'package:bd/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'model/user.dart';

void main() async{
  runApp(const LoadingScreenWidget());
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  String? value = await storage.read(key: 'Token');
  // PusherUtil.connect(value);
  if(value != null){
    User u = await AuthenticatorServices.getInfomation(value);
    runApp(HomePageWidget(user: u));
    // runApp(UserPageWidget(user: u));

  }
  else{
    runApp(const LoginPageWidget());
  }
}



