import 'dart:async';

import 'package:bd_driver/model/book_pending.dart';
import 'package:bd_driver/services/booking_services.dart';
import 'package:bd_driver/view/on_going_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoundBookingDialog extends StatefulWidget{
  BookPending? b;
  FoundBookingDialog({super.key, this.b});

  @override
  _FoundBookingState createState() => _FoundBookingState();

}

class _FoundBookingState extends State<FoundBookingDialog>{
  Timer? _timer;
  int cooldown = 30;
  String formatedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }
  Future<void> rejectRequest() async{
    await BookingServices.rejectRequest(widget.b!.id);
    Navigator.pop(context);
  }
  void setTime(){
    if(cooldown == 0){
      rejectRequest();
    }
    cooldown -= 1;

    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) => setTime());

    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _timer!.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Text("Yêu cầu mới", style: TextStyle(fontSize: 20),),
            Text(formatedTime(timeInSecond: cooldown)),
            Text('Tên: ${widget.b!.name}'),
            Text('Địa chỉ: ${widget.b!.add1}'),
            Text('Đích đến: ${widget.b!.add2}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.green),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                side: BorderSide(color: Colors.green)))),
                    onPressed: ()  async {
                      BookingServices.acceptRequest(widget.b!.id);
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => OnGoingPage(booking: widget.b)));
                    },
                    child: Text(
                      'Chấp nhận',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.red),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                side: BorderSide(color: Colors.red)))),
                    onPressed: ()  async {
                      await rejectRequest();
                    },
                    child: Text(
                      'Hủy',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    )),
              ],
            )
          ],
        ),
    );
  }

}