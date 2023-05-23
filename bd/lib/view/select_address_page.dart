import 'package:bd/view/address_book_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

import '../services/address_book_services.dart';

class SelectAddressPage extends StatefulWidget{
  @override

    // TODO: implement createState
    @override
    _SelectAddressState createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddressPage>{
  var _formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var latController = TextEditingController();
  var longController = TextEditingController();
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Thêm địa chỉ'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children:  [
              Padding(
                  padding: EdgeInsets.only(top: 40,left: 20, right: 20),
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
                        showDialog(
                            context: context,
                            builder: (c){
                              return selectLocation();
                            }
                        );

                      },
                      child: Text(
                        'Lấy địa chỉ',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      )),
                ),
              ),

              Padding(
                  padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        label: Text(
                          "Tên hiển thị",
                          style: TextStyle(color: Colors.green, fontSize: 14),
                        ),
                        hintText: "Nhập tên hiển thị",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        prefixIcon: Icon(Icons.person)),
                    validator: (str) {
                      if (str == null || str.isEmpty)
                        return "Tên địa chỉ không được rỗng";
                      return null;
                    },
                  ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                child: TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      label: Text(
                        "Địa chỉ",
                        style: TextStyle(color: Colors.green, fontSize: 14),
                      ),
                      hintText: "Nhập địa chỉ",
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      prefixIcon: Icon(Icons.person)),
                  validator: (str) {
                    if (str == null || str.isEmpty)
                      return "Địa chỉ không được rỗng";
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                child: TextFormField(
                  readOnly: true,
                  controller: latController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black12,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      label: Text(
                        "Latitude",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      prefixIcon: Icon(Icons.person, color: Colors.grey,)),
                  validator: (str) {
                    if (str == null || str.isEmpty)
                      return "Latitude không được rỗng";
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                child: TextFormField(
                  readOnly: true,
                  controller: longController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black12,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      label: Text(
                        "Longitude",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      prefixIcon: Icon(Icons.person, color: Colors.grey,)),
                  validator: (str) {
                    if (str == null || str.isEmpty)
                      return "Longitude  không được rỗng";
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40,left: 20, right: 20),
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
                        if (_formKey.currentState!.validate()) {
                          String name = nameController.text;
                          String address = addressController.text;
                          String lat = latController.text;
                          String long = longController.text;
                          AddressBookServices.addAddress(
                              name, address, lat, long);
                        }
                      },
                      child: Text(
                        'Thêm',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      )),
                ),
              ),
            ],
          ),

        ),

      ),
    );
  }
  Widget selectLocation() {
    return Scaffold(

      body: OpenStreetMapSearchAndPick(
        center: LatLong(16.4624112, 107.5752021),
        buttonColor: Colors.blue,
        buttonText: 'Set Current Location',
        onPicked: (pickedData) {

          setState(() {
            latController.text = pickedData.latLong.latitude.toString();
            longController.text = pickedData.latLong.longitude.toString();
            addressController.text = pickedData.address;
          });
          Navigator.pop(context);
        },
      ),
    );
  }
}