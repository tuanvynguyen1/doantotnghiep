import 'dart:ui';

import 'package:bd/view/home_page.dart';
import 'package:bd/view/register_page.dart';
import 'package:flutter/material.dart';
import 'package:bd/services/authenticator_services.dart';

import 'loading_dialog.dart';


class LoginPageWidget extends StatelessWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var userNameControler = TextEditingController();
  var passWordControler = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  String src = 'assets/images/banner.jpg';
  Color clrsrc = Color.fromRGBO(5, 153, 71, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: clrsrc,
        title: Text("Đăng nhập hệ thống"),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(src),
              //input userName
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: userNameControler,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      label: Text(
                        "Tên đăng nhập",
                        style: TextStyle(color: clrsrc, fontSize: 14),
                      ),
                      hintText: "Vui lòng nhập tên đăng nhập",
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      prefixIcon: Icon(Icons.person)),
                  validator: (str) {
                    if (str == null || str.isEmpty)
                      return "Tên đăng nhập không được rỗng";
                    return null;
                  },
                ),
              ),
              //input passWord
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  obscureText: true,
                  controller: passWordControler,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      label: Text(
                        "Mật khẩu",
                        style: TextStyle(color: clrsrc, fontSize: 14),
                      ),
                      hintText: "Vui lòng nhập mật khẩu",
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      prefixIcon: Icon(Icons.key)),
                  validator: (password) {
                    if (password == null || password.isEmpty)
                      return "Mật khẩu rỗng";
                    return null;
                  },
                ),
              ),
              // nút đăng nhập
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: SizedBox(
                  width: double.infinity, //  match_parent
                  height: 50, // match_parent
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStatePropertyAll<Color>(clrsrc),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                  side: BorderSide(color: clrsrc)))),
                      onPressed: ()  async {
                        if (_formKey.currentState!.validate()) {
                          var username = userNameControler.text;
                          var password = passWordControler.text;
                          showDialog(
                              context: context,
                              builder: (c){
                                return LoadingDialogWidget();
                              }
                          );
                          var user = await AuthenticatorServices.loginServices(username, password);
                          Navigator.pop(context);
                          if(user != null){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage(user: user)));
                          }
                        } else {
                          print("Dữ liệu không chính xác");
                        }
                      },
                      child: Text(
                        'Đăng nhập',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      )),
                ),
              ),
              //nút quay lại
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // cách vào nút quay lại 1 khoảng trống
                  SizedBox(
                    width: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                      child: Text(
                        "Đăng ký",
                        style: TextStyle(color: clrsrc),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
