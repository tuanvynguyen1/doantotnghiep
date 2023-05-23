import 'dart:io';

import 'package:bd/services/authenticator_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../model/user.dart';



class UserPage extends StatefulWidget {
  UserPage({super.key, required this.user});
  late User user;
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _formKey = GlobalKey<FormState>();
  late User user;
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var addressController = TextEditingController();
  File? avatar, frontCard, backCard;
  Future<File> _getAvatar(from) async {
    var pickedFile = await ImagePicker().pickImage(
      source: from == 'camera' ? ImageSource.camera : ImageSource.gallery,
    );
    return File(pickedFile!.path);
  }

  Future<void> _getUserInfo() async {
    final FlutterSecureStorage storage = new FlutterSecureStorage();
    String? value = await storage.read(key: 'Token');
    User temp = await AuthenticatorServices.getInfomation(value);
    setState(() {
      setValue(temp);
    });
  }

  void setValue(User user) {
    emailController.text = user.email;
    nameController.text = user.name;
    addressController.text = user.address;
    user.avatar != null
        ? avatar = File('assets/images/${user.avatar!}')
        : avatar = null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = widget.user;
    setValue(user);
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    var listGender = ['Nam', 'Nữ'];
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text('Thông tin cá nhân')),
        body: Padding(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: RefreshIndicator(
            onRefresh: _getUserInfo,
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Center(
                    child: GestureDetector(
                      child: avatar == null
                          ? CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 80,
                              child: Icon(Icons.person,
                                  color: Colors.white, size: 90),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 80,
                              backgroundImage:
                                  // Icon(Icons.person, color: Colors.white, size: 90),
                                  AssetImage(
                                "assets/images/markeruser.jpg",
                              )),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                title: const Text("Chọn nguồn ảnh"),
                                content: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              _getAvatar('camera');
                                              setState(() {});
                                            },
                                            icon: Icon(Icons.camera)),
                                        const Text("Camera")
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              _getAvatar('folder');
                                              setState(() {});
                                            },
                                            icon: const Icon(Icons.folder)),
                                        const Text("Thư mục")
                                      ],
                                    )
                                  ],
                                )));
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                      readOnly: true,
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        label: const Text(
                          "Email",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        prefixIcon: const Icon(
                          Icons.mail,
                          color: Colors.grey,
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        label: const Text(
                          "Họ tên",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextFormField(

                      controller: addressController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        label: const Text(
                          "Địa chỉ",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        prefixIcon: const Icon(
                          Icons.home,
                          color: Colors.grey,
                        ),
                      )),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: SizedBox(
                      width: double.infinity, //  match_parent
                      height: 50, // match_parent
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.blueAccent),
                              shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                      side: BorderSide(color: Colors.blueAccent)))),
                          onPressed: ()  async {

                          },
                          child: Text(
                            'Cập nhật',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          )),
                    ),
                )
              ],
            ),
          ),
        ));
  }
}
