import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../services/authenticator_services.dart';

class RegisterPageWidget extends StatelessWidget {
  const RegisterPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int curStep = 0;
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];
  Color clrsrc = Color.fromRGBO(5, 153, 71, 1);
  var passwordController = TextEditingController();
  var repasswordController = TextEditingController();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var genderController = TextEditingController();
  var birthdayController = TextEditingController();
  var idcardController = TextEditingController();
  File? frontCard, backCard;
  Future<File> _getFromCamera() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    return File(pickedFile!.path);
  }

  @override
  Widget build(BuildContext context) {



    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: clrsrc,
        title: Text("Đăng Ký"),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: SafeArea(
        child: Stack(

            children: [
          Stepper(
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Row(
                children: <Widget>[
                  Container(),
                ],
              );
            },
            type: StepperType.horizontal,
            steps: getSteps(),
            currentStep: curStep,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                curStep > 0
                    ? TextButton(
                        onPressed: () {
                          setState(() {
                            curStep--;
                          });
                        },
                        child: Text("Trở lại"))
                    : TextButton(onPressed: null, child: Text("Trở lại")),
                curStep < getSteps().length - 1
                    ? TextButton(
                        onPressed: () {
                          setState(() {
                            if (_formKeys[curStep].currentState!.validate()) {
                              curStep++;
                            }
                          });
                        },
                        child: Text("Tiếp tục"))
                    : TextButton(
                        onPressed: () {
                          var email = emailController.text;
                          var name = nameController.text;
                          var password = passwordController.text;
                          var phone = phoneController.text;
                          var address = addressController.text;
                          var idCard = idcardController.text;
                          var gender = genderController.text;
                          var dob = birthdayController.text;
                          AuthenticatorServices.registerService(
                              name,
                              email,
                              phone,
                              address,
                              idCard,
                              password,
                              gender == 'Nam',
                              dob,
                              frontCard!,
                              backCard!);
                        },
                        child: Text('Submit'))
              ],
            ),
          )
        ]),
      ),
    );
  }
  var listGender = ['Nam', 'Nữ'];
  List<Step> getSteps() => [

        Step(

            isActive: curStep >= 0,
            title: Text(
              'Tài khoản',
              style: TextStyle(fontSize: 13),
            ),
            content: Form(
              key: _formKeys[0],
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            label: Text(
                              "Nhập địa chỉ Email",
                              style: TextStyle(color: clrsrc, fontSize: 14),
                            ),
                            hintText:
                                "Vui lòng nhập địa chỉ email đúng định dạng",
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            prefixIcon: Icon(Icons.alternate_email)),
                        validator: (str) {
                          if (str == null ||
                              str.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+(\.[a-zA-Z]+)+")
                                  .hasMatch(str)) return "Email không hợp lệ!";
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            label: Text(
                              "Mật khẩu",
                              style: TextStyle(color: clrsrc, fontSize: 14),
                            ),
                            hintText:
                                'Nhập mật khẩu nhiều hơn 8 kí tự, chứa ít nhất 1: Kí tự, Số, kí tự đặc biệt',
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            prefixIcon: Icon(Icons.password)),
                        validator: (str) {
                          if (str == null ||
                              str.isEmpty ||
                              !RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$")
                                  .hasMatch(str))
                            return "Nhập mật khẩu nhiều hơn 8 kí tự, chứa ít nhất 1: Kí tự, Số, kí tự đặc biệt";
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        obscureText: true,
                        controller: repasswordController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            label: Text(
                              "Nhập lại mật khẩu",
                              style: TextStyle(color: clrsrc, fontSize: 14),
                            ),
                            hintText: "Vui lòng nhập lại mật khẩu",
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            prefixIcon: Icon(Icons.password)),
                        validator: (str) {
                          if (str == null ||
                              str.isEmpty ||
                              str != passwordController.text)
                            return "Phải nhập chính xác mật khẩu!";
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )),
        Step(
            isActive: curStep >= 1,
            title: Text('Thông tin', style: TextStyle(fontSize: 13)),
            content: Form(
              key: _formKeys[1],
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            label: Text(
                              "Họ Tên",
                              style: TextStyle(color: clrsrc, fontSize: 14),
                            ),
                            hintText: "Vui lòng nhập đầy đủ họ tên",
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            prefixIcon: Icon(Icons.drive_file_rename_outline)),
                        validator: (str) {
                          if (str == null || str.isEmpty)
                            return "Họ tên không được bỏ trống";
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            label: Text(
                              "Số điện thoại",
                              style: TextStyle(color: clrsrc, fontSize: 14),
                            ),
                            hintText: "Vui lòng nhập số điện thoại",
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            prefixIcon: Icon(Icons.phone)),
                        validator: (str) {
                          if (str == null || str.isEmpty)
                            return "Số điện thoại không hợp lệ";
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: DropdownButtonFormField(
                        items: listGender.map((String val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(
                              val,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          genderController.text = value!;
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          label: const Text(
                            "Giới tính",
                            style:
                            TextStyle(color: Color.fromRGBO(5, 153, 71, 1), fontSize: 14),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          prefixIcon: const Icon(
                            Icons.male,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: birthdayController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            label: Text(
                              "Ngày sinh",
                              style: TextStyle(color: clrsrc, fontSize: 14),
                            ),
                            hintText: "20/08/1990",
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            prefixIcon: Icon(Icons.date_range)),
                        validator: (str) {
                          if (str == null || str.isEmpty)
                            return "Ngày sinh không được bỏ trống";
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            label: Text(
                              "Địa chỉ",
                              style: TextStyle(color: clrsrc, fontSize: 14),
                            ),
                            hintText: "Vui lòng nhập địa chỉ trên CCCD/CMND",
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            prefixIcon: Icon(Icons.streetview)),
                        validator: (str) {
                          if (str == null || str.isEmpty)
                            return "Địa chỉ không được bỏ trống";
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: idcardController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            label: Text(
                              "CMND/CCCD",
                              style: TextStyle(color: clrsrc, fontSize: 14),
                            ),
                            hintText: "Vui lòng nhập số trên CCCD/CMND",
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            prefixIcon: Icon(Icons.add_card_outlined)),
                        validator: (str) {

                          if (str == null ||
                              str.isEmpty ||
                              (str.length != 9 && str.length != 12) ||
                              !RegExp(r'^[0-9]{8,}').hasMatch(str))
                            return "CCCD/CMND không hợp lệ";
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )),
        Step(
            isActive: curStep >= 2,
            title: Text('CMND/CCCD', style: TextStyle(fontSize: 13)),
            content: Form(
                key: _formKeys[2],
                child: Container(

                  child: Column( children: [
                    Text("Mặt trước CMND/CCCD"),
                    frontCard != null
                        ? Container(child: Image.file(frontCard!, height: MediaQuery.of(context).size.height * .3))
                        : Container(
                            child: Icon(Icons.camera_enhance_rounded,
                                color: Colors.grey,
                                size: MediaQuery.of(context).size.width * .3)),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 10, right: 10),
                      child: SizedBox(
                        width: double.infinity, //  match_parent
                        height: 50, // match_parent
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.blueAccent),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                        side: BorderSide(
                                            color: Colors.blueAccent)))),
                            onPressed: () async {
                              var x = await _getFromCamera();
                              frontCard = x;
                              setState(() {});
                            },
                            child: Text(
                              'Upload Ảnh',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            )),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text("Mặt sau CMND/CCCD")),
                    backCard != null
                        ? Container(child: Image.file(backCard!, height: MediaQuery.of(context).size.height * .3),)
                        : Container(
                            child: Icon(Icons.camera_enhance_rounded,
                                color: Colors.grey,
                                size: MediaQuery.of(context).size.width * .3)),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 10, right: 10),
                      child: SizedBox(
                        width: double.infinity, //  match_parent
                        height: 50, // match_parent
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.blueAccent),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                        side: BorderSide(
                                            color: Colors.blueAccent)))),
                            onPressed: () async {
                              var x = await _getFromCamera();
                              backCard = x as File?;
                              setState(() {});
                            },
                            child: Text(
                              'Upload Ảnh',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            )),
                      ),
                    ),
                  ]),
                )))
      ];
}
