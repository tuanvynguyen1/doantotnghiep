


import 'dart:io';

import 'package:bd_driver/services/driver_license_service.dart';
import 'package:bd_driver/view/loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddDriverLicensePage extends StatefulWidget{
  @override
  _addDriverLicenseState createState() => _addDriverLicenseState();

}

class _addDriverLicenseState extends State<AddDriverLicensePage>{
  var _formKey = GlobalKey<FormState>();
  var licenseController = TextEditingController();
  var listRank = ['A1', 'B2'];
  File? front, back;

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Thêm mới bằng lái'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
             children: [
               Padding(
                 padding: EdgeInsets.all(20),
                 child: DropdownButtonFormField(
                   items: listRank.map((String val) {
                     return DropdownMenuItem(
                       value: val,
                       child: Text(
                         val,
                       ),
                     );
                   }).toList(),
                   onChanged: (String? value) {
                     licenseController.text = value!;
                   },
                   decoration: InputDecoration(
                     enabledBorder: OutlineInputBorder(
                       borderSide: const BorderSide(
                           width: 1, color: Colors.grey),
                       borderRadius: BorderRadius.circular(25),
                     ),
                     label: const Text(
                       "Loại bằng lái",
                       style:
                       TextStyle(color: Colors.black, fontSize: 16),
                     ),
                     focusedBorder: OutlineInputBorder(
                       borderSide: const BorderSide(
                           width: 1, color: Colors.grey),
                       borderRadius: BorderRadius.circular(25),
                     ),
                     prefixIcon: const Icon(
                       Icons.add_card_outlined,
                       color: Colors.grey,
                     ),
                   ),
                 ),
               ),
              Text("Mặt trước Bằng lái xe"),
              front != null
                  ? Container(child: Image.file(front!, height: MediaQuery.of(context).size.height * .3))
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
                        front = x;
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
                  child: Text("Mặt sau Bằng lái")),
              back != null
                  ? Container(child: Image.file(back!, height: MediaQuery.of(context).size.height * .3),)
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
                        back = x as File?;
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
                 padding: EdgeInsets.only(top: 40,left: 20, right: 20, bottom: 30),
                 child: SizedBox(
                   width: double.infinity, //  match_parent
                   height: 50, // match_parent
                   child: ElevatedButton(
                       style: ButtonStyle(
                           backgroundColor:
                           MaterialStatePropertyAll<Color>(Colors.blue),
                           shape:
                           MaterialStateProperty.all<RoundedRectangleBorder>(
                               RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(24.0),
                                   side: BorderSide(color: Colors.blue)))),
                       onPressed: ()  async {
                         if (_formKey.currentState!.validate() && back != null && front != null) {
                           String rank = licenseController.text;
                           showDialog(
                               context: context,
                               builder: (c){
                                 return LoadingDialogWidget();
                               }
                           );
                           bool kq = await DriverLicenseService.uploadDriverLicense(rank, back, front);
                           Navigator.pop(context);
                           if(kq == true) Navigator.pop(context);
                         }
                       },
                       child: Text(
                         'Tải lên',
                         textAlign: TextAlign.center,
                         style: TextStyle(fontSize: 16),
                       )),
                 ),
               ),
            ]),
          ),
        ),
    );
  }

}