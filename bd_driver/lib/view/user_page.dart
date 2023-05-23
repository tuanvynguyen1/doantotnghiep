import 'dart:io';

import 'package:bd_driver/services/authenticator_services.dart';
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
  late int _haveChange = 0;
  final imageBASEURL = "http://20.2.66.17:8000/storage";
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var dobController = TextEditingController();
  var genderController = TextEditingController();
  var addressController = TextEditingController();
  var idCardController = TextEditingController();
  File? avatar, frontCard, backCard;
  Future<File> _getAvatar(from) async {

    var pickedFile = await ImagePicker().pickImage(
      source: from == 'camera' ? ImageSource.camera : ImageSource.gallery,
    );
    _haveChange = 1;
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
    dobController.text = user.dob;
    genderController.text = user.gender;
    addressController.text = user.address;
    idCardController.text = user.citizenIdentityCard;

    user.citizenIdentityCardImgFront != null
        ? frontCard = null
        : frontCard = null;
    user.citizenIdentityCardImgBack != null
        ? backCard = null
        : backCard = null;
  }
  ImageProvider getBackground() {
    if(avatar == null ){
      return NetworkImage(imageBASEURL + user!.avatar!);
    }
    return FileImage(avatar!);
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
                      child: user.avatar == null && avatar == null
                          ? CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 80,
                              child: Icon(Icons.person,
                                  color: Colors.white, size: 90),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 80,
                              backgroundImage: getBackground()
                      ),
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
                                            onPressed: () async {
                                              avatar = await _getAvatar('camera');
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
                                            onPressed: () async {
                                              avatar = await _getAvatar('folder');
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
                      readOnly: user.isActive,
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: user.isActive,
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
                      readOnly: user.isActive,
                      controller: nameController,
                      decoration: InputDecoration(
                        filled: user.isActive,
                        fillColor:
                            user.isActive ? Colors.black12 : Colors.white,
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
                      readOnly: widget.user.isActive,
                      controller: dobController,
                      decoration: InputDecoration(
                        filled: widget.user.isActive,
                        fillColor: widget.user.isActive
                            ? Colors.black12
                            : Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        label: const Text(
                          "Ngày tháng năm sinh",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        prefixIcon: const Icon(
                          Icons.cake,
                          color: Colors.grey,
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: !widget.user.isActive
                      ? DropdownButtonFormField(
                          items: listGender.map((String val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(
                                val,
                              ),
                            );
                          }).toList(),
                          value: genderController.text,
                          onChanged: (String? value) {
                            genderController.text = value!;
                          },
                          decoration: InputDecoration(
                            filled: widget.user.isActive,
                            fillColor: widget.user.isActive
                                ? Colors.black12
                                : Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            label: const Text(
                              "Giới tính",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
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
                        )
                      : TextFormField(
                          readOnly: widget.user.isActive,
                          controller: genderController,
                          decoration: InputDecoration(
                            filled: widget.user.isActive,
                            fillColor: widget.user.isActive
                                ? Colors.black12
                                : Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            label: const Text(
                              "Giới tính",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
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
                          )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                      readOnly: widget.user.isActive,
                      controller: addressController,
                      decoration: InputDecoration(
                        filled: widget.user.isActive,
                        fillColor: widget.user.isActive
                            ? Colors.black12
                            : Colors.white,
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
                  padding: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                      readOnly: widget.user.isActive,
                      controller: idCardController,
                      decoration: InputDecoration(
                        filled: widget.user.isActive,
                        fillColor: widget.user.isActive
                            ? Colors.black12
                            : Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        label: const Text(
                          "CMND/CCCD",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        prefixIcon: const Icon(
                          Icons.credit_card,
                          color: Colors.grey,
                        ),
                      )),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text('CMND/CCCD')),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: SafeArea(
                          // child: Image.asset("assets/images/markeruser.jpg", width: deviceWidth/3),
                          child: Image.network(imageBASEURL + user.citizenIdentityCardImgBack, width: deviceWidth/3,)
                        ),
                      ),
                      GestureDetector(

                        child: SafeArea(

                            child: Image.network(imageBASEURL + user.citizenIdentityCardImgFront, width: deviceWidth/3,)

                        ),
                        onTap: (){
                          print('hey');
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: SizedBox(
                      width: double.infinity, //  match_parent
                      height: 50, // match_parent
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStatePropertyAll<Color>(_haveChange == 0 ? Colors.grey : Colors.blueAccent),
                              shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                      side: BorderSide(color: _haveChange == 0 ? Colors.grey : Colors.blueAccent)))),
                          onPressed: ()  async {
                            if(_haveChange == 1){

                            }

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
