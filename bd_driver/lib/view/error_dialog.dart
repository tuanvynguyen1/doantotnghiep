


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget{
  String? Message = "";
  String? Title = "";

  ErrorDialog({super.key, this.Title, this.Message});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery.of(context).size.width;
    var errorIcon = 'assets/icon/icon_error.png';

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(errorIcon),
          Text(Title == null ? "" : Title! ,style: TextStyle(
            fontWeight: FontWeight.bold,
          )),
          SizedBox(height: 10,),
          Text(Message == null ? "" : Message! ,style: TextStyle(
            color: Colors.grey,
            fontSize: 11,
          ),),
          SizedBox(height: 10,),
          ElevatedButton(
              onPressed: (){
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStatePropertyAll<Color>(Colors.red),
                  shape:
                  MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          side: BorderSide(color: Colors.red)))),
              child: Text('Thử lại')
          )

        ],
      ),
    );
  }

}