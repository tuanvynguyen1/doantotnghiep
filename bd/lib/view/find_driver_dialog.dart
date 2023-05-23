import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../model/address_book.dart';
import '../services/booking_services.dart';

class FindDriverDialog extends StatefulWidget{
  late int type;
  late AddressBook currentAddressBook;
  FindDriverDialog({super.key,required this.type,required this.currentAddressBook});



  @override
  _FindDriverState createState() => _FindDriverState();

}

class _FindDriverState extends State<FindDriverDialog>{
  get key => null;
  Timer? _timer, _checkDriver;
  int cooldown = 300;
  int? bookingID = null;
  LocationData? currentLocation;

  get currentAddressBook => widget.currentAddressBook;

  get type => widget.type;

  String formatedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }
  void setTime(){
      cooldown -= 1;

      setState(() {

      });
  }
  Future<void> getCurrentLocation() async{
    Location location = Location();
    currentLocation = await location.getLocation();

  }
  Future<int?> bookingDriver() async{
    await getCurrentLocation();
    return BookingServices.sendBookingRequest(currentLocation!.latitude, currentLocation!.longitude, currentAddressBook!.lat, currentAddressBook!.long, type);
  }
  void currentStatus() async{
    if(await BookingServices.isAccept(bookingID) ){
      print('Found Driver');
    }
    else{
      print('Not found');
    }
  }
  @override
  void initState(){
    // TODO: implement initState
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) => setTime());
    bookingDriver().then((value) => {
      bookingID = value
    });
    _checkDriver = Timer.periodic(Duration(seconds: 5), (Timer t) => currentStatus());
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      key: key,
      content:
      cooldown <= 0 ?
      Text('Không tìm thấy tài xế gần bạn!'):Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(

            alignment: Alignment.center,
            padding: const EdgeInsets.only(),
            child: Image.asset('assets/gif/find_driver_loading.gif' ),
          ),
          Text('Đang tìm tài xế'),
          Text(formatedTime(timeInSecond: cooldown)),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStatePropertyAll<Color>(Colors.red),
                  shape:
                  MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          side: BorderSide(color: Colors.red)))),
              onPressed: ()  async {
                Navigator.pop(context);
              },
              child: Text(
                'Hủy',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              )),
        ],
      ),
    );
  }
  
}